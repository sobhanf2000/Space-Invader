extends StaticBody2D


var speed := 200
var direction := Vector2.UP

@onready var timer: Timer = $Timer
@onready var hit_box_component: HitBoxComponent = $HitBoxComponent
@onready var enemy_detector: Area2D = $Enemy_Detector


func _ready() -> void:
	enemy_detector.area_entered.connect(on_area_entered)
	var player := get_tree().get_first_node_in_group("player")
	
	timer.timeout.connect(on_timer_timeout)
	
	if player != null:
		direction = (player.global_position - global_position).normalized()
		rotation = direction.angle() - deg_to_rad(90)


func _process(delta: float) -> void:
	global_position += direction * speed * delta
	

func on_timer_timeout():
	queue_free()

func on_area_entered(other_area: Area2D):
	queue_free()
