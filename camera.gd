class_name Camera
extends Node3D

var tween: Tween

func look_at_kingdom(kingdom: Kingdom):
	if tween:
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tween.tween_property(self, "rotation_degrees", Vector3(kingdom.x, kingdom.y, 0), 1.5)
