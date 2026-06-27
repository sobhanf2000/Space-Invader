extends CharacterBody2D
class_name Player


const SPEED = 300.0

@export var speed := 1000.0

@onready var upgrade_manager: Node = $Upgrade_Manager
@onready var health_component: HealthComponent = $Health_Component
@onready var sound_fx_component: AudioStreamPlayer = $SoundFX_Component


var viewport_size 


func _ready() -> void:
	viewport_size = get_viewport().get_visible_rect().size
	var end_position = global_position.y - 500
	var tween = get_tree().create_tween()
	sound_fx_component.play_sfx()
	tween.tween_property(self , "global_position" , Vector2(global_position.x , end_position) , 3.2)
	EventManager.win_game.connect(on_win_game)


func _physics_process(delta: float) -> void:
	if health_component.health <= 0:
		EventManager.game_over_emit()
		
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#var target_pos = get_global_mouse_position()
		#
		#global_position = global_position.move_toward(
			#target_pos,
			#speed * delta
		#)

	global_position.x = clamp(global_position.x , 0 , viewport_size.x)
	global_position.y = clamp(global_position.y , 0 , viewport_size.y)
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed("left_click"):
		global_position += event.relative
		
		#if event.relative.x > 0 :
			#global_rotation = clamp(global_rotation , deg_to_rad(-5) ,deg_to_rad(5))
			#global_rotation= move_toward(global_rotation , 5 , 0.02)
		#elif event.relative.x < 0:
			#global_rotation = clamp(global_rotation , deg_to_rad(-5) ,deg_to_rad(5))
			#global_rotation= move_toward(global_rotation , -5 , 0.02)
			
	#else:
		#global_rotation= move_toward(global_rotation , 0 , 0.02)
			#
func on_win_game():
	var end_position = global_position.y - 5000
	await get_tree().create_timer(4).timeout
	sound_fx_component.play_sfx()
	var tween = get_tree().create_tween()
	tween.tween_property(self , "global_position" , Vector2(global_position.x , end_position) , 6.2)
