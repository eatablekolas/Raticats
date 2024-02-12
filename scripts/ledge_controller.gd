extends Node3D

@export var test_label: Label

var ledge_colliders: Dictionary = {}

func _ready() -> void:
	for collider: Area3D in get_children():
		if !collider.name.is_valid_int():
			push_warning("One of the player's ledge colliders doesn't have a valid integer in its' name!")
		
		# The key of a collider in the dictionary is also its' height
		var height: int = collider.name.to_int()
		ledge_colliders[height] = collider

func get_ledge_height() -> int:
	var max_height: int = 0
	
	# For some reason, in GDScript, a for loop goes through keys in a dictionary, not values
	for height: int in ledge_colliders:
		if height > max_height && ledge_colliders[height].has_overlapping_areas():
			# I assume that since the collider only detects areas on the 'ledge' layer,
			# there's no need for additional checks
			max_height = height
	
	return max_height

func _process(_delta) -> void:
	test_label.text = str(get_ledge_height())
