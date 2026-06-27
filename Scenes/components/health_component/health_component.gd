extends Node

class_name HealthComponent

@export var health : int = 0
@export var is_active : bool 
var max_health


func _ready() -> void:
	max_health = health


func health_change(damage):
	if is_active:
		health = health - damage
		health = clamp(health , 0 , max_health)
		
		if health <= 0:
			if owner != get_tree().get_first_node_in_group("player"):
				EventManager.enemies_count(-1 , owner.global_position) 
			death()


func death():
	owner.queue_free()
