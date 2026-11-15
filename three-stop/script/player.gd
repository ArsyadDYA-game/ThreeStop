extends CharacterBody2D

# Movement
const SPEED = 300.0

var last_direction: Vector2 = Vector2.RIGHT
var spawn_position: Vector2
var is_respawning := false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var speech = $SpeechBubble


func _ready():
	spawn_position = global_position
	speech.visible = false


func _physics_process(_delta: float) -> void:
	if is_respawning:
		return

	process_movement()
	process_animation()
	move_and_slide()


# Movement
func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")

	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO


# Animation
func process_animation() -> void:
	if velocity != Vector2.ZERO:
		play_animation("walk", last_direction)
	else:
		play_animation("idle", last_direction)


func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")


# Speech Bubble
func _input(event):
	if event.is_action_pressed("ui_accept") and not is_respawning:
		speech.say("Where am I?")


# Respawn
func respawn():
	if is_respawning:
		return

	is_respawning = true

	velocity = Vector2.ZERO
	global_position = spawn_position

	set_deferred("global_position", spawn_position)

	await get_tree().physics_frame

	global_position = spawn_position
	velocity = Vector2.ZERO

	process_animation()

	is_respawning = false
