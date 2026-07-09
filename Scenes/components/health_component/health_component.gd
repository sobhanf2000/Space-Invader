extends Node

class_name HealthComponent

#Health_Component script

@export var health : int = 0
@export var is_active : bool 
var max_health
var dead: bool

func _ready() -> void:
	max_health = health
	dead = false


func health_change(damage):
	if dead:
		return
		
	if is_active:
		health = health - damage
		health = clamp(health , 0 , max_health)
		
		if health <= 0:
			dead = true
			if owner != get_tree().get_first_node_in_group("player"):
				EventManager.enemies_count(-1 , owner.global_position) 
			death()


func death():
	owner.queue_free()
