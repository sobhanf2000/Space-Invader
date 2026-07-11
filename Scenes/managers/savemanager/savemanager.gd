extends Node


const SAVE_PATH = "user://save.json"

var data = {
	"high_score": 0,
	"unlocked_level": 1
}


func _ready():
	load_data()


func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()


func load_data():
	if not FileAccess.file_exists(SAVE_PATH):
		save_data()
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	var loaded_data = JSON.parse_string(content)
	
	if loaded_data:
		data = loaded_data



func set_high_score(score):
	if score > data["high_score"]:
		data["high_score"] = score
		save_data()



func unlock_level(level):
	if level > data["unlocked_level"]:
		data["unlocked_level"] = level
		save_data()
