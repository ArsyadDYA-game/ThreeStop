extends Area2D

var changing_scene := false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player" and not changing_scene:
		changing_scene = true
		SceneTransition.change_scene("res://3_dgame.tscn")
