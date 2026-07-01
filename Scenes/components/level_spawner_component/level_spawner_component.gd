extends Node


@export var endless_respawn_timer: Timer 
@export var planets_origin: PackedScene
@export var all_type_enemy_origins:Array[PackedScene] 
@export var enemy_path_follow: PackedScene
@export var enemy_path: Path2D
@export var wave_numbers :int
@export var base_enemy_numbers : int
@export var next_wave_show_ui_origin: PackedScene
@export var boss_origin : PackedScene
@export var boss_position_marker: Marker2D

var current_wave = 1
var Planet_respawn_number = 0
var active_wave: bool = true
var game_entities 
var enemy_numbers


func _ready() -> void:
	enemy_numbers = base_enemy_numbers
	game_entities = get_tree().get_first_node_in_group("game_entities")
	EventManager.endless = false
	EventManager.check_last_wave = false
	endless_respawn_timer.timeout.connect(on_endless_respawn_timer)
	planet_spawner()


func enemy_instantiate():
	enemy_numbers -= 1
	if enemy_numbers > 0:
		var enemy_path_follow_instance = enemy_path_follow.instantiate() 
		enemy_path.add_child(enemy_path_follow_instance)
		var enemy_instance = all_type_enemy_origins.pick_random().instantiate() as Node2D
		if current_wave > 1:
			hardened_enemy_each_wave(enemy_instance)
		EventManager.enemies_count(1 , enemy_instance.global_position)
		enemy_path_follow_instance.add_child(enemy_instance)
	
	
	if EventManager.enemy_count <= 0 and !EventManager.check_last_wave:
		next_wave()
	
	#EventManager.enemies_count(1 ,Vector2.ZERO)


func on_endless_respawn_timer():
	if active_wave:
		enemy_instantiate()
		Planet_respawn_number += 1
		if Planet_respawn_number > 80:
			planet_spawner()
			Planet_respawn_number = 0


func planet_spawner():
	var planet_instance = planets_origin.instantiate()
	add_child(planet_instance)


func next_wave():
	active_wave = false
	current_wave += 1
	var next_wave_show_ui_instance = next_wave_show_ui_origin.instantiate()
	add_child(next_wave_show_ui_instance)
	next_wave_show_ui_instance.wave_label.text = "Wave " + str(current_wave) 
	
	if current_wave <= wave_numbers:
		start_new_wave(current_wave)


func start_new_wave(current_wave: int):
	print(current_wave)
	active_wave = true
	if current_wave < wave_numbers: #start regular wave
		base_enemy_numbers += 5
		enemy_numbers = base_enemy_numbers
	
	if current_wave == wave_numbers: # start boss wave
		var boss_scene_instance = boss_origin.instantiate()
		boss_scene_instance.global_position = boss_position_marker.global_position
		game_entities.add_child(boss_scene_instance)
		EventManager.enemies_count(1 , boss_scene_instance.global_position)
		EventManager.enemy_count = 1
		EventManager.check_last_wave = true
		EventManager.boss_added = true


func hardened_enemy_each_wave(enemy_instance):
	print("enemyhealth: " +str(enemy_instance.health_component.health))
	print("heal1: " + str(enemy_instance.health_component.max_health))
	enemy_instance.health_component.max_health = enemy_instance.health_component.health + current_wave
	enemy_instance.health_component.health_change(-enemy_instance.health_component.max_health)
	print("heal2: " +str(enemy_instance.health_component.max_health))
	print("enemyhealth2: " +str(enemy_instance.health_component.health))
	
