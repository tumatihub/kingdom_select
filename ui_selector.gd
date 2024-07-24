class_name UISelector
extends Control

@export var kingdom_button_scene: PackedScene
@export var buttons_container: HBoxContainer
@export var animation_player: AnimationPlayer

var button_list: Array[KingdomButton]

func create_buttons(kingdom_list: Array[Kingdom], camera: Camera) -> void:
	for k in kingdom_list:
		var button := kingdom_button_scene.instantiate() as KingdomButton
		button.init_button(camera, k)
		buttons_container.add_child(button)
		button_list.append(button)

func select_kingdom(index: int) -> void:
	button_list[index].select()

func deselect_kingdom(index: int) -> void:
	button_list[index].deselect()
