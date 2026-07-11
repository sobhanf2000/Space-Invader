extends AnimatedSprite2D

@onready var explosion_sfx: AudioStreamPlayer = $Explosion_SFX

func _ready():
	animation_finished.connect(_on_animation_finished)
	var animations = sprite_frames.get_animation_names()
	if animations.size() > 0:
		var random_index = randi_range(0, animations.size() - 1)
		play(animations[random_index])
	explosion_sfx.play(0.4)
	
func _on_animation_finished():
	queue_free()
