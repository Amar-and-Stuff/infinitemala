extends Node2D


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var player_manager: Node2D = $playerManager
@onready var camera_2d: Camera2D = $Camera2D
@onready var seed_instance_point: PathFollow2D = $SpawnPath2D/SeedInstancePoint
@onready var chakram_instance_point: PathFollow2D = $SpawnPath2D/ChakramInstancePoint
const SEED = preload("res://gameobjects/seed.tscn")
const CHAKRAM = preload("res://gameobjects/chakram.tscn")
const HEALTH = preload("res://world/health.tscn")
const GAME_OVER_MUSIC = preload("res://music/game_over.mp3")
const GAME_WIN_MUSIC = preload("res://music/funky-victory-loop-noguitar.mp3")
@onready var seeds: Node2D = $Seeds
@onready var retry: Control = $HUD/Retry
@onready var pause_panel_container: PanelContainer = $HUD/PausePanelContainer
var game_completed: bool = false
@onready var background_polygon: Polygon2D = $BackgroundPolygon
var time_count: float = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc") and !game_completed:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_game()


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_timer_timeout() -> void:
	spawn_object(SEED.instantiate())
	


func spawn_object(obj: Node2D) -> void:
	seeds.add_child(obj)
	seed_instance_point.progress_ratio = randf()
	obj.position = seed_instance_point.position
	obj.direction = (Vector2(1920/2 + randf_range(-400, 400), 1080/2 + randf_range(-250,250)) - obj.position).normalized()


func _on_player_manager_dead() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	retry.initilize(-1, time_count)
	retry.visible = true
	clear_level()
	audio_stream_player.stream = GAME_OVER_MUSIC
	audio_stream_player.play()


func _on_player_manager_won() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	retry.initilize(1, time_count)
	retry.visible = true
	clear_level()
	audio_stream_player.stream = GAME_WIN_MUSIC
	audio_stream_player.play()


func clear_level() -> void:
	game_completed = true
	$Timer.queue_free()
	$ObstacleTimer.queue_free()
	$HealthTimer.queue_free()
	$HUD/Label.queue_free()
	seeds.queue_free()
	player_manager.queue_free()


func pause_game() -> void:
	pause_panel_container.visible = true
	get_tree().paused = true


func _on_player_manager_damage_impact() -> void:
	camera_2d.add_trauma(0.5)
	background_polygon.self_modulate = Color("ffbebe")
	get_tree().create_tween().tween_property(background_polygon, "self_modulate", Color.WHITE, 0.5)


func _on_obstacle_timer_timeout() -> void:
	spawn_object(CHAKRAM.instantiate())


func _on_health_timer_timeout() -> void:
	spawn_object(HEALTH.instantiate())


func _on_player_manager_heal_taken() -> void:
	background_polygon.self_modulate = Color("bdffd1")
	get_tree().create_tween().tween_property(background_polygon, "self_modulate", Color.WHITE, 0.5)


func _on_time_counter_timeout() -> void:
	time_count += 1
