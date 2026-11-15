
extends Control

@onready var clip = $Clip
@onready var credits_content = $Clip/CreditsContent
@onready var quit_button = $Quit_Button

func _ready():
	quit_button.pressed.connect(_on_quit_pressed)

	mulai_credits()


func mulai_credits():
	await get_tree().process_frame

	# Mulai dari bawah area Clip
	credits_content.position.y = clip.size.y

	# Bergerak sampai seluruh tulisan keluar dari atas
	var tujuan = -credits_content.size.y

	var tween = create_tween()
	tween.tween_property(
		credits_content,
		"position:y",
		tujuan,
		25.0
	)


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
