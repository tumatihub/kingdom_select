@tool
extends CSGPolygon3D

@export var line_radius := 0.1
@export var line_resolution := 180

func _process(delta: float) -> void:
	var circle := PackedVector2Array()
	for degree in line_resolution:
		var x := line_radius * sin(PI * 2 * degree / line_resolution)
		var y := line_radius * cos(PI * 2 * degree / line_resolution)
		var coords := Vector2(x, y)
		circle.append(coords)
	polygon = circle
