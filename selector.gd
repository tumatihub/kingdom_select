class_name Selector
extends Node3D

@export var pin: Node3D
@export var indicator_particles: GPUParticles3D

func get_pin_pos() -> Vector3:
	return pin.global_position

func show_indicator() -> void:
	indicator_particles.emitting = true

func hide_indicator() -> void:
	indicator_particles.restart()
	indicator_particles.emitting = false
