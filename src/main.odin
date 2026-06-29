package Terraria

import imgui_layer "imgui_layer"
import game_layer "game_layer"

import rl "vendor:raylib"

Window :: struct {
	width:         i32,
	height:        i32,
	fps:           i32,
	title:         cstring,
	control_flags: rl.ConfigFlags,
}

main :: proc() {
	window := Window{720, 720, 240, "Terraria", rl.ConfigFlags{.WINDOW_RESIZABLE}}
	rl.InitWindow(window.width, window.height, window.title)
	defer rl.CloseWindow()
	
	rl.SetWindowState(window.control_flags)
	rl.SetTargetFPS(window.fps)
	rl.SetExitKey(.KEY_NULL)

	imgui_layer.init_imgui()
	defer imgui_layer.shutdown_imgui()
	
	game_layer.init_game()
	defer game_layer.close_game()
	
	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		defer rl.EndDrawing()
		
		imgui_layer.begin_imgui()
		defer imgui_layer.end_imgui()
		
		if !game_layer.update_game() {
			break
		}
	}
}
