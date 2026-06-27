extends Node

class_name WeaponsList


@export var missile_controller_origin: PackedScene
var player
var weapons_list :Array[Dictionary] = [
	{#--------------------------------WEAPONS-------------------------------------
		"weapon": "laser",
		"name": "Laser",
		"type": "weapon",
		"level": 2,
		"damage": 3,
		"speed": 8,
		"fire_rate": 20,
		"cooldown": 10,
		"number":1,
		"description": "Add 30% damage"
		
	}
		,
	{
		"weapon": "missile",
		"name": "Missile" , 
		"type": "weapon",
		"level": 1,
		"damage": 10,
		"speed": 4,
		"fire_rate": 2,
		"cooldown": 10,
		"number":1,
		"description": "Add 30% damage"
		},
	#-------------------------------UPGRADES----------------------------------
	#{
		#"weapon": "laser_damage",
		#"name": "Laser Damage" ,
		#"level": 1,
		#"weapon_type": "laser",
		#"type": "upgrade",
		#"description": "Add 10% damage"
	#}
		#,
	#{
		#"weapon": "missile_damage",
		#"name": "Missile Damage" ,
		#"level": 1,
		#"weapon_type": "missile",
		#"type": "upgrade",
		#"description": "Add 10% damage"
	#}
	]
	
	
var current_weapons :Array[Dictionary] = [
	{
		"weapon": "laser",
		"name": "Laser",
		"type": "new",
		"level": 2,
		"damage": 3,
		"speed": 8,
		"fire_rate": 20,
		"cooldown": 10,
		"number":1,
	}
	] 

func _ready() -> void:
	EventManager.upgrade_weapon.connect(on_upgrade_weapon)
	player = get_tree().get_first_node_in_group("player")


func on_upgrade_weapon(upgrade_weapon:Dictionary , current_weapons_list:Array[Dictionary]):
	var check_weapon_in_current_weapon = false
	var weapon_name = ""
	for array_weapon_name in current_weapons:
		weapon_name = array_weapon_name["weapon"]
		if weapon_name == upgrade_weapon["weapon"]:
			check_weapon_in_current_weapon = true
			break
	
	if check_weapon_in_current_weapon:
		apply_upgrade(upgrade_weapon)
	
	if !check_weapon_in_current_weapon:
		current_weapons.append(upgrade_weapon.duplicate(true))
		apply_new_weapon(upgrade_weapon)


func apply_upgrade(upgrade_weapon: Dictionary):
	if upgrade_weapon["weapon"] == "laser":
		for all_weapons in current_weapons:
			if all_weapons["weapon"] == "laser":
				all_weapons["damage"] += 1
				all_weapons["level"] += 1
				for weapon in weapons_list:
					if weapon["weapon"] == "laser":
						weapon["level"] += 1
	
	
	elif upgrade_weapon["weapon"] == "missile":
		for all_weapons in current_weapons:
			if all_weapons["weapon"] == "missile":
				all_weapons["damage"] += 3
				all_weapons["level"] += 1
				for weapon in weapons_list:
					if weapon["weapon"] == "missile":
						weapon["level"] += 1


	print("weapons_list = ", weapons_list)
	print("current_weapons = ", current_weapons)
	
func apply_new_weapon(upgrade_weapon: Dictionary):
	if upgrade_weapon["weapon"] == "missile":
		var missile_instance = missile_controller_origin.instantiate()
		player.add_child(missile_instance)
