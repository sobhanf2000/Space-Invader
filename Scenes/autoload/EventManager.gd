extends Node

signal game_over
signal win_game
signal enemy_died(enemy_pos)
signal increase_difficulty
signal level_up
signal vial_collected(vial)
signal upgrade_weapon(selecet_weapon: Dictionary)

var enemy_count = 0
var endless
var check_last_wave: bool = false
var boss_added: bool = false

func enemies_count(enemies: int , enemy_pos: Vector2):
	if enemies < 0:
		enemy_died_emit(enemy_pos)
	enemy_count += enemies
	if enemy_count < 0:
		enemy_count = 0
	if enemy_count  <= 0 and !endless and check_last_wave and boss_added:
		win_game_emit()
	#print("enemy: " + str(enemy_count))


func game_over_emit():
	game_over.emit()


func win_game_emit():
	win_game.emit()


func enemy_died_emit(enemy_pos:Vector2):
	enemy_died.emit(enemy_pos)


func increase_difficulty_emit():
	increase_difficulty.emit()


func level_up_emit():
	level_up.emit()


func vial_collected_emit(vial: int):
	vial_collected.emit(vial)


func upgraded_weapon_emit(selected_weapon:Dictionary , current_weapons_list):
	upgrade_weapon.emit(selected_weapon , current_weapons_list)
