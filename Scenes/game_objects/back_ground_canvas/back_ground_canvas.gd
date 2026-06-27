extends CanvasLayer

@onready var back_1: Sprite2D = $back1
@onready var back_2: Sprite2D = $back2



func _process(delta: float) -> void:
	back_1.global_position.y += 10
	back_2.global_position.y += 10
	
	if back_1.global_position.y >= get_viewport().get_visible_rect().size.y:
		back_1.global_position.y = back_2.global_position.y - back_1.texture.get_size().y 
	
	if back_2.global_position.y >= get_viewport().get_visible_rect().size.y:
		back_2.global_position.y = back_1.global_position.y - back_2.texture.get_size().y 
