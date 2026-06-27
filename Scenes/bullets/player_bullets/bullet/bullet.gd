extends StaticBody2D
class_name Bullet
#bullet scene

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var bullet_particles: CPUParticles2D = $Bullet_Particles
@onready var hit_box_component: HitBoxComponent = $HitBoxComponent
@onready var enemy_detector: Area2D = $Enemy_Detector

var hit_to_enemy = false
var timer
var speed = 10
var game_entities


func _ready() -> void:
	timer = bullet_particles.lifetime + 1
	enemy_detector.area_entered.connect(on_enemy_entered)
	game_entities = get_tree().get_first_node_in_group("game_entities")


func _process(delta: float) -> void:
	if !hit_to_enemy:
		global_position.y -= speed


func on_enemy_entered(other_area : Area2D):
	hit_to_enemy = true
	global_position.y += 10
	animated_sprite_2d.visible = false
	bullet_particles.emitting = true
	var main_scene = get_tree().current_scene
	bullet_particles.reparent(main_scene , true)
	# todo: reparent particle to main game scene : done
	queue_free()
