extends Node3D

class_name LedgeController

@export var above_rays: Node3D
@export var height_ray: RayCast3D
@export var test_label: Label

var current_ray: RayCast3D

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
	
	current_ray = get_current_ray(max_level)
	return max_level

func get_current_ray(current_level: int) -> RayCast3D:
	if current_level == 0:
		return null
	
	var ray_set: Node3D = get_node(str(current_level))
	if ray_set == null:
		return null
	
	var ray: RayCast3D = ray_set.get_node("Middle")
	return ray

func get_ledge_position() -> Vector3:
	if current_ray == null:
		#push_warning("Trying to get ledge position without current ray!")
		return Vector3.ZERO
	
	var pos: Vector3 = current_ray.get_collision_point() + (current_ray.get_collision_normal() * 0.5)
	pos.y = height_ray.get_collision_point().y - current_ray.get_parent_node_3d().position.y - 1.0
	
	return pos

func get_ledge_rotation() -> Vector3:
	if current_ray == null:
		#push_warning("Trying to get ledge rotation without current ray!")
		return Vector3.ZERO
	
	var normal: Vector3 = current_ray.get_collision_normal()
	var angle: float = normal.signed_angle_to(Vector3.BACK, Vector3.DOWN)
	
	return Vector3(0.0, angle, 0.0)

func get_ledge() -> Ledge:
	var ledge = Ledge.new()
	ledge.level = get_ledge_level()
	
	if ledge.level == 0:
		return ledge
	
	ledge.position = get_ledge_position()
	ledge.rotation = get_ledge_rotation()
	return ledge

# For testing purposes - should remove later
func _process(_delta):
	test_label.text = str(get_ledge_position())
