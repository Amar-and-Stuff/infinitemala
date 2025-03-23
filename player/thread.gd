extends Path2D

const FLOWER = preload("res://gameobjects/flower.tscn")
@export var follow_node: Node2D
@onready var previous_follow_node_position: Vector2 = follow_node.position
@export var length: float
@export var distance_between_curve_points: float = 10
@onready var line: Line2D = $Line2D
var number_of_follower_nodes: int = 20
var follower_nodes: Array[PathFollow2D] = []


func _process(delta: float) -> void:
	line.points = curve.tessellate()
	length = curve.get_baked_length()
	if follow_node_position_changed():
		add_points_along(previous_follow_node_position, follow_node.position)
	remove_empty_follower_nodes()



func follow_node_position_changed() -> bool:
	if previous_follow_node_position.distance_to(follow_node.position) >= distance_between_curve_points:
		return true
	return false

func is_thread_length_exceeded() -> bool:
	if curve.get_baked_length() > 1064:
		return true
	return false

func add_points_along(start: Vector2, end: Vector2) -> void:
	var point_count: int = end.distance_to(start) / distance_between_curve_points
	var direction_vector: Vector2 = (end - start).normalized()
	for i in range(1, point_count+1):
		curve.add_point(start + direction_vector * i * distance_between_curve_points, Vector2(0,0), Vector2(0,0), 0)
	previous_follow_node_position = start + direction_vector * distance_between_curve_points * point_count
	if is_thread_length_exceeded():
		for i in range(point_count):
			curve.remove_point(curve.point_count - 1)

func add_flower() -> void:
	var path_follow: PathFollow2D = PathFollow2D.new()
	add_child(path_follow)
	var flower: Area2D = FLOWER.instantiate()
	flower.seed_hit_flower.connect(take_damage)
	flower.rotation = randf() / 2
	path_follow.call_deferred("add_child", flower)
	
	follower_nodes.insert(0,path_follow)
	for i in range(len(follower_nodes)):
		follower_nodes[i].progress = 50 * i + 100


func take_damage() -> void:
	follow_node.take_damage()


func remove_empty_follower_nodes() -> void:
	for i in range(len(follower_nodes)-1, -1, -1):
		if follower_nodes[i].get_child_count() == 0:
			var temp: PathFollow2D = follower_nodes.pop_at(i)
			temp.queue_free()
