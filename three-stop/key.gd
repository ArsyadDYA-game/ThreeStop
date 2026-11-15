extends Area3D

func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if body.name == "Player3D":
		body.has_key = true

		print("KUNCI BERHASIL DIAMBIL!")

		queue_free()
