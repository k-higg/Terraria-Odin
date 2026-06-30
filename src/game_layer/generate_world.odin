package GameLayer

import fn "../third_party"
import rand "core:math/rand"
import math "core:math"

generate_world :: proc(gm: ^GameMap) {
    w :: 900
    h :: 500
    
    // create game map
    create_map(gm, w, h)
    
    seed := i32(rand.uint64(rng)) + 1
    rand_state := rand.create(u64(seed))
    rand_gen := rand.default_random_generator(&rand_state)
    
    dirt_noise := fn.create_state(seed + 1)
    dirt_noise.noise_type = .Open_Simplex_2
    dirt_noise.fractal_type = .FBM
    dirt_noise.octaves = 6
    dirt_noise.gain = 0.04
    dirt_noise.frequency = 0.01
    
    cave_noise := fn.create_state(seed + 1)
    cave_noise.noise_type = .Value_Cubic
    cave_noise.octaves = 3
    cave_noise.frequency = 0.02
    
    DIRT_OFFSET_START :: -5
    DIRT_OFFSET_END :: 35
    
    STONE_HEIGHT_START :: 60
    STONE_HEIGHT_END :: 120
    
    DESERT_WIDTH_MIN :: 100
    DESERT_WIDTH_MAX :: 100
    
    desert_start := get_random_int(rand_gen, 10, w - 210)
    desert_end := desert_start + DESERT_WIDTH_MIN + get_random_int(rand_gen, 0, DESERT_WIDTH_MAX)
    
    keep_direction_time_stone := get_random_int(rand_gen, 5, 40)
    direction_stone := get_random_int(rand_gen, -2, 2)
    
    stone_height := 90
    
    get_cave_noise := proc(noise: fn.FNL_State, x, y: int) -> f32 {
        return fn.get_noise_2d(noise, fn.FNL_Float(x), fn.FNL_Float(y))
    }
    
    for x in 0..<w {
        
        in_desert : bool = (x >= desert_start && x <= desert_end)
        
        // Stone Height
        
        keep_direction_time_stone -= 1
        if keep_direction_time_stone <= 0 {
            keep_direction_time_stone = get_random_int(rand_gen, 5, 40)
            direction_stone = get_random_int(rand_gen, -2, 2)
        }
        
        if direction_stone == -1 {
            if get_random_chance(rand_gen, 0.25) {
                stone_height -= 1
            }
        } else if direction_stone == -2 {
            if get_random_chance(rand_gen, 0.25) {
                stone_height -= 1
            }
            if get_random_chance(rand_gen, 0.25) {
                stone_height -= 1
            }               
        } else if direction_stone == 1 {
            if get_random_chance(rand_gen, 0.25) {
                stone_height += 1
            }        
        } else if direction_stone == 2 {
            if get_random_chance(rand_gen, 0.25) {
                stone_height += 1
            }
            if get_random_chance(rand_gen, 0.25) {
                stone_height += 1
            }
        }
    
        if stone_height < STONE_HEIGHT_START {
            stone_height = STONE_HEIGHT_START
        }
        
        if stone_height > STONE_HEIGHT_END {
            stone_height = STONE_HEIGHT_END
        }
        
        // end Stone Height
        
        dirt_value : f32 = fn.get_noise_2d(dirt_noise, fn.FNL_Float(x), 0.0) + 1.0 * 0.5
        dirt_height : int = int(lerp(f32(DIRT_OFFSET_START), f32(DIRT_OFFSET_END), dirt_value),)
        
        dirt_height = stone_height - dirt_height
        
        dirt_type : BlockType = BlockType.dirt
        grass_type : BlockType= BlockType.grassBlock
        stone_type : BlockType= BlockType.stone
        
        if in_desert {
            dirt_type = BlockType.sand
            grass_type = BlockType.sand 
            stone_type = BlockType.sandStone
        }
        
        for y in 0..<h {
            block : Block = {}
            
            if y > dirt_height {
                block.type = dirt_type
            }
            
            if y == dirt_height {
                block.type = grass_type
            }
            
            if y >= stone_height {
                block.type = stone_type
            }
            
            if in_desert {
                desert_mid : int = (desert_start + desert_end) / 2
                desert_half_width : int = (desert_end - desert_start) / 2
                distance_from_desert_mid : int = abs(x - desert_mid)
                
                desert_distance : f32 = f32(1 - distance_from_desert_mid / desert_half_width)
                
                desert_distance = math.clamp(desert_distance, 0, 1)
                desert_distance = math.pow(desert_distance, 0.5)
                
                desert_stone_start : int= 10 + stone_height
                desert_stone_depth : int= 20 + stone_height
                
                triangle_stone_y : int = desert_stone_start + int(desert_distance) * desert_stone_depth
                 
                if y > triangle_stone_y {
                    block.type = .stone
                }
            }
            
            if get_cave_noise(cave_noise, x, y) > 0.3 {
                block.type = .air
            }
            
            get_block_unsafe(gm, i32(x), i32(y))^ = block
        }
    }
    
    lerp :: proc(a, b, t: f32) -> f32 {
        return a + (b - a) * t
    }
}