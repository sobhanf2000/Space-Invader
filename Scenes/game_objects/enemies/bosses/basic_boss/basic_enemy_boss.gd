extends Node2D

@onready var fire_controller_component: Node = $Fire_Controller_v2_Component
@onready var timer: Timer = $Timer
@onready var health_component: HealthComponent = $Health_Component
@onready var right_ray_cast: RayCast2D = $Right_RayCast
@onready var left_ray_cast: RayCast2D = $Left_RayCast
@onready var explosion_animated_sprite: AnimatedSprite2D = $Explosion_AnimatedSprite


var direction = 1


func _ready() -> void:
	timer.timeout.connect(snappy_movement)


func snappy_movement():
	if global_position.y <= 280:
		global_position.y += 20
	elif global_position.y >= 280:
		if !fire_controller_component.is_active:
			fire_controller_component.is_active = true
			health_component.is_active = true
		if right_ray_cast.is_colliding():
			direction *= -1
		global_position.x += 20 * direction

#func show_explosion():
	#explosion_animated_sprite.play()
