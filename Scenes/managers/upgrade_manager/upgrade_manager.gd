#upgrade_manager
extends Node

@export var missile_controller:PackedScene
@export var upgrade_screen_ui: PackedScene
@export var weapons_list_manager: WeaponsList


func level_up():
	make_upgrade_ui(weapons_list_manager.weapons_list , weapons_list_manager.current_weapons)
	

# make a new screen ui. sends an array of all weapons upgrade we have to show it for pick by player
func make_upgrade_ui(upgrade_weapons_list: Array[Dictionary] , current_weapon_list): 
	var upgrade_screen_ui_instance = upgrade_screen_ui.instantiate()
	var game_entities = get_tree().get_first_node_in_group("game_entities")
	upgrade_screen_ui_instance.make_upgrade_cards(upgrade_weapons_list , current_weapon_list)
	game_entities.add_child(upgrade_screen_ui_instance)
