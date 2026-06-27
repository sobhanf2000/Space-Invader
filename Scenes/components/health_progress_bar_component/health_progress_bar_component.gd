extends Node2D
class_name Health_Progress_Bar_Component


@export var progress_bar: ProgressBar
@export var health_component: HealthComponent


func _ready() -> void:
	progress_bar.max_value = health_component.health
	progress_bar.value = health_component.health
