extends Node2D

var exprince_manager
@export var progress_bar: ProgressBar 

func _ready() -> void:
	exprince_manager = get_tree().get_first_node_in_group("exprince_manager")
	progress_bar.max_value = exprince_manager.level_up_amount
	progress_bar.value = exprince_manager.collected_vial
	EventManager.vial_collected.connect(on_vial_collected)


func on_vial_collected(vial :int):
	progress_bar.max_value = exprince_manager.level_up_amount
	progress_bar.value = exprince_manager.collected_vial
	
