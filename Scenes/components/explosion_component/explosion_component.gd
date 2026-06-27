extends Node

@export var explosion_sprites_origin: PackedScene


func _ready() -> void:
	EventManager.enemy_died.connect(on_enemy_died)


func on_enemy_died(enemy_pos):
	var explosion_instance = explosion_sprites_origin.instantiate()
	explosion_instance.global_position = enemy_pos
	get_tree().current_scene.add_child(explosion_instance)
