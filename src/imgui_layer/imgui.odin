package ImguiLayer 

import imgui "shared:odin-imgui"
import rlimgui "shared:rlimgui"

init_imgui :: proc() {
    imgui.create_context(nil)
    rlimgui.init()
    
    io : = imgui.get_io()
    //io.config_flags |= {imgui.Config_Flag.Nav_Enable_Keyboard}
    //io.config_flags |= {imgui.Config_Flag.Nav_Enable_Gamepad}
    io.config_flags |= {imgui.Config_Flag.Docking_Enable}
    
    imgui_theme()
}

begin_imgui :: proc() {
    rlimgui.process_events()
    rlimgui.new_frame()
    imgui.new_frame()
    
    // Docking
    imgui.push_style_color(imgui.Col.Window_Bg, {})
    imgui.push_style_color(imgui.Col.Docking_Empty_Bg, {})
    imgui.dock_space_over_viewport(imgui.get_main_viewport().id)
    imgui.pop_style_color(2)
    // end Docking

}

end_imgui :: proc () {
    imgui.render()
    rlimgui.render_draw_data(imgui.get_draw_data())
}

shutdown_imgui :: proc () {
    imgui.destroy_context(nil)
    rlimgui.shutdown()
}

imgui_theme :: proc() {
    style : ^imgui.Style = imgui.get_style()
    style.alpha = 1.0
    style.child_rounding = 3
    style.window_rounding = 3
    style.grab_rounding = 1
    style.grab_min_size = 20
    style.frame_rounding = 3
    
    style.colors[imgui.Col.Text] = imgui.Vec4{0.0, 1.0, 1.0, 1.0}
    style.colors[imgui.Col.Text_Disabled] = imgui.Vec4{0.0, 0.4, 0.41, 1.0}
    style.colors[imgui.Col.Window_Bg] = imgui.Vec4{0.0, 0.0, 0.0, 1.0}
    style.colors[imgui.Col.Child_Bg] = imgui.Vec4{0.0, 0.0, 0.0, 0.0}
    style.colors[imgui.Col.Border] = imgui.Vec4{0.0, 1.0, 1.0, 0.65}
    style.colors[imgui.Col.Border_Shadow] = imgui.Vec4{0.0, 0.0, 0.0, 0.0}
    style.colors[imgui.Col.Frame_Bg] = imgui.Vec4{0.44, 0.8, 0.8, 0.18}
    style.colors[imgui.Col.Frame_Bg_Active] = imgui.Vec4{0.44, 0.81, 0.86, 0.66}
    style.colors[imgui.Col.Frame_Bg_Hovered] = imgui.Vec4{0.44, 0.8, 0.8, 0.27}
    style.colors[imgui.Col.Title_Bg] = imgui.Vec4{0.14, 0.18, 0.21, 0.73}
    style.colors[imgui.Col.Title_Bg_Active] = imgui.Vec4{0.0, 1.0, 1.0, 0.27}
    style.colors[imgui.Col.Title_Bg_Collapsed] = imgui.Vec4{0.0, 0.0, 0.0, 0.54}
    style.colors[imgui.Col.Menu_Bar_Bg] = imgui.Vec4{0.0, 0.0, 0.0, 0.2}
    style.colors[imgui.Col.Scrollbar_Bg] = imgui.Vec4{0.22, 0.29, 0.3, 0.71}
    style.colors[imgui.Col.Scrollbar_Grab] = imgui.Vec4{0.0, 1.0, 1.0, 0.44}
    style.colors[imgui.Col.Scrollbar_Grab_Active] = imgui.Vec4{0.0, 1.0, 1.0, 1.0}
    style.colors[imgui.Col.Scrollbar_Grab_Hovered] = imgui.Vec4{0.00, 1.0, 1.0, 0.74}
    style.colors[imgui.Col.Check_Mark] = imgui.Vec4{0.0, 1.0, 1.0, 0.68}
    style.colors[imgui.Col.Slider_Grab] = imgui.Vec4{0.0, 1.0, 1.0, 0.36}
    style.colors[imgui.Col.Slider_Grab_Active] = imgui.Vec4{0.0, 1.0, 1.0, 0.76}
    style.colors[imgui.Col.Button] = imgui.Vec4{0.0, 0.65, 0.65, 0.46}
    style.colors[imgui.Col.Button_Active] = imgui.Vec4{0.0, 1.0, 1.0, 0.62}
    style.colors[imgui.Col.Button_Hovered] = imgui.Vec4{0.01, 1.0, 1.0, 0.43}
    style.colors[imgui.Col.Header] = imgui.Vec4{0.0, 1.0, 1.0, 0.43}
    style.colors[imgui.Col.Header_Active] = imgui.Vec4{0.0, 1.0, 1.0, 0.54}
    style.colors[imgui.Col.Header_Hovered] = imgui.Vec4{0.0, 1.0, 1.0, 0.42}
    style.colors[imgui.Col.Resize_Grip] = imgui.Vec4{0.0, 1.0, 1.0, 0.54}
    style.colors[imgui.Col.Resize_Grip_Active] = imgui.Vec4{0.0, 1.0, 1.0, 1.0}
    style.colors[imgui.Col.Resize_Grip_Hovered] = imgui.Vec4{0.0, 1.0, 1.0, 0.74}
    style.colors[imgui.Col.Plot_Lines] = imgui.Vec4{0.0, 1.0, 1.0, 1.0}
    style.colors[imgui.Col.Plot_Lines_Hovered] = imgui.Vec4{0.0, 1.0, 1.0, 1.0}
    style.colors[imgui.Col.Plot_Histogram] = imgui.Vec4{0.0, 1.0, 1.0, 1.0}
    style.colors[imgui.Col.Plot_Histogram_Hovered] = imgui.Vec4{0.0, 1.0, 1.0, 1.0}
    style.colors[imgui.Col.Text_Selected_Bg] = imgui.Vec4{0.0, 1.0, 1.0, 0.22}
}