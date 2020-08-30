extends Node2D

class_name State

var speed: float
var looking_point: Vector2
var path: PoolVector2Array
var change_state
var actor
var new_state

func _ready():
	position = actor.position
	speed = actor.speed


func setup(change_state, actor):
	self.change_state = change_state
	self.actor = actor
