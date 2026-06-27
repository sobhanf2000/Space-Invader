# upgrade_screen_ui
extends CanvasLayer

@export var upgrade_card_ui_origin: PackedScene
@export var card_container:HBoxContainer



func make_upgrade_cards(weapons_list:Array[Dictionary] , current_weapons_list):
	var available_upgrade_list = weapons_list.duplicate()
	for i in range(min(2 , available_upgrade_list.size())):
		var weapon = available_upgrade_list.pick_random() as Dictionary
		available_upgrade_list.erase(weapon)
		var upgrade_card_ui_instance = upgrade_card_ui_origin.instantiate()
		card_container.add_child(upgrade_card_ui_instance)
		upgrade_card_ui_instance.selected.connect(on_selected.bind(weapon , current_weapons_list))
		upgrade_card_ui_instance.call_deferred("update_labels", weapon)
		


func on_selected(selected_weapon: Dictionary , current_weapons_list):
	EventManager.upgraded_weapon_emit(selected_weapon , current_weapons_list)
	queue_free()
