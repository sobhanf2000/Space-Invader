extends Node

class_name Weapon

var damage: int = 10
var fire_rate: float = 1.0
var bullet_count: int = 1

var bullet_scene: PackedScene

var cooldown := 0.0

func _process(delta):
	cooldown -= delta

func can_shoot() -> bool:
	return cooldown <= 0

func shoot(origin: Vector2):
	if not can_shoot():
		return

	cooldown = fire_rate

	for i in bullet_count:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = origin
		bullet.damage = damage
		get_tree().current_scene.add_child(bullet)
