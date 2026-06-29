package GameLayer 

import "base:runtime"
import "base:intrinsics"
import "core:fmt"

DEVELOPMENT_BUILD :: ODIN_DEBUG

assert_func_production :: proc(expression: string, loc: runtime.Source_Code_Location, comment := "---") {
    fmt.eprintfln("%s(%d): assertion failed: %s (%s)", loc.file_path, loc.line, expression, comment)
}

assert_func_internal :: proc(expression: string, loc: runtime.Source_Code_Location, comment := "---") {
    fmt.eprintfln("%s(%d): assertion failed: %s (%s)", loc.file_path, loc.line, expression, comment)
    intrinsics.debug_trap()
}

perma_assert :: proc(condition: bool, expression := #caller_expression(condition), loc := #caller_location) {
    if !condition {
        when DEVELOPMENT_BUILD {
            assert_func_internal(expression, loc)
        } else {
            assert_func_production(expression, loc)
        }
    }
}

perma_assert_comment :: proc(condition: bool, comment: string, expression := #caller_expression(condition), loc := #caller_location) {
    if !condition {
        when DEVELOPMENT_BUILD {
            assert_func_internal(expression, loc, comment)
        } else {
            assert_func_production(expression, loc, comment)
        }
    }
}

@(disabled = !DEVELOPMENT_BUILD)
perma_assert_development :: proc(condition: bool, expression := #caller_expression(condition), loc := #caller_location) {
    if !condition {
        assert_func_internal(expression, loc)
    }
}

@(disabled = !DEVELOPMENT_BUILD)
perma_assert_comment_development :: proc(condition: bool, comment: string, expression := #caller_expression(condition), loc := #caller_location) {
    if !condition {
        assert_func_internal(expression, loc, comment)
    }
}