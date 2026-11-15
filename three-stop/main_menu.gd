
extends Control

@onready var play_button = $CenterContainer/VBoxContainer/PlayButton
@onready var credit_button = $CenterContainer/VBoxContainer/CreditsButton
@onready var quit_button = $CenterContainer/VBoxContainer/QuitButton


func _ready():
	play_button.pressed.connect(_on_play_pressed)
	credit_button.pressed.connect(_on_credit_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


# PLAY
func _on_play_pressed():
	print("PLAY DIPILIH")
	SceneTransition.change_scene("res://sideviw_2d.tscn")


# CREDIT
func _on_credit_pressed():
	print("CREDIT DIPILIH")
	SceneTransition.change_scene("res://Credits.tscn")


# QUIT
func _on_quit_pressed():
	print("GAME DITUTUP")
	get_tree().quit()
