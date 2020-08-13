extends Node

class_name Entity

export var durability: float = 100.0
export var durability_repair_threshold: float = 80.0
export var durability_decay_speed: float = 1.0
export var durability_decay_timer: float = 0.0
export var durability_decay_amount: float = 1.0

export var on: bool = false

func _ready():
	pass

func need_repair() -> bool:
	if self.durability <= self.durability_repair_threshold:
		return true
	else:
		return false

func _physics_process(delta):
	if self.durability > 0.0:
		self.durability_decay_timer += delta
		if self.durability_decay_timer >= self.durability_decay_speed:
			self.durability -= durability_decay_amount
			if self.durability < 0.0:
				self.durability = 0.0
			self.durability_decay_timer = 0.0
