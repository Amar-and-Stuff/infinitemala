extends Area2D

signal dead


var health: float = 100
var mouse_motion: InputEventMouseMotion
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

func _ready() -> void:
	cpu_particles_2d.color = Color('604022')


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		position += event.relative


func take_damage(damage: float) -> void:
	health -= damage
	if health <= 0:
		dead.emit()


func heal(hp: float) -> void:
	health += hp
	health = clamp(health, 0, 100)
