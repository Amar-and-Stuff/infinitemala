extends Area2D

var speed: float = 10
var direction: Vector2 = Vector2(0,0)
@onready var sprite: Node2D = $Sprite
@onready var aura: Node2D = $Aura

func _process(delta: float) -> void:
	position += direction * speed
	sprite.rotation += deg_to_rad(9)
	aura.rotation += deg_to_rad(3)
