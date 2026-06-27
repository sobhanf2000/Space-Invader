extends Sprite2D


@onready var area_2d: Area2D = $Area2D
@export var health_value = 25


func _ready() -> void:
	area_2d.area_entered.connect(on_area_entered)


func _process(delta: float) -> void:
	global_position.y += 50 * delta


func on_area_entered(other_area: Area2D):
	queue_free()
