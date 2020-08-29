extends Node

class_name Research


var research_name := ''
var tier := 0
var cost := 0
var progress := 0.0
var progress_required := 0.0
var in_progress := false
var is_complete := false
var affect_type := ''
var affect_upgrade := 0.0
var affect_default := 0.0


func _init(research_name: String, tier: int, cost: int, progress_required: float, affect_type: String, affect_upgrade: float, affect_default: float):
	self.research_name = research_name
	self.name = research_name
	self.tier = tier
	self.cost = cost
	self.affect_type = affect_type
	self.affect_upgrade = affect_upgrade
	self.affect_default = affect_default
	self.progress_required = progress_required


func _ready():
	self.set_process(false)


func _process(delta):
	self.add_progress(delta)


func start_progress() -> void:
	self.in_progress = true
	self.set_process(true)


func add_progress(amount: float) -> void:
	self.progress += amount
	if self.progress >= self.progress_required:
		self.progress = self.progress_required
		self.is_complete = true
		self.get_parent().update_research_affect()
		self.set_process(false)


func get_progress_percentage() -> float:
	var percentage := (self.progress / self.progress_required) * 100
	return percentage
