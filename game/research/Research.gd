extends Object

class_name Research


var research_name := ''
var tier := 0
var cost := 0
var progress := 0.0
var progress_required := 0.0
var in_progress := false
var is_complete := false
var affect := 0.0


func _init(research_name: String, tier: int, cost: int, progress_required: float, affect: float):
	self.research_name = research_name
	self.tier = tier
	self.cost = cost
	self.affect = affect
	self.progress_required = progress_required


func _ready():
	pass


func start_progress() -> void:
	self.in_progress = true


func add_progress(amount: float) -> void:
	self.progress += amount
	if self.progress >= self.progress_required:
		self.progress = self.progress_required
		self.is_complete = true


func get_progress_percentage() -> float:
	var percentage := (self.progress / self.progress_required) * 100
	return percentage
