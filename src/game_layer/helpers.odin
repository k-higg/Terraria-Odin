package GameLayer 

import rl "vendor:raylib"

get_texture_atlas :: proc(x, y, cell_size_x, cell_size_y : int) -> rl.Rectangle {
    return rl.Rectangle{f32(x * cell_size_x), f32(y * cell_size_y), f32(cell_size_x), f32(cell_size_y)}
}