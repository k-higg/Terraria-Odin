package GameLayer 

import rand "core:math/rand"
import time "core:time"

get_random_float :: proc(rng: rand.Generator, min, max: f32) -> f32 {
    return rand.float32_range(min, max, rng)
}

get_random_int :: proc(rng: rand.Generator, min, max: int) -> int {
    return rand.int_max(max - min, rng) + min
}

get_random_chance :: proc(rng: rand.Generator, chance: f32) -> bool {
    dice := get_random_float(rng, 0.0, 1.0) 
    return dice <= chance
}