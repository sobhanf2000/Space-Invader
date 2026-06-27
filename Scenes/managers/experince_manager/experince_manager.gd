extends Node

@onready var upgrade_manager: Node = $"../Upgrade_Manager"
@onready var experince_bar_ui: CanvasLayer = $"../Experince_Bar"



var collected_vial = 0
var level_up_amount = 3


func _ready() -> void:
	EventManager.vial_collected.connect(on_vial_collected)
	experince_bar_ui.experince_bar.max_value = level_up_amount


func collect_vial(vial):
	collected_vial += vial
	experince_bar_ui.experince_bar_update(collected_vial)
	if collected_vial > level_up_amount: # start upgrade from here
		collected_vial = 0
		level_up_amount += 5
		experince_bar_ui.experince_bar.max_value = level_up_amount
		level_up() 


func level_up():
	upgrade_manager.level_up() # calls upgrade_manager


func on_vial_collected(vial):
	collect_vial(vial)
