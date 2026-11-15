
extends CanvasLayer

@onready var fade: ColorRect = get_node_or_null("Fade")

var changing_scene = false

func _ready():
	if fade == null:
		push_error("Node Fade tidak ditemukan!")
		return

	fade.color.a = 0.0

func change_scene(path: String):
	if changing_scene or fade == null:
		return

	if not ResourceLoader.exists(path):
		push_error("Scene tidak ditemukan: " + path)
		return

	changing_scene = true

	var tween = create_tween()
	tween.tween_property(fade, "color:a", 1.0, 0.5)
	await tween.finished

	var error = get_tree().change_scene_to_file(path)

	if error != OK:
		push_error("Gagal mengganti scene!")
		changing_scene = false
		return

	await get_tree().process_frame

	var tween_out = create_tween()
	tween_out.tween_property(fade, "color:a", 0.0, 0.5)
	await tween_out.finished

	changing_scene = false
