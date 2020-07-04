extends Node2D

class_name State

var speed = 200.0
var looking_point: Vector2
var path: PoolVector2Array
var change_state
var entity
var new_state

func _ready():
	position = entity.position


func setup(change_state, entity):
	self.change_state = change_state
	self.entity = entity
