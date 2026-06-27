extends AnimatedSprite2D


func _ready():
	animation_finished.connect(_on_animation_finished)
	var animations = sprite_frames.get_animation_names()
	if animations.size() > 0:
		var random_index = randi_range(0, animations.size() - 1)
		play(animations[random_index])
	
	
func _on_animation_finished():
	queue_free()
