extends Node2D

@onready var player: Area2D = $Player
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var thread: Path2D = $Thread
@onready var instance_point: PathFollow2D = $SpawnPath2D/InstancePoint
const SEED = preload("res://gameobjects/seed.tscn")
const GAME_OVER_MUSIC = preload("res://music/game_over.mp3")
const GAME_WIN_MUSIC = preload("res://music/funky-victory-loop-noguitar.mp3")
@onready var flower_sfx_player: AudioStreamPlayer = $FlowerSFXPlayer
@onready var seed_sfx_player: AudioStreamPlayer = $SeedSFXPlayer
@onready var seeds: Node2D = $Seeds
@onready var retry: Control = $HUD/Retry

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_area_entered(area: Area2D) -> void:
	if area.is_in_group("seed"):
		seed_sfx_player.play()
		area.queue_free()
		player.add_flower()
	elif area.is_in_group('flower'):
		flower_sfx_player.play()
		area.queue_free()


func _on_timer_timeout() -> void:
	var obstacle_seed: Area2D = SEED.instantiate()
	seeds.add_child(obstacle_seed)
	instance_point.progress_ratio = randf()
	obstacle_seed.position = instance_point.position
	obstacle_seed.direction = (Vector2(1920/2 + randf_range(-400, 400), 1080/2 + randf_range(-250,250)) - obstacle_seed.position).normalized()


func _on_player_dead() -> void:
	retry.initilize(-1)
	retry.visible = true
	clear_level()
	audio_stream_player.stream = GAME_OVER_MUSIC
	audio_stream_player.play()


func _on_player_won() -> void:
	retry.initilize(1)
	retry.visible = true
	clear_level()
	audio_stream_player.stream = GAME_WIN_MUSIC
	audio_stream_player.play()


func clear_level() -> void:
	$Timer.queue_free()
	seeds.queue_free()
	player.queue_free()
	thread.queue_free()
	
