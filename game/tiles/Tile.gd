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


func save_object():
	var save_dict = {
		'location': GlobalSaveManager.save_vector2(location),
		'health': self.health,
		'mass': self.mass,
		'index': self.index,
		'accessibility': self.accessibility,
		'tile_data': self.tile_data.save_object(),
	}
	return save_dict


func load_object(object_dict):
	pass


func _init():
	pass
	

func _ready():
	pass


func setup(tile_location: Vector2, tile_data: TileData):
	self.location = tile_location
	self.tile_data.copy(tile_data)


func remove_health(amount: float):
	self.tile_data.health -= amount
#	print('Tile %s has %s health' % [location, health])
