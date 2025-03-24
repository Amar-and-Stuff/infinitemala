extends Camera2D

@export var decay : float = 0.9 # Time it takes to reach 0% of trauma
@export var max_offset : Vector2 = Vector2(100, 75) # Max hor/ver shake in pixels
@export var max_roll : float = 0.1 # Maximum rotation in radians (use sparingly)

signal finished

var trauma : float = 0.0 # Current shake strength
var trauma_power : int = 2 # Trauma exponent. Increase for more extreme shaking
var shaking: bool = false


func _ready() -> void:
	#? Randomize the game seed
	randomize()

func _process(delta : float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		add_trauma(.5)
	if trauma: # If the camera is currently shaking
		trauma = max(trauma - decay * delta, 0) # Decay the shake strength
		shake() # Shake the camera
		shaking = true
	else:
		if shaking:
			finished.emit()
			shaking = false
	

## The function to use for adding trauma (screen shake)
func add_trauma(amount : float) -> void:
	trauma = min(amount, 1.0) # Add the amount of trauma (capped at 1.0)

## This function is used to actually apply the shake to the camera
func shake() -> void:
	#? Set the camera's rotation and offset based on the shake strength
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)
