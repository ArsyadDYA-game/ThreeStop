
extends CharacterBody3D

const SPEED = 5.0
const SENSITIVITY = 0.002

@onready var head = $Head
@onready var fade = $CanvasLayer/ColorRect

var spawn_position: Vector3
var spawn_rotation: Vector3
var is_respawning = false
var has_key: bool = false

func _ready():
	spawn_position = global_position
	spawn_rotation = global_rotation
	fade.color = Color(0, 0, 0, 0)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			rotate_y(-event.relative.x * SENSITIVITY)
			head.rotate_x(-event.relative.y * SENSITIVITY)
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(80))

	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseButton:
		if event.pressed:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	if is_respawning:
		return

	if not is_on_floor():
		velocity.y -= 9.8 * delta

	var input_dir = Input.get_vector(
		"left",
		"right",
		"up",
        "down"
	)

	var direction = transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	direction.y = 0
	direction = direction.normalized()

	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	move_and_slide()

func reset_player():
	if is_respawning:
		return

	is_respawning = true

	var tween = create_tween()
	tween.tween_property(fade, "color", Color(0, 0, 0, 1), 0.4)
	await tween.finished

	velocity = Vector3.ZERO
	global_position = spawn_position
	global_rotation = spawn_rotation
	head.rotation = Vector3.ZERO

	await get_tree().process_frame

	var tween2 = create_tween()
	tween2.tween_property(fade, "color", Color(0, 0, 0, 0), 0.6)
	await tween2.finished

	is_respawning = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func transition_to_credits():
	if is_respawning:
		return

	is_respawning = true
	velocity = Vector3.ZERO

	var tween = create_tween()
	tween.tween_property(
		fade,
		"color",
		Color(0, 0, 0, 1),
		1.0
	)

	await tween.finished

	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://credits.tscn")
