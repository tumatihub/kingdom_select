class_name KingdomSelector
extends Node3D

@export var kingdom_list: Array[Kingdom]
@export var selector_scene: PackedScene
@export var world: Node3D
@export var camera: Camera
@export var ui_selector: UISelector
@export var line_material: Material

var index := 0

func _ready() -> void:
	var prev_selector: Selector
	for kingdom in kingdom_list:
		var selector := selector_scene.instantiate() as Selector
		world.add_child(selector)
		selector.rotation_degrees = Vector3(kingdom.x, kingdom.y, 0)
		kingdom.selector = selector
		if prev_selector:
			_create_line(prev_selector.get_pin_pos(), selector.get_pin_pos())
		prev_selector = selector
	ui_selector.create_buttons(kingdom_list, camera)
	camera.look_at_kingdom(kingdom_list[index])
	ui_selector.select_kingdom(index)
	kingdom_list[index].selector.show_indicator()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right"):
		_next_kingdom()
	if Input.is_action_just_pressed("ui_left"):
		_prev_kingdom()

func _next_kingdom() -> void:
	ui_selector.deselect_kingdom(index)
	kingdom_list[index].selector.hide_indicator()
	index += 1
	if index > kingdom_list.size() - 1:
		index = 0
	camera.look_at_kingdom(kingdom_list[index])
	ui_selector.select_kingdom(index)
	kingdom_list[index].selector.show_indicator()

func _prev_kingdom() -> void:
	ui_selector.deselect_kingdom(index)
	kingdom_list[index].selector.hide_indicator()
	index -= 1
	if index < 0:
		index = kingdom_list.size() - 1
	camera.look_at_kingdom(kingdom_list[index])
	ui_selector.select_kingdom(index)
	kingdom_list[index].selector.show_indicator()

func _create_line(prev_kingdom_pos: Vector3, current_kingdom_pos: Vector3) -> void:
	var height := 0.7
	var world_radius := 10.0
	var bezier_strength: float
	var mid_point_orig := lerp(prev_kingdom_pos, current_kingdom_pos, 0.5) as Vector3
	bezier_strength = mid_point_orig.distance_to(prev_kingdom_pos) / 2
	var mid_point = mid_point_orig.normalized() * world_radius + mid_point_orig.normalized() * height
	var in_vector := (prev_kingdom_pos - mid_point_orig).normalized() * bezier_strength
	var out_vector := (current_kingdom_pos - mid_point_orig).normalized() * bezier_strength
	var path := Path3D.new()
	var curve := Curve3D.new()
	curve.add_point(prev_kingdom_pos)
	curve.add_point(mid_point, in_vector, out_vector)
	curve.add_point(current_kingdom_pos)
	path.curve = curve
	world.add_child(path)
	
	#Gizmo
	#var sphere := CSGSphere3D.new()
	#sphere.radius = .2
	#sphere.global_position = mid_point
	#world.add_child(sphere)
	
	#polygon
	var polygon := CSGPolygon3D.new()
	polygon.path_interval = 0.13
	polygon.path_node = path.get_path()
	polygon.mode = CSGPolygon3D.MODE_PATH
	world.add_child(polygon)
	polygon.material = line_material
	
	var line_radius := 0.03
	var line_resolution := 8

	var circle := PackedVector2Array()
	for degree in line_resolution:
		var x := line_radius * sin(PI * 2 * degree / line_resolution)
		var y := line_radius * cos(PI * 2 * degree / line_resolution)
		var coords := Vector2(x, y)
		circle.append(coords)
	polygon.polygon = circle

