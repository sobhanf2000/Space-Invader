extends CPUParticles2D

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	queue_free()
