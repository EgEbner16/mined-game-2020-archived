extends Object

class_name Tile

var tile_data: TileData = TileData.new()

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

func _init(tile_location: Vector2, tile_data: TileData):
	self.location = tile_location
	self.tile_data.copy(tile_data)

func _ready():
	pass

func remove_health(amount: float):
	self.tile_data.health -= amount
#	print('Tile %s has %s health' % [location, health])
