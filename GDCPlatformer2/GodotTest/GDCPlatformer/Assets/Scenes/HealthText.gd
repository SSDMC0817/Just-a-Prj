extends RichTextLabel


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var health = 0
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_current_scene().get_node("Player2")

func _process(delta):
	updateHealth()

func updateHealth():
	health = player.health
	text = ("health: " + (health as String))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
