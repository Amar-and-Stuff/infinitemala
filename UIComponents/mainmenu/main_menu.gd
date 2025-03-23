extends Control

@export_file("*.tscn") var game_scene_file: String

func _ready() -> void:
	pass


func _on_quit_click() -> void:
	get_tree().quit()


func _on_play_click() -> void:
	get_tree().change_scene_to_file(game_scene_file)
