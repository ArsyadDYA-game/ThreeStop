extends Area3D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.has_method("reset_player"):
		body.reset_player()

		# Hapus spike setelah mengenai player
		get_parent().queue_free()
