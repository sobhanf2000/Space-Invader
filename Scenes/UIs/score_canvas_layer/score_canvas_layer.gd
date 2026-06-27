extends CanvasLayer


@onready var score_label: Label = $ScoreLabel
@onready var wave_label: Label = $Wave_Label
@onready var difficulty_label: Label = $Difficulty_Label
@onready var high_score_label: Label = $High_Score_Label

var difficulty_level = 1
var wave_level = 1
var score_value = 0
var high_score_value = 0


func _ready() -> void:
	high_score_value = load_data()
	high_score_label.text = "Hi_Score: " + str(high_score_value)
	EventManager.enemy_died.connect(on_enemy_died)
	EventManager.increase_difficulty.connect(on_increase_difficulty)
	score_label.text = "Score: " + str(score_value) 
	wave_label.text = "Wave Level: " + str(wave_level)
	difficulty_label.text = "Difficulty Level: " + str(difficulty_level)
	

func score_up(enemy_point):
	var tween := create_tween()

	score_label.scale = Vector2.ONE
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(score_label, "scale", Vector2(1.3, 1.3), 0.15)
	tween.tween_property(score_label, "scale", Vector2.ONE, 0.15)
	
	score_value += enemy_point
	score_label.text = "Score: " + str(score_value) 
	if score_value > high_score_value:
		high_score_update()
		
		
func high_score_update():
		high_score_value = score_value
		high_score_label.text = "Hi_Score: " + str(high_score_value)
		save_data()
	
	
func wave_update_label():
	wave_level += 1
	wave_label.text = "Wave Level: " + str(wave_level)
	
	if wave_level % 5 == 0:
		difficulty_level_up()
		
	var tween := create_tween()
	wave_label.scale = Vector2.ONE
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(wave_label, "scale", Vector2(1.3, 1.3), 0.15)
	tween.tween_property(wave_label, "scale", Vector2.ONE, 0.15)
	
	
func difficulty_level_up():
	difficulty_level += 1
	difficulty_label.text = "Difficulty Level: " + str(difficulty_level)
	
	var tween := create_tween()
	difficulty_label.scale = Vector2.ONE
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(difficulty_label, "scale", Vector2(1.3, 1.3), 0.15)
	tween.tween_property(difficulty_label, "scale", Vector2.ONE, 0.15)
	


func save_data():
	var data = {
		"high_score" : score_value
	}
	
	var file =FileAccess.open("user://save.json" , FileAccess.WRITE)
	file.store_string(JSON.stringify(data))


func load_data():
	if not FileAccess.file_exists("user://save.json"):
		return 0
	
	var file = FileAccess.open("user://save.json" , FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	return data.get("high_score" , 0)



func on_increase_difficulty():
	wave_update_label()


func on_enemy_died(pos):
	score_up(5)
