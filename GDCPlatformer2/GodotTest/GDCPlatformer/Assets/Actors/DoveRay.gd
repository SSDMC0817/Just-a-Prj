extends RayCast2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var dove

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dove = get_owner()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collision = get_collider()
	if (collision != null):
		print(collision)
	if (collision != null && collision.is_in_group("Enemy")):
		hitEnemy(collision)
		
func hitEnemy(var enemy):
	yield(get_tree().create_timer(.05), "timeout")
	dove.queue_free()
	enemy.hit()
