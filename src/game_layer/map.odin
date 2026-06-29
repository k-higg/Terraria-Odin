package GameLayer 

GameMap :: struct {
    w : i32,
    h : i32,
    map_data : [dynamic]Block,
    wall_data : [dynamic]Block,
}

create_map :: proc(gm: ^GameMap,w, h : i32) {
    gm^ = {}
    gm.w = w
    gm.h = h
    
    resize_dynamic_array(&gm.map_data, int(w * h))
    resize_dynamic_array(&gm.wall_data, int(w * h))
}

get_block_unsafe :: proc(gm: ^GameMap, x, y : i32) -> ^Block {
    perma_assert_comment_development(len(gm.map_data) == int(gm.w * gm.h), "Map data is not initialized")
    
    perma_assert_comment_development(x >= 0 && y >= 0 && x < gm.w && y < gm.h, "GetBlockUnsafe out of bounds error")
    
    return &gm.map_data[x + y * gm.w]
}

get_block_safe :: proc(gm: ^GameMap, x, y: i32) -> ^Block {
    perma_assert_comment_development(len(gm.map_data) == int(gm.w * gm.h), "Map data is not initialized")
    
    if x < 0 || y < 0 || x >= gm.w || y >= gm.h {
        return nil
    }

    return &gm.map_data[x + y * gm.w]
}

get_wall_unsafe :: proc(gm: ^GameMap, x, y: i32) -> ^Block {
    perma_assert_comment_development(len(gm.wall_data) == int(gm.w * gm.h), "Wall data not initialized")
    
    perma_assert_comment_development(x >= 0 && y >= 0 && x < gm.w && y < gm.h, "GetBlockUnsafe out of bounds error")
    
    return &gm.wall_data[x + y * gm.w]
}

get_wall_safe :: proc(gm: ^GameMap, x, y: i32) -> ^Block {
    perma_assert_comment_development(len(gm.wall_data) == int(gm.w * gm.h), "Wall data not initialized")
    
    if (x < 0 || y < 0 || x >= gm.w && y >= gm.h) {
        return nil
    }
    
    return &gm.wall_data[x + y * gm.w]
}