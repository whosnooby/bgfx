BGFX_DIR = path.getabsolute(".")
printf('BGFX_DIR: %s', BGFX_DIR)

------ DEFINTIONS FOR FILE ------
----
-- BGFX_BUILD_DIR - overrides BGFX's build directory.
-- BGFX_OBJ_DIR   - overrides BGFX's intermediate build directory.
----
---------------------------------

if BX_DIR == nil then
    error('BX_DIR not defined')
end
if BIMG_DIR == nil then
    error('BIMG_DIR not defined')
end

function bgfx_link_deps()
  filter 'system:windows'
    links {
      'gdi32',
      'kernel32',
      'psapi',
    }
  filter 'system:macosx'
    links {
      'QuartzCore.framework',
      'Metal.framework',
      'Cocoa.framework',
      'IOKit.framework',
      'CoreVideo.framework',
    }
  filter '*'
end

project 'bgfx'
  kind 'staticlib'
  language 'c++'
  cppdialect 'c++17'

  exceptionhandling 'off'
  rtti 'off'

  targetname('bgfx')
  targetdir(BGFX_BUILD_DIR or 'build/%{prj.config}/bin')
  objdir(BGFX_OBJ_DIR or 'build/%{prj.config}/obj')

  files {
    'include/bgfx/**.h',
    'src/**.cpp',
    'src/**.h',
  }
  removefiles {
    'src/amalgamated.cpp',
  }

  includedirs {
    path.join(BX_DIR, 'include'),
    path.join(BIMG_DIR, 'include'),
  
    '3rdparty',
    '3rdparty/dxsdk/include',
    '3rdparty/khronos',
    'include',
  }

	filter "action:vs*"
		removefiles {
			"src/glcontext_glx.cpp",
			"src/glcontext_egl.cpp",
		}
  filter "system:macosx"
    files {
      "src/*.mm",
    }
    removefiles {
      "src/amalgamated.mm",
    }
  
  bx_include_compat()
