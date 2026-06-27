extends Node

@export_range(0.0 ,1.0 ,0.05 ) var drop_rate = 1.0
@export var health_tool_origin : PackedScene
var offset

func _ready() -> void:
	EventManager.enemy_died.connect(on_enemy_died)


func drop_exp_tool(tool_pos: Vector2):
	var random_drop_tool = randf_range(0 , 1)
	offset = Vector2.ONE * randf_range(-20 , 20)
	
	if random_drop_tool < drop_rate: 
		var health_tool_instance = health_tool_origin.instantiate() as Node2D
		health_tool_instance.global_position = tool_pos + offset
		add_child(health_tool_instance)


func on_enemy_died(enemy_pos):
	drop_exp_tool(enemy_pos)
