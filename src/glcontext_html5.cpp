/*
 * Copyright 2011-2025 Branimir Karadzic. All rights reserved.
 * License: https://github.com/bkaradzic/bgfx/blob/master/LICENSE
 */

#include "bgfx_p.h"

#if BGFX_CONFIG_RENDERER_OPENGLES
#	include "renderer_gl.h"

#	if BGFX_USE_HTML5

#		include "emscripten.h"

// from emscripten gl.c, because we're not going to go
// through egl
extern "C" void* emscripten_GetProcAddress(const char *name_);
extern "C" void* emscripten_webgl1_get_proc_address(const char *name_);
extern "C" void* emscripten_webgl2_get_proc_address(const char *name_);

namespace bgfx { namespace gl
{

#	define GL_IMPORT(_optional, _proto, _func, _import) _proto _func = NULL
#	include "glimports.h"

	static EmscriptenWebGLContextAttributes s_attrs;

	struct SwapChainGL
	{
		SwapChainGL(EMSCRIPTEN_WEBGL_CONTEXT_HANDLE _context, const char* _canvas)
			: m_context(_context)
		{
			size_t length = bx::strLen(_canvas) + 1;
			m_canvas = (char*)bx::alloc(g_allocator, length);
			bx::strCopy(m_canvas, length, _canvas);

			makeCurrent();
			GL_CHECK(glClearColor(0.0f, 0.0f, 0.0f, 0.0f) );
			GL_CHECK(glClear(GL_COLOR_BUFFER_BIT) );
			swapBuffers();
			GL_CHECK(glClear(GL_COLOR_BUFFER_BIT) );
			swapBuffers();
		}

		~SwapChainGL()
		{
			EMSCRIPTEN_CHECK(emscripten_webgl_destroy_context(m_context) );
			bx::free(g_allocator, m_canvas);
		}

		void makeCurrent()
		{
			EMSCRIPTEN_CHECK(emscripten_webgl_make_context_current(m_context) );
		}

		void swapBuffers()
		{
			// There is no swapBuffers equivalent.  A swap happens whenever control is returned back
			// to the browser.
		}

		EMSCRIPTEN_WEBGL_CONTEXT_HANDLE m_context;
		char* m_canvas;
	};

	void GlContext::create(uint32_t _width, uint32_t _height, uint32_t /*_flags*/)
	{
		// assert?
		if (m_primary != NULL)
			return;

		const char* canvas = (const char*) g_platformData.nwh;

		EMSCRIPTEN_WEBGL_CONTEXT_HANDLE context = bx::narrowCast<EMSCRIPTEN_WEBGL_CONTEXT_HANDLE>((uintptr_t) g_platformData.context);
		if (context > 0)
		{
			if (emscripten_webgl_get_context_attributes(context, &s_attrs) >= 0)
			{
				import(s_attrs.majorVersion);
				m_primary = BX_NEW(g_allocator, SwapChainGL)(context, canvas);
			}
			else
			{
				BX_TRACE("Invalid WebGL context. (Canvas handle: '%s', context handle: %d)", canvas, context);
			}
		}
		else
		{
			m_primary = createSwapChain((void*)canvas, (int)_width, (int)_height);
		}

		if (0 != _width
		&&  0 != _height)
		{
			EMSCRIPTEN_CHECK(emscripten_set_canvas_element_size(canvas, (int)_width, (int)_height) );
		}

		makeCurrent(m_primary);
	}

	void GlContext::destroy()
	{
		if (m_primary)
		{
			if (m_current == m_primary)
			{
				m_current = NULL;
			}

			bx::deleteObject(g_allocator, m_primary);
			m_primary = NULL;
		}
	}

	void GlContext::resize(uint32_t _width, uint32_t _height, uint32_t /* _flags */)
	{
		if (m_primary == NULL)
		{
			return;
		}

		EMSCRIPTEN_CHECK(emscripten_set_canvas_element_size(m_primary->m_canvas, (int) _width, (int) _height) );
	}

	SwapChainGL* GlContext::createSwapChain(void* _nwh, int _width, int _height)
	{
		emscripten_webgl_init_context_attributes(&s_attrs);
		BX_UNUSED(_width, _height);

		// Work around bug https://bugs.chromium.org/p/chromium/issues/detail?id=1045643 in Chrome
		// by having alpha always enabled.
		s_attrs.alpha                     = true;
		s_attrs.premultipliedAlpha        = false;
		s_attrs.depth                     = true;
		s_attrs.stencil                   = true;
		s_attrs.enableExtensionsByDefault = true;
		s_attrs.antialias                 = false;

		s_attrs.minorVersion = 0;
		const char* canvas = (const char*) _nwh;
		int32_t error = 0;

		for (int version = 2; version >= 1; --version)
		{
			s_attrs.majorVersion = version;
			EMSCRIPTEN_WEBGL_CONTEXT_HANDLE context = emscripten_webgl_create_context(canvas, &s_attrs);

			if (context > 0)
			{
				EMSCRIPTEN_CHECK(emscripten_webgl_make_context_current(context) );

				SwapChainGL* swapChain = BX_NEW(g_allocator, SwapChainGL)(context, canvas);

				import(version);

				return swapChain;
			}

			error = (int32_t)context;
		}

		BX_TRACE("Failed to create WebGL context. (Canvas handle: '%s', last attempt error %d)", canvas, error);
		BX_UNUSED(error);

		return NULL;
	}

	uint64_t GlContext::getCaps() const
	{
		return BGFX_CAPS_SWAP_CHAIN;
	}

	void GlContext::destroySwapChain(SwapChainGL* _swapChain)
	{
		bx::deleteObject(g_allocator, _swapChain);
	}

	void GlContext::swap(SwapChainGL* /* _swapChain */)
	{
	}

	void GlContext::makeCurrent(SwapChainGL* _swapChain)
	{
		if (m_current != _swapChain)
		{
			m_current = _swapChain;

			if (NULL == _swapChain)
			{
				if (NULL != m_primary)
				{
					m_primary->makeCurrent();
				}
			}
			else
			{
				_swapChain->makeCurrent();
			}
		}
	}

	template<typename Fn>
	static Fn getProcAddress(int _version, const char* _name)
	{
		Fn func = reinterpret_cast<Fn>(emscripten_webgl1_get_proc_address(_name) );
		if (NULL == func && _version >= 2)
		{
			func = reinterpret_cast<Fn>(emscripten_webgl2_get_proc_address(_name) );
		}

		return func;
	}

	void GlContext::import(int _webGLVersion)
	{
		BX_TRACE("Import:");

#	define GL_EXTENSION(_optional, _proto, _func, _import)                          \
	{                                                                               \
		if (NULL == _func)                                                          \
		{                                                                           \
			_func = getProcAddress<_proto>(_webGLVersion, #_import);                \
			BX_TRACE("\t%p " #_func " (" #_import ")", _func);                      \
			BGFX_FATAL(_optional || NULL != _func, Fatal::UnableToInitialize        \
				, "Failed to create WebGL/OpenGLES context. GetProcAddress(\"%s\")" \
				, #_import                                                          \
				);                                                                  \
		}                                                                           \
	}

#	include "glimports.h"

#	undef GL_EXTENSION

	}

} /* namespace gl */ } // namespace bgfx

#	endif // BGFX_USE_EGL
#endif // (BGFX_CONFIG_RENDERER_OPENGLES || BGFX_CONFIG_RENDERER_OPENGL)
