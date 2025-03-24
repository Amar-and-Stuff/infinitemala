extends Node2D

signal won
signal dead
signal seed_impact

@onready var player: Area2D = $Player
@onready var thread: Path2D = $Thread
@onready var seed_sfx_player: AudioStreamPlayer = $SeedSFXPlayer
@onready var health_bar: ProgressBar = $CanvasLayer/UI/HealthBar
@onready var progress_bar: ProgressBar = $CanvasLayer/UI/ProgressBar
@onready var health_bar_x: float = health_bar.position.x
@onready var health_bar_y: float = health_bar.position.y


func _ready() -> void:
	var sb: StyleBoxFlat = StyleBoxFlat.new()
	health_bar.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("ff0000")
	var sbp: StyleBoxFlat = StyleBoxFlat.new()
	progress_bar.add_theme_stylebox_override("fill", sbp)
	sbp.bg_color = Color("22abff")


func _process(delta: float) -> void:
	progress_bar.value = len(thread.follower_nodes) * 5
	if health_bar.value < 30:
		shake_health_bar()


func _on_player_dead() -> void:
	dead.emit()


func _on_player_won() -> void:
	won.emit()


func shake_health_bar() -> void:
	var shake_intensity: int = 5
	health_bar.position.x = health_bar_x + randf_range(-shake_intensity, shake_intensity)
	health_bar.position.y = health_bar_y + randf_range(-shake_intensity, shake_intensity)


func add_flower() -> void:
	thread.add_flower()
	if len(thread.follower_nodes) == 20:
		won.emit()


func _on_player_area_entered(area: Area2D) -> void:
	if area.is_in_group("seed"):
		player.cpu_particles_2d.emitting = true
		seed_sfx_player.play()
		area.queue_free()
		add_flower()


func _on_thread_flower_damaged() -> void:
	player.take_damage()
	seed_impact.emit()
	health_bar.value = player.health


func _on_thread_flower_count_reached() -> void:
	won.emit()
