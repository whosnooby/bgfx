if BX_DIR == nil then
  error('shaderc depends on BX')
elseif BGFX_DIR == nil then
  error('shaderc depends on BGFX')
end

function shaderc_get_build_dir_name()
  if _TARGET_OS == 'linux' then return 'linux' 
  elseif _TARGET_OS == 'windows' then return 'windows' 
  elseif _TARGET_OS == 'macosx' then return 'darwin'
  else error('unsupported target for shaderc') end
end

SHADERC_DIR = path.getabsolute('')
printf('SHADERC_DIR: %s', SHADERC_DIR)
SHADERC_TARGET_DIR = path.join(BGFX_DIR, 'tools', 'bin', shaderc_get_build_dir_name())
printf('SHADERC_TARGET_DIR: %s', SHADERC_TARGET_DIR)

function shaderc_get_target_platform_name()
  if _TARGET_OS == 'linux' then return 'linux' 
  elseif _TARGET_OS == 'windows' then return 'windows' 
  elseif _TARGET_OS == 'macosx' then return 'osx'
  else error('unsupported target for shaderc') end
end

function shaderc_get_target_profile_name(linux, windows)
  linux = linux or error('must supply linux shader directory')
  windows = windows or error('must supply windows shader directory')
  if _TARGET_OS == 'linux' then return linux
  elseif _TARGET_OS == 'windows' then return windows
  elseif _TARGET_OS == 'macosx' then return 'metal'
  else error('unsupported target for shaderc') end
end

SHADERC_OUTPUT_FILE = path.join(SHADERC_TARGET_DIR, 'shaderc')
if _TARGET_OS == 'windows' then SHADERC_OUTPUT_FILE = SHADERC_OUTPUT_FILE .. '.exe' end

function shaderc_get_compile_command(shader_output_template, linux_shader_dir, windows_shader_dir)
  shader_output_template = shader_output_template or error('no shader output template')
  linux_shader_dir = linux_shader_dir or error('must supply linux shader directory')
  windows_shader_dir = windows_shader_dir or error('must supply windows shader directory')
  return SHADERC_OUTPUT_FILE .. ' ' ..
      '--type %{string.sub(file.name, 1, 1)} ' ..
      '-i ' .. path.join(BGFX_DIR, 'src') .. ' ' ..
      '--platform ' .. shaderc_get_target_platform_name() .. ' ' ..
      '-p ' .. shaderc_get_target_profile_name(linux_shader_dir, windows_shader_dir) .. ' ' ..
      '--varyingdef %[%{!file.directory}/varying.def.sc]' .. ' ' ..
      '-f %[%{file.abspath}]' .. ' ' ..
      '-o ' .. shader_output_template
end