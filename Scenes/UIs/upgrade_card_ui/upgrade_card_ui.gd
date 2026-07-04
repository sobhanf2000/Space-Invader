#upgrade_card_ui
extends PanelContainer

signal selected

@onready var title_label: Label = %TitleLabel
@onready var level_label: Label = %LevelLabel
@onready var description_label: Label = %DescriptionLabel

func _ready() -> void:
	gui_input.connect(_on_gui_input_clicked)
	

func update_labels(weapon_details: Dictionary):
	print(
	weapon_details["weapon"],
	" level = ",
	weapon_details["level"]
	)
	
	title_label.text = weapon_details["weapon"]
	level_label.text = "Level: "+ str(weapon_details["level"])
	if weapon_details["level"] == 1:
		description_label.text = "Add new weapon"
	else:
		description_label.text = str(weapon_details["description"])
		
	Engine.time_scale = 0
	get_tree().paused = true

func _on_gui_input_clicked(event:InputEvent):
	if event.is_action_pressed("left_click"):
		Engine.time_scale = 1
		get_tree().paused = false
		selected.emit()
