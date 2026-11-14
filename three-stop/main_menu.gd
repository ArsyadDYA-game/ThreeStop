
extends Control

# =================================
# PENGATURAN SCENE
# =================================

@export_file("*.tscn") var game_scene = "res://Game.tscn"
@export_file("*.tscn") var credits_scene = "res://Credits.tscn"


# =================================
# REFERENSI NODE
# =================================

@onready var play_button = $CenterContainer/VBoxContainer/PlayButton
@onready var credits_button = $CenterContainer/VBoxContainer/CreditsButton
@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton


# =================================
# SAAT GAME DIMULAI
# =================================

func _ready():

	play_button.pressed.connect(_on_play_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

	setup_hover(play_button)
	setup_hover(credits_button)
	setup_hover(quit_button)


# =================================
# TOMBOL PLAY
# =================================

func _on_play_pressed():

	if ResourceLoader.exists(game_scene):
		get_tree().change_scene_to_file(game_scene)
	else:
		print("Game.tscn tidak ditemukan!")


# =================================
# TOMBOL CREDITS
# =================================

func _on_credits_pressed():

	if ResourceLoader.exists(credits_scene):
		get_tree().change_scene_to_file(credits_scene)
	else:
		print("Credits.tscn tidak ditemukan!")


# =================================
# TOMBOL QUIT
# =================================

func _on_quit_pressed():

	get_tree().quit()


# =================================
# EFEK HOVER TOMBOL
# =================================

func setup_hover(button):

	button.pivot_offset = button.size / 2

	button.mouse_entered.connect(
		func():
			button.scale = Vector2(1.1, 1.1)
	)

	button.mouse_exited.connect(
		func():
			button.scale = Vector2(1.0, 1.0)
	)
