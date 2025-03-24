extends Node2D


const COLOR_VARIATIONS: Array[Color] = [Color('e86fae'), Color('6fa9e8'), Color('896fe8'), Color('e86fa9'), Color('fefefe')]
@onready var petals: Polygon2D = $Petals
@onready var petals_2: Polygon2D = $Petals2
@onready var extra_petals_2: Polygon2D = $ExtraPetals2
@onready var extra_petals: Polygon2D = $ExtraPetals
@export var color: Color

func _ready() -> void:
	color = COLOR_VARIATIONS.pick_random()
	#petals.color = color
	#extra_petals.color = color
	petals_2.color = color
	extra_petals_2.color = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
