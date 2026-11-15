
extends CharacterBody2D

@export var chase_speed: float = 150.0

@onready var detection_area: Area2D = $Area2D

var player: Node2D = null

func _ready():
	detection_area.body_entered.connect(_on_body_entered)
	detection_area.body_exited.connect(_on_body_exited)


func _physics_process(delta):
	if is_instance_valid(player):
		var direction = global_position.direction_to(
			player.global_position
		)

		global_position += direction * chase_speed * delta


func _on_body_entered(body):
	if body.name == "Player":
		player = body
		print("MONSTER MULAI MENGEJAR!")


func _on_body_exited(body):
	if body == player:
		player = null
		print("PLAYER KELUAR DARI JANGKAUAN")
