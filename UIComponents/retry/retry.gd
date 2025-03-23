extends Control

@export_file("*.tscn") var game_scene_file: String
@export var bg_color: Color
@export var win_color: Color
@export var lost_color: Color
@onready var color_rect: ColorRect = $Panel/ColorRect
@onready var score_lable: Label = $Panel/ScoreLable


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file(game_scene_file)


func initilize(score: int) -> void:
	if score == -1:
		score_lable.text = "You lost"
		color_rect.color = lost_color
	else:
		score_lable.text = "You win"
		color_rect.color = win_color
