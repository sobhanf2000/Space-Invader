extends Sprite2D

var speed := 200
var direction := Vector2.UP

@onready var hit_box_component: HitBoxComponent = $HitBoxComponent
@onready var missile_layer: Area2D = $MissileLayer
@onready var missile_launch_as: AudioStreamPlayer = $Missile_Launch_AS
@onready var sound_fx_component: AudioStreamPlayer = $SoundFX_Component


func _ready() -> void:
	missile_layer.area_entered.connect(on_area_entered)
	var enemies := get_tree().get_nodes_in_group("enemy")
	missile_launch_as.play()
	
	
	if enemies.size() > 0:
		var closest_enemy: Node2D = enemies[0]
	
		for enemy in enemies:
			if global_position.distance_to(enemy.global_position) < global_position.distance_to(closest_enemy.global_position):
				closest_enemy = enemy
	
		direction = (closest_enemy.global_position - global_position).normalized()
	
	rotation = direction.angle() + deg_to_rad(90)


func _process(delta: float) -> void:
	global_position += direction * speed * delta


func on_area_entered(other_area: Area2D):
	sound_fx_component.play_sfx()
	sound_fx_component.reparent(get_tree().current_scene , true)
	queue_free()
