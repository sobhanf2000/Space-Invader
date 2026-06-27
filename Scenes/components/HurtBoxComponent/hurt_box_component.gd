extends Area2D

class_name HurtBoxComponent

@export var healthcomponent: HealthComponent
@export var health_progress_bar_component: Health_Progress_Bar_Component
@export var missile_explosion_as: AudioStreamPlayer
@export var sprite: Sprite2D

func _ready() -> void:
	area_entered.connect(on_area_entered)
	

func on_area_entered(other_area:Area2D):
	if not other_area is HitBoxComponent:
		return
	
	if healthcomponent == null:
		return
	
	var hitboxcomponent = other_area as HitBoxComponent
	healthcomponent.health_change(hitboxcomponent.damage)
	health_progress_bar_component.progress_bar.value = healthcomponent.health
	
	if sprite:
		sprite.material.set_shader_parameter("hit_flash", 1.0)
		await get_tree().create_timer(0.1).timeout
		sprite.material.set_shader_parameter("hit_flash", 0.0)
		
	
	
