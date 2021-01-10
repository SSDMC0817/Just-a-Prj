extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
#var facingRight = true
export var speed: float
var direction # 1 means right, -1 means left
var collision
var activeTime : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#usingGravity = false

func _physics_process(delta):
	#var direction = 1
	#if (!facingRight):
	#	direction = -1
	var velocity = Vector2 (speed * direction, 0)
	#collision = move_and_collide(velocity)
	move_and_slide(velocity)
	if (collision != null && collision.collider.is_in_group("Enemy")):
		hitEnemy(collision.collider)

func hitEnemy(var enemy):
	yield(get_tree().create_timer(.05), "timeout")
	queue_free()
	enemy.hit()

func _process(delta):
	activeTime += delta
	if (activeTime > get_tree().get_current_scene().get_node("Player2").doveTime):
			queue_free()
	#if ((collision as Object) != null):
		#print()
		#var groups = collision.collider.get_groups()
		#for g in groups:
		#	if (g == "Enemy"):
		#		pass#queue_free()
