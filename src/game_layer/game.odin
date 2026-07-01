package GameLayer 

import "core:os"
import "core:fmt"
import "core:time"
import "core:math"
import "core:math/rand"
import "core:strconv"

import imgui "shared:odin-imgui"

import rl "vendor:raylib"
import rlgl "vendor:raylib/rlgl"

GameData :: struct {
	game_map : GameMap,
	camera : rl.Camera2D,
}

camera_speed : f32 = 10.0

ui_pos : imgui.Vec2
ui_size : imgui.Vec2

// Block Selector
id : [4]u8 = {}
block_id : u16 = 0
block_type : BlockType = BlockType(block_id)
// end Block Selector

seed : i64
rng_state : rand.Default_Random_State
rng : rand.Generator

game_data : GameData = {}
asset_manager : AssetManager = {}

init_game :: proc() {
	seed = time.now()._nsec
	rng_state = rand.create(u64(seed))
	rng = rand.default_random_generator(&rng_state)
	
	load_all_assets(&asset_manager)
	
	generate_world(&game_data.game_map)
	
	game_data.camera.target = {20, 120}
	game_data.camera.rotation = 0.0
	game_data.camera.zoom = 100.0
}

update_game :: proc() -> bool {
	delta_time : f32 = rl.GetFrameTime()
	if delta_time > 1.0 / 5 {
		delta_time = 1 / 5.0
	}
		
	game_data.camera.offset = {f32(rl.GetScreenWidth()) / 2.0, f32(rl.GetScreenHeight()) / 2.0}
	
	rl.ClearBackground({75, 75, 150, 255})
	
	// Camera Movement
	if rl.IsKeyDown(rl.KeyboardKey.UP) {
		game_data.camera.target.y -= camera_speed * delta_time
	}
	if rl.IsKeyDown(rl.KeyboardKey.LEFT) {
		game_data.camera.target.x -= camera_speed * delta_time
	}
	if rl.IsKeyDown(rl.KeyboardKey.DOWN) {
		game_data.camera.target.y += camera_speed * delta_time
	}
	if rl.IsKeyDown(rl.KeyboardKey.RIGHT) {
		game_data.camera.target.x += camera_speed * delta_time
	}
	// end Camera Movement
	
	// Mouse Logic
	world_pos : rl.Vector2 = rl.GetScreenToWorld2D(rl.GetMousePosition(), game_data.camera)
	block_x : i32 = i32(math.floor(world_pos.x))
	block_y : i32 = i32(math.floor(world_pos.y))
	
	mouse_pos : rl.Vector2 = rl.GetMousePosition()
	mouse_over_ui : bool= mouse_pos.x >= ui_pos.x && mouse_pos.x <= ui_pos.x + ui_size.x && mouse_pos.y >= ui_pos.y && mouse_pos.y <= ui_pos.y + ui_size.y
	
	if !mouse_over_ui {
		if rl.IsMouseButtonDown(rl.MouseButton.LEFT) {
			if block_id > 53 && block_id <= u16(BlockType.BLOCKS_COUNT) - 1 {
				w : ^Block = get_wall_safe(&game_data.game_map, block_x, block_y)	
				if w != nil {
					w.type = block_type
					w.variant = u8(get_random_int(rng, 0, 3))
				} 
			} else {
				b : ^Block = get_block_safe(&game_data.game_map, block_x, block_y)
				if b != nil {
					b.type = block_type
					b.variant = u8(get_random_int(rng, 0, 3))
				}
			}
		}
		
		
		if rl.IsMouseButtonDown(rl.MouseButton.RIGHT) {
			if rl.IsKeyDown(rl.KeyboardKey.LEFT_SHIFT) || rl.IsKeyDown(rl.KeyboardKey.RIGHT_SHIFT) {
				w : ^Block = get_wall_safe(&game_data.game_map, block_x, block_y)
				if w != nil {
					w^ = {}
				}
			} else {
				b : ^Block = get_block_safe(&game_data.game_map, block_x, block_y)
				if b != nil {
					b^ = {}
				}
			}
		}
	}
	// end Mouse Logic
	
	rl.BeginMode2D(game_data.camera)
	
	top_left_view := rl.GetScreenToWorld2D({0, 0}, game_data.camera)
	bottom_right_view := rl.GetScreenToWorld2D({f32(rl.GetScreenWidth()), f32(rl.GetScreenHeight())}, game_data.camera)
	
	start_x_view := int(math.floor_f32(top_left_view.x - 1))
	start_y_view := int(math.floor_f32(top_left_view.y - 1))
	end_x_view := int(math.floor_f32(bottom_right_view.x + 1))
	end_y_view := int(math.floor_f32(bottom_right_view.y + 1))
	
	start_x_view = math.clamp(start_x_view, 0, int(game_data.game_map.w) - 1)	
	start_y_view = math.clamp(start_y_view, 0, int(game_data.game_map.h) - 1)	
	end_x_view = math.clamp(end_x_view, 0, int(game_data.game_map.w) - 1)
	end_y_view = math.clamp(end_y_view, 0, int(game_data.game_map.h) - 1)
	
	for y := start_y_view; y <= end_y_view; y += 1 {
		for x := start_x_view; x <= end_x_view; x += 1 {
			b : ^Block = get_block_unsafe(&game_data.game_map, i32(x), i32(y))
			w : ^Block = get_wall_unsafe(&game_data.game_map, i32(x), i32(y))
			
			rl.DrawTexturePro(asset_manager.backgroundTextures, get_texture_atlas(int(w.type), int(w.variant), 32, 32), {f32(x), f32(y), 1, 1}, {0.0, 0.0}, 0.0, rl.WHITE)
			
			if b.type != BlockType.air {
				rl.DrawTexturePro(asset_manager.textures, get_texture_atlas(int(b.type), int(b.variant), 32, 32), {f32(x), f32(y), 1.0, 1.0}, {0.0, 0.0}, 0.0, rl.WHITE)
			}
		}
	}
	
	rl.DrawTexturePro(asset_manager.frame, {0, 0, 32, 32}, {f32(block_x), f32(block_y), 1.0, 1.0}, {0.0, 0.0}, 0.0, rl.WHITE)
	
	rl.EndMode2D()

	// Imgui logic
	
	imgui.begin("Debug Menu")
	imgui.text("Block ID: ")
	imgui.same_line()
	imgui.set_next_item_width(110.0)
	imgui.input_text_with_hint("###block_id", "0 - 71", cstring(&id[0]), len(id))
	imgui.same_line()
	if imgui.small_button("Clear####block_id_clear") {
		id = {}
		block_id = 0
	}
	if len(id) > 0 {
		val, ok := strconv.parse_u64(string(cstring(&id[0])), 10)
		if ok {
			block_id = u16(val)
		}
	}
	block_id = min(block_id, u16(BlockType.BLOCKS_COUNT) - 1)
	block_type = BlockType(block_id)
	imgui.text("Camera Zoom: ")
	imgui.same_line()
	imgui.set_next_item_width(150.0)
	imgui.slider_float("###Camera Zoom", &game_data.camera.zoom, 1.0, 100.0)
	imgui.text("Camera Speed: ")
	imgui.same_line()
	imgui.set_next_item_width(150.0)
	imgui.slider_float("###Camera Speed",  &camera_speed, 5.0, 150.0)
	
	ui_pos = imgui.get_window_pos()
	ui_size = imgui.get_window_size()
	
	imgui.end()
		
	// end Imgui logic
	
	rl.DrawFPS(10, 10)
	
	return true
}

close_game :: proc() {
	unload_all_assets(&asset_manager)
}