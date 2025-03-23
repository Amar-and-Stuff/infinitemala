extends Area2D

signal seed_hit_flower
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('seed'):
		area.queue_free()
		audio_stream_player.play()
		await audio_stream_player.finished
		seed_hit_flower.emit()
		
		queue_free()
