extends Node3D

class_name LedgeController

@export var above_rays: Node3D
@export var height_ray: RayCast3D
@export var test_label: Label

# Checks if space above the ledge is free
func is_space_above_free() -> bool:
	for ray: RayCast3D in above_rays.get_children():
		if ray.is_colliding():
			return false
	
	return true

# Checks if the player is close enough to an obstacle on a certain level to climb it (Head/Chest)
func is_hitting_on_level(level: String) -> bool:
	for ray: RayCast3D in get_node(level).get_children():
		if !ray.is_colliding():
			return false
	
	return true

func get_ledge_level() -> int:
	if !is_space_above_free():
		return 0
	
	var max_level: int = 0
	
	for ray_level: Node3D in get_children():
		if !ray_level.name.is_valid_int():
			if ray_level != above_rays and !ray_level.is_class("RayCast3D"):
				push_error("One of the player's ledge colliders doesn't have a valid integer in its' name!")
			
			continue
		
		var level: int = ray_level.name.to_int()
		if level > max_level and is_hitting_on_level(ray_level.name):
			max_level = level
	
	return max_level

func get_ledge_height():
	print("Collision point: %s\nCollision normal: %s" % [height_ray.get_collision_point(), height_ray.get_collision_normal()])

# For testing purposes - should remove later
func _process(_delta):
	test_label.text = str(get_ledge_level())
	get_ledge_height()
