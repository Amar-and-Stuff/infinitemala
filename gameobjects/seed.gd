extends Area2D

var speed: float = 10
var direction: Vector2 = Vector2(0,0)
var rot: float


func _ready() -> void:
	rot = randf_range(-1.5,1.5)

func _process(delta: float) -> void:
	position += direction * speed
	rotation += deg_to_rad(rot)
