extends Node2D

@onready var label = $Panel/Label

func say(message: String):
	label.text = message
	visible = true

func hide_bubble():
	visible = false
