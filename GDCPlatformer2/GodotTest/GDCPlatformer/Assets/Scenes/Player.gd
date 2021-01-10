extends Movement

var moveX = 0.0
export var speed = 300.0
export var jumpStrength = 100.0
var animator
var mySprite;
export var doves = 2;
export var maxDoves = 2;
#[Dove Variables]
var doveObject
var doveActiveTime: Array;
export var doveTime = 1.0
export var addDoveTime = .2

var animation: String
export var health = 3

export var hitSpeed = .5

var numberOfEnemies = 0
#[Hurt Animation]
var hurtLength = 5
var hurtAnimator

func _ready():
	animator = $AnimationTree.get("parameters/playback")
	hurtAnimator = $AnimationTree2.get("parameters/playback")
	mySprite = $MySprite
	doves = 2
	doveObject = load("res://Assets/Actors/Dove.tscn")
	doveActiveTime.resize(maxDoves)

func _physics_process(delta : float):
	#move = Vector2.ZERO
	#velocity = Vector2.ZERO
	#apply_gravity()
	shoot_check()
	jump_check()
	xMovement()
	velocity.x = moveX

func jump_check():
	if (is_on_floor()):
		if (velocity.y > 0):
			velocity.y = 0
		gravityBonus = 1
		#velocity.y = 0
		if (animation != "Shoot"):
			set_animation("Idle")
		#animator["parameters/conditions/jump"] = false
		if (Input.is_action_just_pressed("Jump")):
			#animator["parameters/conditions/jump"] = true
			set_animation("Jump")
			if (Input.get_action_strength("Jump") > .7):
				velocity.y = -(jumpStrength + get_gravity())
			else:
				velocity.y = -((jumpStrength * .5) + get_gravity())
	elif(is_on_ceiling()):
		velocity.y = 0
	elif(Input.is_action_just_pressed("Down")):
		gravityBonus = 2

func xMovement():
	moveX = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	if (animation != "Jump" && animation != "Shoot"):
		if (moveX != 0):
			set_animation("Move")
	
	if (moveX > .1):
		mySprite.scale.x = 1
	elif (moveX < -.1):
		mySprite.scale.x = -1
	moveX *= speed;

func shoot_check():
	if (Input.is_action_just_pressed("Shoot") && doves > 0):
		#doveObject.scale.x = scale.x
		set_animation("Shoot")
		
		var currentDove = doveObject.instance()
		print_debug("dove spawn")
		currentDove.position = position
		currentDove.scale.x = mySprite.scale.x
		currentDove.direction = mySprite.scale.x
		get_tree().get_current_scene().add_child(currentDove)
		doveActiveTime[maxDoves - doves] = 0.0
		doves -= 1
		add_dove()
		
func add_dove():
	yield(get_tree().create_timer(addDoveTime), "timeout")
	doves += 1
	
func set_animation(var state: String):
	animation = state
	animator.travel(state)
	if (state == "Shoot"):
		yield(get_tree().create_timer(.2), "timeout")
		animation = "Move"

func hit():
	velocity.x = -scale.x * hitSpeed
	velocity.y = -hitSpeed
	health -= 1
	hurtAnimator.travel("playerHurt")
	if (health < 0):
		get_tree().change_scene("res://Assets/Scenes/Lose.tscn")
	yield(get_tree().create_timer(1), "timeout")
	hurtAnimator.travel("playerNormal")

func addEnemy():
	numberOfEnemies += 1
	
func destroyEnemy():
	numberOfEnemies -= 1
	if (numberOfEnemies <= 0):
		get_tree().change_scene("res://Assets/Scenes/Win.tscn")
