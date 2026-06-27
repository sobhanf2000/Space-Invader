extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var hit_box_component: HitBoxComponent = $HitBoxComponent
var damage = 3
@onready var enemy_detector: Area2D = $Enemy_Detector
var random_dir 

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	hit_box_component.damage = damage
	enemy_detector.area_entered.connect(on_area_entered)
	
	#random_dir = deg_to_rad(randi_range(-5 ,5))


func _physics_process(delta: float) -> void:
	position += Vector2.DOWN.rotated(rotation) * 300 * delta


func on_timer_timeout():
	queue_free()


func on_area_entered(other_area: Area2D):
	queue_free()
