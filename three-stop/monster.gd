
extends CharacterBody2D

enum State {
	PATROL,
	ALERT,
	CHASE
}

@export var patrol_speed = 80.0
@export var chase_speed = 250.0

var current_state = State.PATROL
var player: Node2D

func _physics_process(delta):
	match current_state:

		State.PATROL:
			patrol(delta)

		State.ALERT:
			velocity = Vector2.ZERO

		State.CHASE:
			chase_player()

	move_and_slide()


func patrol(delta):
	# We'll add path movement here
	pass


func chase_player():
	if player == null:
		return

	var direction = global_position.direction_to(
		player.global_position
	)

	velocity = direction * chase_speed
	
func can_see_player() -> bool:
	if player == null:
		return false

	var direction = player.global_position - global_position

	$VisionRay.target_position = direction
	$VisionRay.force_raycast_update()
	if $VisionRay.is_colliding():
		return $VisionRay.get_collider() == player

	return false


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body

	if current_state == State.PATROL and can_see_player():
		start_alert()


func _on_detection_area_body_exited(body):
	if body == player:
		player = null


func start_alert():
	current_state = State.ALERT
	velocity = Vector2.ZERO

	await get_tree().create_timer(1.0).timeout

	if player != null:
		current_state = State.CHASE
	else:
		current_state = State.PATROL
