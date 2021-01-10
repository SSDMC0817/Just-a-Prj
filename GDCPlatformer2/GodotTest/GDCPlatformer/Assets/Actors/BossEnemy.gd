extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var gravity = 100
export var health = 10
export var speed = 250.0
export var jumpSpeed = 400
var velocity = Vector2 (0,0)
var jump = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta):
	if (is_on_floor()):
		apply_gravity()
		if (jump):
			velocity.y = -jumpSpeed
	move_and_slide(velocity, Vector2.UP)
	
func _process(delta):
	pass#if ()
	#hit()
	
func hit():
	health -= 1
	hurtAnim()
	print_debug("health - 1")
	if (health <= 0):
		#player.destroyEnemy()
		queue_free()
		
func hurtAnim():
	pass	

func apply_gravity():
	velocity.y += get_gravity()
	
func get_gravity() -> float:
	return gravity * get_physics_process_delta_time()
