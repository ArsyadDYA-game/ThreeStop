extends Area2D

var player_caught := false

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name == "Player" and not player_caught:
		player_caught = true

		print("PLAYER TERTANGKAP!")

		body.respawn()

		await get_tree().create_timer(0.5).timeout
		player_caught = false
