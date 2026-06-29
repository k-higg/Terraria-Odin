package GameLayer

import fn "../third_party"

generate_world :: proc(gm: ^GameMap, seed: u64) {
    w :: 900
    h :: 500
    
    // create game map
    create_map(gm, w, h)
    
    dirt_noise := fn.create_state(i32(seed))
    dirt_noise.noise_type = .Open_Simplex_2
    dirt_noise.fractal_type = .FBM
    dirt_noise.octaves = 1
    dirt_noise.frequency = 0.02
    
    stone_noise := fn.create_state(i32(seed + 1))
    stone_noise.noise_type = .Open_Simplex_2
    stone_noise.fractal_type = .FBM
    stone_noise.octaves = 4
    stone_noise.frequency = 0.01
    
    DIRT_OFFSET_START :: -5
    DIRT_OFFSET_END :: 35
    
    STONE_HEIGHT_START :: 80
    STONE_HEIGHT_END :: 170
    
    for x in 0..<w {
        dirt_value := fn.get_noise_2d(dirt_noise, fn.FNL_Float(x), 0.0) + 1.0 * 0.5
        stone_value := fn.get_noise_2d(stone_noise, fn.FNL_Float(x), 0.0) + 1.0 * 0.5
        
        //Steeper mountains
        //stone_value *= stone_value
        
        dirt_height := int(lerp(f32(DIRT_OFFSET_START), f32(DIRT_OFFSET_END), dirt_value),)
        stone_height := int(lerp(f32(STONE_HEIGHT_START), f32(STONE_HEIGHT_END), stone_value),)
        
        dirt_height = stone_height - dirt_height
        
        for y in 0..<h {
            block : Block = {}
            
            if y > dirt_height {
                block.type = .dirt
            }
            
            if y == dirt_height {
                block.type = .grassBlock
            }
            
            if y >= stone_height {
                block.type = .stone
            }
            
            get_block_unsafe(gm, i32(x), i32(y))^ = block
        }
    }
    
    lerp :: proc(a, b, t: f32) -> f32 {
        return a + (b - a) * t
    }
}