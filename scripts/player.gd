extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Accelerate to maximum when accelerate is pressed
	# Brake when breake is pressed
	# Turn left or right when either is pressed
	#	- Vary turn strength by speed (emulate drive by wire)
	# Do not turn when no forward or backward momentum.
	# 	(Turning multiplies vel by perpendicular vector?)
	move_and_slide()

func _apply_acceleration() -> void:
	pass

func _apply_brake_force() -> void:
	pass

func _turn() -> void:
	pass
