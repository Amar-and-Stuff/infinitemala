extends Button

signal click
@onready var button_click_sound_player: AudioStreamPlayer2D = $ButtonClickSoundPlayer

func _ready() -> void:
	text = "   " + text.strip_edges() + "   "

func _on_pressed() -> void:
	button_click_sound_player.play()
	await button_click_sound_player.finished
	click.emit()
