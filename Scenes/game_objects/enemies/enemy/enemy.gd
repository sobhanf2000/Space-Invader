extends Node2D

#enemy script

@export var health_component: HealthComponent
@export var health_progress_bar_component: Health_Progress_Bar_Component 
@onready var timer: Timer = $Timer



func _ready() -> void:
	timer.timeout.connect(snappy_movement)


func snappy_movement():
	if EventManager.endless:
		global_position.y += 15
		
