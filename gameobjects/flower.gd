extends Area2D

signal seed_hit_flower
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var flower_sprite: Node2D = $FlowerSprite

func _ready() -> void:
	cpu_particles_2d.color = flower_sprite.color


func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('seed'):
		area.queue_free()
		seed_hit_flower.emit()
	audio_stream_player.play()
	flower_sprite.visible = false
	cpu_particles_2d.emitting = true
	await audio_stream_player.finished
	queue_free()
