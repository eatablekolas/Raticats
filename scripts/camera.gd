extends Marker3D

@export var player: Node3D
@export var cam: Camera3D
@export var spring_arm: SpringArm3D

@export_range(0.0001, 0.1, 0.0001) var mouse_sensitivity: float = 1
@export_range(0.1, 1.0, 0.01) var collision_multiplier: float = 0.9
@export_range(0.0, 90.0, 0.1) var max_up_angle: float = 60
@export_range(0.0, 90.0, 0.1) var max_down_angle: float = 30
@export_range(0.0, 100, 0.1) var default_distance: float = 5.0

var rot_x: float = 0.0
var rot_y: float = 0.0

func _ready() -> void:
	max_up_angle = deg_to_rad(max_up_angle)
	max_down_angle = deg_to_rad(max_down_angle)
	cam.position.z = default_distance
	spring_arm.spring_length = default_distance
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta) -> void:
	var mouse_input = Input.get_last_mouse_velocity() * delta * mouse_sensitivity
	var euler_rotation = global_transform.basis.get_euler()
	euler_rotation.x += mouse_input.y
	euler_rotation.x = clamp(euler_rotation.x, -max_up_angle, max_down_angle)
	euler_rotation.y += mouse_input.x
	global_transform.basis = Basis.from_euler(euler_rotation)
	
	#player.cam_rotate(euler_rotation)
