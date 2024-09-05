extends Node3D

# For now this script only allows the player to get their cursor out of the game window
# Later to have an actual pause function
# Actually nevermind, this should just be in the camera script
#func _process(_delta) -> void:
	#if Input.is_action_just_pressed("pause"):
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
