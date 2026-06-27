extends Node


@export var enemies_manager: Node
@export var endless_respawn_timer: Timer 


@export var planets_origin: PackedScene
var Planet_respawn_number = 0

# The enemies spawn positions
@export var initial_position = Vector2(50 , 10)
var enemy_position_x
var enemy_position_y 


# the number of enemies per difficulty level
var difficulty_level = 1
var max_enemies_in_row = 1
var max_enemies_in_column = 4

@export var all_type_enemy_origins:Array[PackedScene] 
var current_type_enemy_origins: Array[PackedScene] = []

func _ready() -> void:
	current_type_enemy_origins.append(all_type_enemy_origins[0])
	EventManager.endless = true
	enemy_position_x = initial_position.x
	enemy_position_y = initial_position.y
	enemy_instantiate()
	endless_respawn_timer.timeout.connect(on_endless_respawn_timer)
	planet_spawner()


func enemy_instantiate():
	var basic_enemy_instance
	enemy_position_x = initial_position.x
	enemy_position_y = initial_position.y
	for row in range(randi_range(1, max_enemies_in_row)):
		enemy_position_y += 40
		enemy_position_x = initial_position.x
		for column in range(randi_range(4, max_enemies_in_column)):
			basic_enemy_instance =  current_type_enemy_origins.pick_random().instantiate()
			basic_enemy_instance.global_position = Vector2(enemy_position_x , enemy_position_y)
			enemies_manager.add_child(basic_enemy_instance)
			EventManager.enemies_count(1 ,Vector2.ZERO)
			enemy_position_x += 50


func on_endless_respawn_timer():
	increase_difficulty()
	Planet_respawn_number += 1
	if Planet_respawn_number > 15:
		planet_spawner()
		Planet_respawn_number = 0
	enemy_instantiate()


func increase_difficulty():
	EventManager.increase_difficulty_emit()
	difficulty_level += 1
	if difficulty_level % 10 == 0:
		add_new_type_enemy()
		if max_enemies_in_column < 8:
			max_enemies_in_column += 1
		if max_enemies_in_row < 3:
			max_enemies_in_row += 1
	if endless_respawn_timer.wait_time > 6 :
		endless_respawn_timer.wait_time -= 0.02
		print("timer: "+ str(endless_respawn_timer.wait_time))


func planet_spawner():
	var planet_instance = planets_origin.instantiate()
	add_child(planet_instance)


func add_new_type_enemy():
	var enemy_number = abs(all_type_enemy_origins.size() - current_type_enemy_origins.size())
	if difficulty_level % 2 == 0 and current_type_enemy_origins.size() < all_type_enemy_origins.size():
		current_type_enemy_origins.append(all_type_enemy_origins[enemy_number])
		print("active:" )
		print(current_type_enemy_origins.size())
