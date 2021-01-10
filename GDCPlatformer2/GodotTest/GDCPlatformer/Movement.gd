extends KinematicBody2D
class_name Movement

const FLOOR_NORMAL = Vector2.UP
export var velocity = Vector2.ZERO
export var gravity = 500.0
var gravityBonus = 1
var usingGravity = true


func _physics_process(delta):
	#velocity = Vector2.ZERO
	apply_gravity()
	#move_and_slide(velocity)
	#print_debug("velocity = " + (velocity as String))
	move_and_slide(velocity, FLOOR_NORMAL)
	pass

func apply_gravity():
	if (usingGravity):
		velocity.y += get_gravity()
	
func get_gravity() -> float:
	return gravity * get_physics_process_delta_time() * gravityBonus
