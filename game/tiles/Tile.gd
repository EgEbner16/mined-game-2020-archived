extends Object

class_name Tile

var location: Vector2 = Vector2.ZERO
var health: float = 0.0
var mass: float = 0.0
var index: int = 0

var accessibility: Dictionary = {
	'north': false,
	'east': false,
	'south': false,
	'west': false,
	'center': false,
}

func _init(tile_location: Vector2, tile_index: int):
	self.location = tile_location
	self.index = tile_index
	self.health = tile_index * tile_index * 100.0
	self.mass = tile_index * tile_index * 100.0

func _ready():
	pass

func remove_health(amount: float):
	self.health -= amount
#	print('Tile %s has %s health' % [location, health])
