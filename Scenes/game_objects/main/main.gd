extends Node2D


@export var end_game_ui_origin : PackedScene
@onready var end_game_as: AudioStreamPlayer2D = $EndGame_AS
@onready var back_ground_as: AudioStreamPlayer2D = $BackGround_AS
@onready var endless_respawn_timer: Timer = $Timer

var audio_played = false


func _ready() -> void:
	EventManager.game_over.connect(on_game_over)
	EventManager.win_game.connect(on_win_game)


func on_win_game():
	await get_tree().create_timer(6).timeout
	var end_game_ui_instance = end_game_ui_origin.instantiate()
	add_child(end_game_ui_instance)
	end_game_ui_instance.end_game_label.text = "Won Game"
	back_ground_as.stop()
	get_tree().paused = true


func on_game_over():
	var end_game_ui_instance = end_game_ui_origin.instantiate()
	add_child(end_game_ui_instance)
	end_game_ui_instance.end_game_label.text = "GameOver"
	if !audio_played:
		end_game_as.play()
		audio_played = true
	Engine.time_scale = 0.4
	back_ground_as.stop()
	await get_tree().create_timer(1.6).timeout
	get_tree().paused = true
