extends Area2D


func _ready() -> void:
	area_entered.connect(on_area_entered)
	
	
func on_area_entered(other_area: Area2D):
	EventManager.game_over_emit()
