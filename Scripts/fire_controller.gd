extends Node
#firecontroller
#bullet instantiator

var shoot_cooldown = 0

@export var bullet_origin: PackedScene

@onready var audio_stream_shoot: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var barrel: Marker2D = $"../Barrel"

var damage

func _ready() -> void:
	EventManager.upgrade_weapon.connect(on_upgrade_weapon)
	damage = 3


func _physics_process(delta: float) -> void:
	shoot_cooldown += 10 * delta

	#if Input.is_action_pressed("shoot") and shoot_cooldown > 2:
	if shoot_cooldown > 2:
		var bullet_instance = bullet_origin.instantiate() as Bullet
		bullet_instance.global_position = barrel.global_position
		add_child(bullet_instance)
		bullet_instance.hit_box_component.damage = damage
		#if audio_stream_shoot.playing == false:
		
		audio_stream_shoot.play()
		shoot_cooldown = 0
		await get_tree().create_timer(2).timeout
		if bullet_instance != null:
			bullet_instance.queue_free()


func on_upgrade_weapon(upgraded_weapon , current_weapons_list):
	if upgraded_weapon["weapon"] == "laser":
		for weapon in current_weapons_list:
			if weapon["weapon"] == "laser":
				damage = weapon["damage"]
				print("laser damage: " + str(damage))
				break
