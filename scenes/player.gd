extends Node3D

@export var character: CharacterBody3D

func cam_rotate(euler_rotation: Vector3) -> void:
	euler_rotation.x = 0
	character.basis = Basis.from_euler(euler_rotation)
