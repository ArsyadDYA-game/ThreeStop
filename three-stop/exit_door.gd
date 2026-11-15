
extends Area3D

var player_near: bool = false
var player_ref: Node3D
var is_exiting: bool = false

@onready var label = $Label3D

func _ready():
	label.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		if is_exiting:
			return

		if player_ref != null and player_ref.has_key:
			is_exiting = true
			await player_ref.transition_to_credits()
		else:
			label.text = "YOU NEED A KEY!"

func _on_body_entered(body):
	if body.name == "Player3D":
		player_near = true
		player_ref = body
		label.text = "PRESS E TO LEAVE"
		label.visible = true

func _on_body_exited(body):
	if body == player_ref:
		player_near = false
		player_ref = null
		label.visible = false
