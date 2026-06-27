extends Sprite2D


@export var planets_pngs : Array[CompressedTexture2D]
var random_scale


func _ready() -> void:
	random_scale = randf_range(0.1 , 0.4)
	if planets_pngs.size() > 0 :
		texture = planets_pngs.pick_random()
		scale = Vector2(random_scale, random_scale)
		global_position = Vector2(randi_range(-10 , 600) ,-350)
		


func _process(delta: float) -> void:
	global_position.y += 25 * delta
