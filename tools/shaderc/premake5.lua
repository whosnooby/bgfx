include 'defs'

project 'shaderc'
  kind 'consoleapp'
  language 'c++'
  cppdialect 'c++17'

  exceptionhandling 'off'
  rtti 'off'

  targetname 'shaderc'
  targetdir (SHADERC_TARGET_DIR)
  objdir (path.join(SHADERC_TARGET_DIR, 'obj', '%{cfg.buildcfg}'))

  files {
      'shaderc*.cpp',
      'shaderc.h',
  }
  
  includedirs {
      path.join(BX_DIR, 'include'),
      path.join(BIMG_DIR, 'include'),
      path.join(BGFX_DIR, 'include'),

      path.join(BGFX_DIR, '3rdparty', 'directx-headers', 'include'),
      path.join(BGFX_DIR, '3rdparty', 'fcpp'),
      path.join(BGFX_DIR, '3rdparty', 'glsl-optimizer', 'src', 'glsl'),
      path.join(BGFX_DIR, '3rdparty', 'glslang'),
      path.join(BGFX_DIR, '3rdparty', 'glslang', 'glslang', 'Public'),
      path.join(BGFX_DIR, '3rdparty', 'glslang', 'glslang', 'Include'),
      path.join(BGFX_DIR, '3rdparty', 'spirv-cross'),
      path.join(BGFX_DIR, '3rdparty', 'spirv-tools', 'include'),
  }

  libdirs {
    BGFX_BUILD_DIR,
  }

  links {
      'bx',
      'bimg',
      'bgfx',

      'fcpp',
      'glsl-optimizer',
      'glslang',
      'spirv-cross',
      'spirv-tools',
  }

  filter 'system:macosx'
      links { 'Foundation.framework' }
  filter {}
