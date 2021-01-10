extends KinematicBody2D


export var speed = 250
export var health = 2
#var collision: KinematicCollision2D
var raycast

var waitTime = 1.0
var velocity
var isMoving = true
var player
#var playerScale: Vector2
#[Hurt Animation]
var hurtLength = 5
var hurtAnimator


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	raycast = [self.get_node("RayCast"), self.get_node("RayCast2"), self.get_node("RayCast3")]
	move_coroutine()
	player = get_tree().get_current_scene().get_node("Player2")
	player.addEnemy()
	#usingGravity = false
	#playerScale = get_tree().get_current_scene().get_node("Player/MySprite").scale
	hurtAnimator = $AnimationTree2.get("parameters/playback")

func _physics_process(delta):
	var direction = -(position.x - player.position.x)
	direction = direction / abs(direction)
	velocity = Vector2(direction * speed, 0)
	movement()
	#hit()
	
	
func hit():
	#if (collision != null):
		#var groups = collision.collider.get_groups()
		#for g in groups:
			#print_debug("g = " + g)
			#if (g == "Dove"):
	health -= 1
	hurtAnim()
	print_debug("health - 1")
				#get_tree().get_current_scene().remove_child(collision.get_tree().get_current_scene())
				
	if (health <= 0):
		player.destroyEnemy()
		queue_free()

func hurtAnim():
	hurtAnimator.travel("punchHurt")
	yield(get_tree().create_timer(1), "timeout")
	hurtAnimator.travel("punchEmpty")

func move_coroutine():
	while (true):
		yield(get_tree().create_timer(waitTime), "timeout")
		isMoving = !isMoving

func movement():
	if (isMoving):
		#collision = move_and_collide(velocity)
		move_and_slide(velocity)
		
		#if (collision != null && collision.collider.is_in_group("Player")):
		for r in raycast:
			var collider = r.get_collider()
			if (collider != null && collider.is_in_group("Player")):
				if (canHit() != null):
					collider.hit()

func canHit():
	yield(get_tree().create_timer(.3), "timeout")
	return true
