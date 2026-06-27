extends Node


var shoot_cooldown = 0
var random_shoot_cooldown
var damage = 3

@export var bullet_origin: PackedScene
@export var random_shoot_cooldowns: Vector2
@export var barrel: Array[Marker2D] = []
@export var is_active: bool


func _ready() -> void:
	random_shoot_cooldown = randi_range(random_shoot_cooldowns.x , random_shoot_cooldowns.y)
	

func _physics_process(delta: float) -> void:
	if is_active:
		
		shoot_cooldown += 8 * delta 
		
		if shoot_cooldown > random_shoot_cooldown:
			var bullet_instance = bullet_origin.instantiate()
			var random_barrel = barrel.pick_random()
			bullet_instance.global_position = random_barrel.global_position
			add_child(bullet_instance)
			bullet_instance.hit_box_component.damage = damage
			bullet_instance.reparent(get_tree().current_scene)
			shoot_cooldown = 0
			await get_tree().create_timer(3).timeout
			if bullet_instance != null:
				bullet_instance.queue_free()
