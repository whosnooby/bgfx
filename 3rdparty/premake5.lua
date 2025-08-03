------ DEFINTIONS FOR FILE ------
----
-- BGFX_3RDPARTY_BUILD_DIR_TEMPLATE - build directory template for BGFX's 3rdparty libraries.
-- BGFX_3RDPARTY_OBJ_DIR_TEMPLATE   - intermediate directory template for BGFX's 3rdparty libraries.
----
---------------------------------

if BGFX_3RDPARTY_BUILD_DIR_TEMPLATE == nil then
	BGFX_3RDPARTY_BUILD_DIR_TEMPLATE = path.join(BGFX_BUILD_DIR, 'lib', '%{prj.name}')
else
	BGFX_3RDPARTY_BUILD_DIR_TEMPLATE = path.getabsolute(BGFX_3RDPARTY_BUILD_DIR_TEMPLATE)
end
if BGFX_3RDPARTY_OBJ_DIR_TEMPLATE == nil then
	BGFX_3RDPARTY_OBJ_DIR_TEMPLATE = BGFX_OBJ_DIR
else
	BGFX_3RDPARTY_OBJ_DIR_TEMPLATE = path.getabsolute(BGFX_3RDPARTY_OBJ_DIR_TEMPLATE)
end
printf('BGFX_3RDPARTY_BUILD_DIR_TEMPLATE: %s', BGFX_3RDPARTY_BUILD_DIR_TEMPLATE)
printf('BGFX_3RDPARTY_OBJ_DIR_TEMPLATE: %s', BGFX_3RDPARTY_OBJ_DIR_TEMPLATE)

project 'fcpp'
    kind 'staticlib'
    language 'c'

    targetname 'fpp'
    targetdir (BGFX_3RDPARTY_BUILD_DIR_TEMPLATE)
    objdir (BGFX_3RDPARTY_OBJ_DIR_TEMPLATE)

    files {
        'fcpp/cpp*.c',
        'fcpp/cpp.h',
    }

project 'glsl-optimizer'
    kind 'staticlib'
    language 'c++'

    targetname 'glsl-optimizer'
    targetdir (BGFX_3RDPARTY_BUILD_DIR_TEMPLATE)
    objdir (BGFX_3RDPARTY_OBJ_DIR_TEMPLATE)

    files {
        'glsl-optimizer/src/glsl/glcpp/glcpp.h',
		'glsl-optimizer/src/glsl/glcpp/glcpp-lex.c',
		'glsl-optimizer/src/glsl/glcpp/glcpp-parse.c',
		'glsl-optimizer/src/glsl/glcpp/glcpp-parse.h',
		'glsl-optimizer/src/glsl/glcpp/pp.c',

		'glsl-optimizer/src/glsl/ast.h',
		'glsl-optimizer/src/glsl/ast_array_index.cpp',
		'glsl-optimizer/src/glsl/ast_expr.cpp',
		'glsl-optimizer/src/glsl/ast_function.cpp',
		'glsl-optimizer/src/glsl/ast_to_hir.cpp',
		'glsl-optimizer/src/glsl/ast_type.cpp',
		'glsl-optimizer/src/glsl/builtin_functions.cpp',
		'glsl-optimizer/src/glsl/builtin_type_macros.h',
		'glsl-optimizer/src/glsl/builtin_types.cpp',
		'glsl-optimizer/src/glsl/builtin_variables.cpp',
		'glsl-optimizer/src/glsl/glsl_lexer.cpp',
		'glsl-optimizer/src/glsl/glsl_optimizer.cpp',
		'glsl-optimizer/src/glsl/glsl_optimizer.h',
		'glsl-optimizer/src/glsl/glsl_parser.cpp',
		'glsl-optimizer/src/glsl/glsl_parser.h',
		'glsl-optimizer/src/glsl/glsl_parser_extras.cpp',
		'glsl-optimizer/src/glsl/glsl_parser_extras.h',
		'glsl-optimizer/src/glsl/glsl_symbol_table.cpp',
		'glsl-optimizer/src/glsl/glsl_symbol_table.h',
		'glsl-optimizer/src/glsl/glsl_types.cpp',
		'glsl-optimizer/src/glsl/glsl_types.h',
		'glsl-optimizer/src/glsl/hir_field_selection.cpp',
		'glsl-optimizer/src/glsl/ir.cpp',
		'glsl-optimizer/src/glsl/ir.h',
		'glsl-optimizer/src/glsl/ir_basic_block.cpp',
		'glsl-optimizer/src/glsl/ir_basic_block.h',
		'glsl-optimizer/src/glsl/ir_builder.cpp',
		'glsl-optimizer/src/glsl/ir_builder.h',
		'glsl-optimizer/src/glsl/ir_clone.cpp',
		'glsl-optimizer/src/glsl/ir_constant_expression.cpp',
		'glsl-optimizer/src/glsl/ir_equals.cpp',
		'glsl-optimizer/src/glsl/ir_expression_flattening.cpp',
		'glsl-optimizer/src/glsl/ir_expression_flattening.h',
		'glsl-optimizer/src/glsl/ir_function.cpp',
		'glsl-optimizer/src/glsl/ir_function_can_inline.cpp',
		'glsl-optimizer/src/glsl/ir_function_detect_recursion.cpp',
		'glsl-optimizer/src/glsl/ir_function_inlining.h',
		'glsl-optimizer/src/glsl/ir_hierarchical_visitor.cpp',
		'glsl-optimizer/src/glsl/ir_hierarchical_visitor.h',
		'glsl-optimizer/src/glsl/ir_hv_accept.cpp',
		'glsl-optimizer/src/glsl/ir_import_prototypes.cpp',
		'glsl-optimizer/src/glsl/ir_optimization.h',
		'glsl-optimizer/src/glsl/ir_print_glsl_visitor.cpp',
		'glsl-optimizer/src/glsl/ir_print_glsl_visitor.h',
		'glsl-optimizer/src/glsl/ir_print_metal_visitor.cpp',
		'glsl-optimizer/src/glsl/ir_print_metal_visitor.h',
		'glsl-optimizer/src/glsl/ir_print_visitor.cpp',
		'glsl-optimizer/src/glsl/ir_print_visitor.h',
		'glsl-optimizer/src/glsl/ir_rvalue_visitor.cpp',
		'glsl-optimizer/src/glsl/ir_rvalue_visitor.h',
		'glsl-optimizer/src/glsl/ir_stats.cpp',
		'glsl-optimizer/src/glsl/ir_stats.h',
		'glsl-optimizer/src/glsl/ir_uniform.h',
		'glsl-optimizer/src/glsl/ir_unused_structs.cpp',
		'glsl-optimizer/src/glsl/ir_unused_structs.h',
		'glsl-optimizer/src/glsl/ir_validate.cpp',
		'glsl-optimizer/src/glsl/ir_variable_refcount.cpp',
		'glsl-optimizer/src/glsl/ir_variable_refcount.h',
		'glsl-optimizer/src/glsl/ir_visitor.h',
		'glsl-optimizer/src/glsl/link_atomics.cpp',
		'glsl-optimizer/src/glsl/link_functions.cpp',
		'glsl-optimizer/src/glsl/link_interface_blocks.cpp',
		'glsl-optimizer/src/glsl/link_uniform_block_active_visitor.cpp',
		'glsl-optimizer/src/glsl/link_uniform_block_active_visitor.h',
		'glsl-optimizer/src/glsl/link_uniform_blocks.cpp',
		'glsl-optimizer/src/glsl/link_uniform_initializers.cpp',
		'glsl-optimizer/src/glsl/link_uniforms.cpp',
		'glsl-optimizer/src/glsl/link_varyings.cpp',
		'glsl-optimizer/src/glsl/link_varyings.h',
		'glsl-optimizer/src/glsl/linker.cpp',
		'glsl-optimizer/src/glsl/linker.h',
		'glsl-optimizer/src/glsl/list.h',
		'glsl-optimizer/src/glsl/loop_analysis.cpp',
		'glsl-optimizer/src/glsl/loop_analysis.h',
		'glsl-optimizer/src/glsl/loop_controls.cpp',
		'glsl-optimizer/src/glsl/loop_unroll.cpp',
		'glsl-optimizer/src/glsl/lower_clip_distance.cpp',
		'glsl-optimizer/src/glsl/lower_discard.cpp',
		'glsl-optimizer/src/glsl/lower_discard_flow.cpp',
		'glsl-optimizer/src/glsl/lower_if_to_cond_assign.cpp',
		'glsl-optimizer/src/glsl/lower_instructions.cpp',
		'glsl-optimizer/src/glsl/lower_jumps.cpp',
		'glsl-optimizer/src/glsl/lower_mat_op_to_vec.cpp',
		'glsl-optimizer/src/glsl/lower_named_interface_blocks.cpp',
		'glsl-optimizer/src/glsl/lower_noise.cpp',
		'glsl-optimizer/src/glsl/lower_offset_array.cpp',
		'glsl-optimizer/src/glsl/lower_output_reads.cpp',
		'glsl-optimizer/src/glsl/lower_packed_varyings.cpp',
		'glsl-optimizer/src/glsl/lower_packing_builtins.cpp',
		'glsl-optimizer/src/glsl/lower_ubo_reference.cpp',
		'glsl-optimizer/src/glsl/lower_variable_index_to_cond_assign.cpp',
		'glsl-optimizer/src/glsl/lower_vec_index_to_cond_assign.cpp',
		'glsl-optimizer/src/glsl/lower_vec_index_to_swizzle.cpp',
		'glsl-optimizer/src/glsl/lower_vector.cpp',
		'glsl-optimizer/src/glsl/lower_vector_insert.cpp',
		'glsl-optimizer/src/glsl/lower_vertex_id.cpp',
		'glsl-optimizer/src/glsl/opt_algebraic.cpp',
		'glsl-optimizer/src/glsl/opt_array_splitting.cpp',
		'glsl-optimizer/src/glsl/opt_constant_folding.cpp',
		'glsl-optimizer/src/glsl/opt_constant_propagation.cpp',
		'glsl-optimizer/src/glsl/opt_constant_variable.cpp',
		'glsl-optimizer/src/glsl/opt_copy_propagation.cpp',
		'glsl-optimizer/src/glsl/opt_copy_propagation_elements.cpp',
		'glsl-optimizer/src/glsl/opt_cse.cpp',
		'glsl-optimizer/src/glsl/opt_dead_builtin_variables.cpp',
		'glsl-optimizer/src/glsl/opt_dead_builtin_varyings.cpp',
		'glsl-optimizer/src/glsl/opt_dead_code.cpp',
		'glsl-optimizer/src/glsl/opt_dead_code_local.cpp',
		'glsl-optimizer/src/glsl/opt_dead_functions.cpp',
		'glsl-optimizer/src/glsl/opt_flatten_nested_if_blocks.cpp',
		'glsl-optimizer/src/glsl/opt_flip_matrices.cpp',
		'glsl-optimizer/src/glsl/opt_function_inlining.cpp',
		'glsl-optimizer/src/glsl/opt_if_simplification.cpp',
		'glsl-optimizer/src/glsl/opt_minmax.cpp',
		'glsl-optimizer/src/glsl/opt_noop_swizzle.cpp',
		'glsl-optimizer/src/glsl/opt_rebalance_tree.cpp',
		'glsl-optimizer/src/glsl/opt_redundant_jumps.cpp',
		'glsl-optimizer/src/glsl/opt_structure_splitting.cpp',
		'glsl-optimizer/src/glsl/opt_swizzle_swizzle.cpp',
		'glsl-optimizer/src/glsl/opt_tree_grafting.cpp',
		'glsl-optimizer/src/glsl/opt_vectorize.cpp',
		'glsl-optimizer/src/glsl/program.h',
		'glsl-optimizer/src/glsl/s_expression.cpp',
		'glsl-optimizer/src/glsl/s_expression.h',
		'glsl-optimizer/src/glsl/standalone_scaffolding.cpp',
		'glsl-optimizer/src/glsl/standalone_scaffolding.h',
		'glsl-optimizer/src/glsl/strtod.c',
		'glsl-optimizer/src/glsl/strtod.h',

		'glsl-optimizer/src/mesa/main/compiler.h',
		'glsl-optimizer/src/mesa/main/config.h',
		'glsl-optimizer/src/mesa/main/context.h',
		'glsl-optimizer/src/mesa/main/core.h',
		'glsl-optimizer/src/mesa/main/dd.h',
		'glsl-optimizer/src/mesa/main/errors.h',
		'glsl-optimizer/src/mesa/main/glheader.h',
		'glsl-optimizer/src/mesa/main/glminimal.h',
		'glsl-optimizer/src/mesa/main/imports.c',
		'glsl-optimizer/src/mesa/main/imports.h',
		'glsl-optimizer/src/mesa/main/macros.h',
		'glsl-optimizer/src/mesa/main/mtypes.h',
		'glsl-optimizer/src/mesa/main/simple_list.h',

		'glsl-optimizer/src/mesa/program/hash_table.h',
		'glsl-optimizer/src/mesa/program/prog_hash_table.c',
		'glsl-optimizer/src/mesa/program/prog_instruction.h',
		'glsl-optimizer/src/mesa/program/prog_parameter.h',
		'glsl-optimizer/src/mesa/program/prog_statevars.h',
		'glsl-optimizer/src/mesa/program/symbol_table.c',
		'glsl-optimizer/src/mesa/program/symbol_table.h',

		'glsl-optimizer/src/util/hash_table.c',
		'glsl-optimizer/src/util/hash_table.h',
		'glsl-optimizer/src/util/macros.h',
		'glsl-optimizer/src/util/ralloc.c',
		'glsl-optimizer/src/util/ralloc.h',
    }

    removefiles {
		'glsl-optimizer/src/glsl/main.cpp',

		'glsl-optimizer/src/glsl/glcpp/**.l',
		'glsl-optimizer/src/glsl/glcpp/**.y',
	}

    includedirs {
        'glsl-optimizer/include/',

        'glsl-optimizer/src/',
        'glsl-optimizer/src/glsl/',
        'glsl-optimizer/src/mesa/',
    }

project 'glslang'
    kind 'staticlib'
    language 'c++'
    cppdialect 'c++17'

    targetname 'glslang'
    targetdir (BGFX_3RDPARTY_BUILD_DIR_TEMPLATE)
    objdir (BGFX_3RDPARTY_OBJ_DIR_TEMPLATE)

    defines { 'ENABLE_HLSL', 'ENABLE_OPT' }

    files {
        'glslang/glslang/**.cpp',
        'glslang/glslang/**.h',
        'glslang/SPIRV/**.cpp',
        'glslang/SPIRV/**.h',
    }

    filter 'system:windows'
        removefiles { 'glslang/glslang/OSDependent/Unix/**' }
    filter 'not system:windows'
        removefiles { 'glslang/glslang/OSDependent/Windows/**' }
    filter {}

    includedirs {
        '.', -- this confuses me, but it's in the shaderc.lua genie script
        'glslang/',
        'spirv-tools/include',
        'spirv-tools/source',
    }

project 'spirv-cross'
    kind 'staticlib'
    language 'c'

    targetname 'spirv-cross'
    targetdir (BGFX_3RDPARTY_BUILD_DIR_TEMPLATE)
    objdir (BGFX_3RDPARTY_OBJ_DIR_TEMPLATE)

    defines { 'SPIRV_CROSS_EXCEPTIONS_TO_ASSERTIONS' }

    files {
        'spirv-cross/spirv.hpp',
		'spirv-cross/spirv_cfg.cpp',
		'spirv-cross/spirv_cfg.hpp',
		'spirv-cross/spirv_common.hpp',
		'spirv-cross/spirv_cpp.cpp',
		'spirv-cross/spirv_cpp.hpp',
		'spirv-cross/spirv_cross.cpp',
		'spirv-cross/spirv_cross.hpp',
		'spirv-cross/spirv_cross_parsed_ir.cpp',
		'spirv-cross/spirv_cross_parsed_ir.hpp',
		'spirv-cross/spirv_cross_util.cpp',
		'spirv-cross/spirv_cross_util.hpp',
		'spirv-cross/spirv_glsl.cpp',
		'spirv-cross/spirv_glsl.hpp',
		'spirv-cross/spirv_hlsl.cpp',
		'spirv-cross/spirv_hlsl.hpp',
		'spirv-cross/spirv_msl.cpp',
		'spirv-cross/spirv_msl.hpp',
		'spirv-cross/spirv_parser.cpp',
		'spirv-cross/spirv_parser.hpp',
		'spirv-cross/spirv_reflect.cpp',
		'spirv-cross/spirv_reflect.hpp',
    }

    includedirs {
        'spirv-cross/include',
    }

project 'spirv-tools'
    kind 'staticlib'
    language 'c++'
    cppdialect 'c++17'

    targetname 'spirv-tools'
    targetdir (BGFX_3RDPARTY_BUILD_DIR_TEMPLATE)
    objdir (BGFX_3RDPARTY_OBJ_DIR_TEMPLATE)

    files {
        'spirv-tools/source/opt/**.cpp',
		'spirv-tools/source/opt/**.h',
		'spirv-tools/source/reduce/**.cpp',
		'spirv-tools/source/reduce/**.h',
		'spirv-tools/source/val/**.cpp',
		'spirv-tools/source/val/**.h',

		-- libspirv
		'spirv-tools/source/assembly_grammar.cpp',
		'spirv-tools/source/assembly_grammar.h',
		'spirv-tools/source/binary.cpp',
		'spirv-tools/source/binary.h',
		'spirv-tools/source/cfa.h',
		'spirv-tools/source/diagnostic.cpp',
		'spirv-tools/source/diagnostic.h',
		'spirv-tools/source/disassemble.cpp',
		'spirv-tools/source/disassemble.h',
		'spirv-tools/source/enum_set.h',
		'spirv-tools/source/ext_inst.cpp',
		'spirv-tools/source/ext_inst.h',
		'spirv-tools/source/extensions.cpp',
		'spirv-tools/source/extensions.h',
		'spirv-tools/source/instruction.h',
		'spirv-tools/source/latest_version_glsl_std_450_header.h',
		'spirv-tools/source/latest_version_opencl_std_header.h',
		'spirv-tools/source/latest_version_spirv_header.h',
		'spirv-tools/source/libspirv.cpp',
		'spirv-tools/source/macro.h',
		'spirv-tools/source/name_mapper.cpp',
		'spirv-tools/source/name_mapper.h',
		'spirv-tools/source/opcode.cpp',
		'spirv-tools/source/opcode.h',
		'spirv-tools/source/operand.cpp',
		'spirv-tools/source/operand.h',
		'spirv-tools/source/parsed_operand.cpp',
		'spirv-tools/source/parsed_operand.h',
		'spirv-tools/source/print.cpp',
		'spirv-tools/source/print.h',
		'spirv-tools/source/software_version.cpp',
		'spirv-tools/source/spirv_constant.h',
		'spirv-tools/source/spirv_definition.h',
		'spirv-tools/source/spirv_endian.cpp',
		'spirv-tools/source/spirv_endian.h',
		'spirv-tools/source/spirv_optimizer_options.cpp',
		'spirv-tools/source/spirv_reducer_options.cpp',
		'spirv-tools/source/spirv_target_env.cpp',
		'spirv-tools/source/spirv_target_env.h',
		'spirv-tools/source/spirv_validator_options.cpp',
		'spirv-tools/source/spirv_validator_options.h',
		'spirv-tools/source/table.cpp',
		'spirv-tools/source/table.h',
		'spirv-tools/source/table2.cpp',
		'spirv-tools/source/table2.h',
		'spirv-tools/source/text.cpp',
		'spirv-tools/source/text.h',
		'spirv-tools/source/text_handler.cpp',
		'spirv-tools/source/text_handler.h',
		'spirv-tools/source/to_string.cpp',
		'spirv-tools/source/to_string.h',
		'spirv-tools/source/util/bit_vector.cpp',
		'spirv-tools/source/util/bit_vector.h',
		'spirv-tools/source/util/bitutils.h',
		'spirv-tools/source/util/hex_float.h',
		'spirv-tools/source/util/parse_number.cpp',
		'spirv-tools/source/util/parse_number.h',
		'spirv-tools/source/util/string_utils.cpp',
		'spirv-tools/source/util/string_utils.h',
		'spirv-tools/source/util/timer.h',
    }

    includedirs {
        'spirv-tools/',
        'spirv-tools/include/',
        'spirv-tools/include/generated',
        'spirv-tools/source',

        'spirv-headers/include',
    }

