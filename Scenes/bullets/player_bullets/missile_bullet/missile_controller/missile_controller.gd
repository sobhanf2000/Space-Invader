extends Node


@export var missile_origin: PackedScene

var missile_shoot_cooldown = 0

@onready var barrel: Marker2D = $"../Barrel"

var damage

func _ready() -> void:
	EventManager.upgrade_weapon.connect(on_upgrade_weapon)
	damage = 3


func _physics_process(delta: float) -> void:
	missile_shoot_cooldown += 10 * delta
	if missile_shoot_cooldown > 10:
		var missile_instance = missile_origin.instantiate() as Node2D
		missile_instance.global_position = barrel.global_position
		add_child(missile_instance)
		missile_instance.hit_box_component.damage = damage
		missile_shoot_cooldown = 0
		await get_tree().create_timer(5).timeout
		if missile_instance != null:
			missile_instance.queue_free()


func on_upgrade_weapon(upgraded_weapon , current_weapons_list):
	if upgraded_weapon["weapon"] == "missile":
		for weapon in current_weapons_list:
			if weapon["weapon"] == "missile":
				damage = weapon["damage"]
				print("missile damage: " + str(damage))
				break
