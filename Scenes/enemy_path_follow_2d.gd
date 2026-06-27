extends PathFollow2D

var speed = 100


func _ready() -> void:
	progress = 0


func _process(delta: float) -> void:
	progress += speed * delta
