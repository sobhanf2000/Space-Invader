extends CanvasLayer

@onready var wave_label: Label = $WaveLabel

func _ready() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property($WaveLabel,"global_position" , Vector2(0,0), 0.5)
	tween.chain().tween_property($WaveLabel,"global_position" , Vector2(0,0), 1)
	tween.chain().tween_property($WaveLabel,"global_position" , Vector2(0,-140), 0.5)

 
