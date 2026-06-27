extends CanvasLayer

@onready var play_button: Button = $Main_Menu_list/Play_Button
@onready var exit_button: Button = $Main_Menu_list/Exit_Button
@onready var play_infinity_button: Button = $Level_Menu/Play_Infinity_Button
@onready var play_level_button_1: Button = $Level_Menu/Play_Level_Button_1
@onready var play_level_button_2: Button = $Level_Menu/Play_Level_Button_2
@onready var play_level_button_3: Button = $Level_Menu/Play_Level_Button_3
@onready var play_level_button_4: Button = $Level_Menu/Play_Level_Button_4
@onready var play_level_button_5: Button = $Level_Menu/Play_Level_Button_5
@onready var play_level_button_6: Button = $Level_Menu/Play_Level_Button_6
@onready var back_to_main_button: Button = $Level_Menu/Back_To_Main_Button

@onready var main_menu_list: CanvasLayer = $Main_Menu_list
@onready var level_menu: CanvasLayer = $Level_Menu


func _ready() -> void:
	play_button.pressed.connect(on_play_pressed)
	exit_button.pressed.connect(on_exit_pressed)
	
	play_infinity_button.pressed.connect(on_play_infinity_pressed)
	play_level_button_1.pressed.connect(on_play_level_pressed.bind(1))
	play_level_button_2.pressed.connect(on_play_level_pressed.bind(2))
	play_level_button_3.pressed.connect(on_play_level_pressed.bind(3))
	play_level_button_4.pressed.connect(on_play_level_pressed.bind(4))

	
	back_to_main_button.pressed.connect(on_back_to_main_pressed)
	
	
func on_play_pressed():
	level_menu.visible = true
	main_menu_list.visible = false


func on_exit_pressed():
	get_tree().quit()


func on_play_level_pressed(level_number: int):
	match level_number:
		1:
			get_tree().change_scene_to_file("res://Scenes/Levels/Levels/level1/level_1.tscn")
		2:
			get_tree().change_scene_to_file("res://Scenes/Levels/Levels/level2/level_2.tscn")
		3:
			get_tree().change_scene_to_file("res://Scenes/Levels/Levels/level3/level_3.tscn")
		4:
			get_tree().change_scene_to_file("res://Scenes/Levels/Levels/level4/level_4.tscn")
		_:
			print("null")


func on_back_to_main_pressed():
	level_menu.visible = false
	main_menu_list.visible = true


func on_play_infinity_pressed():
	get_tree().change_scene_to_file("res://Scenes/game_objects/main/main.tscn")
