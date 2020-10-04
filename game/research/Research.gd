extends Node


class_name Research


onready var research_interface := get_node('/root/Game/InterfaceManager/ResearchInterface')


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


func save_object():
	var save_dict = {
		'filename': get_filename(),
		'parent': get_parent().get_path(),
		'research_name': self.research_name,
		'tier': self.tier,
		'cost': self.cost,
		'progress': self.progress,
		'progress_required': self.progress_required,
		'in_progress': self.in_progress,
		'is_complete': self.is_complete,
		'affect_type': self.affect_type,
		'affect_upgrade': self.affect_upgrade,
		'affect_default': self.affect_default,
	}
	return save_dict


func load_object():
	pass


func after_load_object():
	pass

func setup(research_name: String, tier: int, cost: int, progress_required: float, affect_type: String, affect_upgrade: float, affect_default: float):
	self.research_name = research_name
	self.tier = tier
	self.cost = cost
	self.affect_type = affect_type
	self.affect_upgrade = affect_upgrade
	self.affect_default = affect_default
	self.progress_required = progress_required


func _ready():
	self.name = self.research_name
	self.add_to_group('Persist')
	if self.in_progress:
		self.set_process(true)
	else:
		self.set_process(false)
	research_interface.create_research_button(self)


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
