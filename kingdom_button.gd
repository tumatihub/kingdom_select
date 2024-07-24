class_name KingdomButton
extends Control

@export var button: Button
@export var animation_player: AnimationPlayer
@export var name_label: Label

func init_button(camera: Camera, kingdom: Kingdom) -> void:
	button.pressed.connect(camera.look_at_kingdom.bind(kingdom))
	name_label.text = kingdom.name

func select() -> void:
	animation_player.play("select")

func deselect() -> void:
	animation_player.play_backwards("select")
