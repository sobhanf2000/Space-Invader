extends Node

@export_range(0.0 ,1.0 ,0.05 ) var drop_rate = 1.0

@export var exp_vial_origin : PackedScene


func _ready() -> void:
	EventManager.enemy_died.connect(on_enemy_died)


func drop_exp_vial(vial_pos: Vector2):
	var random_drop_vial = randf_range(0 , 1)
	
	if random_drop_vial < drop_rate: 
		var exp_vial_instance = exp_vial_origin.instantiate() as Node2D
		exp_vial_instance.global_position = vial_pos
		add_child(exp_vial_instance)


func on_enemy_died(enemy_pos):
	drop_exp_vial(enemy_pos)
	
