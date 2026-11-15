extends Control

@onready var credits_content = $Clip/CreditsContent
@onready var quit_button = $Quit_Button

@export var scroll_speed: float = 40.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	quit_button.pressed.connect(_on_quit_pressed)

	await get_tree().process_frame

	var start_y = 850.0
	var end_y = -credits_content.size.y

	credits_content.position.y = start_y

	var duration = (start_y - end_y) / scroll_speed

	var tween = create_tween()
	tween.tween_property(
		credits_content,
		"position:y",
		end_y,
		duration
	).set_trans(Tween.TRANS_LINEAR)

func _on_quit_pressed():
	get_tree().quit()
