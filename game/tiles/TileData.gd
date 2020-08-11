extends Object

class_name TileData

var tile_index: int
var type: String
var navigation: bool
var health: float
var material_per_health: float
var digging_coolant_required: float

func _init(tile_index: int = 0, type: String = '', navigation: bool = false, health: float = 0.0, material_per_health: float = 0.0, digging_coolant_required: float = 0.0):
	self.tile_index = tile_index
	self.type = type
	self.navigation = navigation
	self.health = health
	self.material_per_health = material_per_health
	self.digging_coolant_required = digging_coolant_required

func copy(tile_data: TileData) -> void:
	self.tile_index = tile_data.tile_index
	self.type = tile_data.type
	self.navigation = tile_data.navigation
	self.health = tile_data.health
	self.material_per_health = tile_data.material_per_health
	self.digging_coolant_required = tile_data.digging_coolant_required
