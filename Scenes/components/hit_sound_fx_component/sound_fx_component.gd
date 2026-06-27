extends AudioStreamPlayer



@export var end_timer: Timer

func play_sfx() -> void:
	play()
	end_timer.timeout.connect(on_end_timer_timeout)


func on_end_timer_timeout():
	stop()
