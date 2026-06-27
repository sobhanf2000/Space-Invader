extends CanvasLayer

@onready var pause_button: Button = $Pause_Button
@onready var pause_menu: CanvasLayer = $Pause_Menu

func _ready() -> void:
	pause_button.pressed.connect(on_pause_button_clicked)
	

func on_pause_button_clicked():
	Engine.time_scale = 0
	get_tree().paused = true
	pause_menu.visible = true
