extends CanvasLayer


@onready var experince_bar: ProgressBar = $MarginContainer/ProgressBar


func _ready() -> void:
	experince_bar.value = 0.0
	


func experince_bar_update(experince_value):
	experince_bar.value = experince_value
