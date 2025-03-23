extends Area2D

signal dead
signal won

@export var thread: Path2D
var player_health: float = 100
@onready var health_bar: ProgressBar = $CanvasLayer/UI/HealthBar
@onready var progress_bar: ProgressBar = $CanvasLayer/UI/ProgressBar

func _ready() -> void:
	var sb = StyleBoxFlat.new()
	health_bar.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("ff0000")

func _process(delta: float) -> void:
	position = get_global_mouse_position()
	progress_bar.value = len(thread.follower_nodes) * 5

func add_flower() -> void:
	thread.add_flower()
	if len(thread.follower_nodes) == 20:
		won.emit()
	

func _on_flower_seed_hit_flower() -> void:
	take_damage()

func take_damage() -> void:
	player_health -= 10
	health_bar.value = player_health
	if player_health <= 0:
		dead.emit()
