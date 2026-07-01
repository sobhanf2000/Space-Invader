extends CanvasLayer

@onready var resume_button: Button = $Resume_Button
@onready var restart_button: Button = $Restart_Button
@onready var exit_button: Button = $Exit_Button
@onready var back_to_menu_button: Button = $Back_To_Menu_Button


func _ready() -> void:
	resume_button.pressed.connect(on_resume_button_clicked)
	restart_button.pressed.connect(on_restart_button_clicked)
	exit_button.pressed.connect(on_exit_button_clicked)
	back_to_menu_button.pressed.connect(on_back_to_menu_button_clicked)


func on_resume_button_clicked():
	Engine.time_scale = 1
	get_tree().paused = false
	self.visible = false


func on_restart_button_clicked():
	Engine.time_scale = 1
	get_tree().paused = false
	EventManager.enemy_count = 0
	get_tree().reload_current_scene()


func on_back_to_menu_button_clicked():
	Engine.time_scale = 1
	EventManager.enemy_count = 0
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/game_objects/main_menu/main_menu.tscn")


func on_exit_button_clicked():
	get_tree().quit()
