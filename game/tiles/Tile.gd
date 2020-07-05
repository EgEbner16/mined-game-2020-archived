extends Object

class_name Tile

var location: Vector2 = Vector2.ZERO
var health: float = 0.0
var index: int = 0

func _init(tile_location: Vector2, tile_index: int):
	self.location = tile_location
	self.index = tile_index
	self.health = tile_index * 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
