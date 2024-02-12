extends Node3D

@export var test_label: Label

@export var high_ledge: Area3D
@export var medium_ledge: Area3D
@export var low_ledge: Area3D

# I assume that since the collider only detects bodies on the 'obstacle' layer,
# there's no need for additional checks
func get_ledge_height() -> int:
	if high_ledge.has_overlapping_areas():
		return 3
	elif medium_ledge.has_overlapping_areas():
		return 2
	elif low_ledge.has_overlapping_areas():
		return 1
	else:
		return 0

func _process(_delta) -> void:
	test_label.text = str(get_ledge_height())
