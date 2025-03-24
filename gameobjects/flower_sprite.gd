extends Node2D


const COLOR_VARIATIONS: Array[Color] = [Color('e86fae'), Color('6fa9e8'), Color('896fe8'), Color('e86fa9'), Color('fefefe')]
@onready var petals: Polygon2D = $Petals
@onready var extra_petals: Polygon2D = $ExtraPetals
@export var color: Color

func _ready() -> void:
	color = COLOR_VARIATIONS.pick_random()
	petals.color = color
	extra_petals.color = color
