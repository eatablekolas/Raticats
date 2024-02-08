extends CharacterBody3D

@export var mesh: MeshInstance3D
@export var cam_pivot: Marker3D
@export var speed = 5.0
@export var jump_velocity = 4.5
@export var rotate_speed = 0.3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, cam_pivot.rotation.y)
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
		var target_rotation: float = (direction.signed_angle_to(Vector3.LEFT, Vector3.DOWN)) - (PI/2)
		if target_rotation > PI:
			target_rotation -= 2 * PI
		
		mesh.rotation.y = rotate_toward(mesh.rotation.y, target_rotation, rotate_speed)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
