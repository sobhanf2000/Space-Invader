extends Area2D

@onready var health_component: HealthComponent = $"../Health_Component"
@onready var health_progress_bar_component: Health_Progress_Bar_Component = $"../Health_Progress_Bar_Component"
@export var items_audio_sources :Array[AudioStream]
@onready var items_as_player: AudioStreamPlayer = $Items_ASPlayer



func _ready() -> void:
	area_entered.connect(on_area_entered)
	health_progress_bar_component.progress_bar.value = health_component.health

func on_area_entered(area:Area2D):
	if area.get_collision_layer_value(9): # hit heal item
		health_component.health_change(-10)
		health_progress_bar_component.progress_bar.value = health_component.health
		items_as_player.stream = items_audio_sources[0]
		items_as_player.play()
	
	if area.get_collision_layer_value(5): # hit exp item
		EventManager.vial_collected_emit(1)
		items_as_player.stream = items_audio_sources[1]
		items_as_player.play()
