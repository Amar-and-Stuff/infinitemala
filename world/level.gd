extends Node2D


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var player_manager: Node2D = $playerManager
@onready var camera_2d: Camera2D = $Camera2D
@onready var instance_point: PathFollow2D = $SpawnPath2D/InstancePoint
const SEED = preload("res://gameobjects/seed.tscn")
const GAME_OVER_MUSIC = preload("res://music/game_over.mp3")
const GAME_WIN_MUSIC = preload("res://music/funky-victory-loop-noguitar.mp3")
@onready var seeds: Node2D = $Seeds
@onready var retry: Control = $HUD/Retry
@onready var pause_panel_container: PanelContainer = $HUD/PausePanelContainer
var game_completed: bool = false
@onready var background_polygon: Polygon2D = $BackgroundPolygon


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc") and !game_completed:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_game()


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_timer_timeout() -> void:
	var obstacle_seed: Area2D = SEED.instantiate()
	seeds.add_child(obstacle_seed)
	instance_point.progress_ratio = randf()
	obstacle_seed.position = instance_point.position
	obstacle_seed.direction = (Vector2(1920/2 + randf_range(-400, 400), 1080/2 + randf_range(-250,250)) - obstacle_seed.position).normalized()


func _on_player_manager_dead() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	retry.initilize(-1)
	retry.visible = true
	clear_level()
	audio_stream_player.stream = GAME_OVER_MUSIC
	audio_stream_player.play()


func _on_player_manager_won() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	retry.initilize(1)
	retry.visible = true
	clear_level()
	audio_stream_player.stream = GAME_WIN_MUSIC
	audio_stream_player.play()


func clear_level() -> void:
	game_completed = true
	$Timer.queue_free()
	seeds.queue_free()
	player_manager.queue_free()


func pause_game() -> void:
	pause_panel_container.visible = true
	get_tree().paused = true


func _on_player_manager_seed_impact() -> void:
	camera_2d.add_trauma(0.5)
	background_polygon.self_modulate = Color("ffbebe")
	get_tree().create_tween().tween_property(background_polygon, "self_modulate", Color.WHITE, 0.5)
