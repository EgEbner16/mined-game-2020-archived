extends Object


class_name TileData


var tile_index: int
var type: String
var navigation: bool
var health: float
var material_per_health: float
var digging_coolant_required: float


func save_object():
	var save_dict = {
		'tile_index': self.tile_index,
		'type': self.type,
		'navigation': self.navigation,
		'health': self.health,
		'material_per_health': self.material_per_health,
		'digging_coolant_required': self.digging_coolant_required,
	}
	return save_dict


func load_object(object_dict):
	for object in object_dict:
		self.set(object, object_dict[object])


func _init(tile_index:= 0, type:= '', navigation:= false, health:= 0.0, material_per_health:= 0.0, digging_coolant_required:= 0.0):
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

