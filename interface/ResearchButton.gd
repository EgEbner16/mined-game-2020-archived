extends VBoxContainer


onready var research: Research = get_node(research_node_path)
onready var resource_manager: ResourceManager = get_node('/root/Game/ResourceManager')


var research_node_path: String


func _ready():
	self.set_process(false)


func _process(delta):
	var progress = self.research.get_progress_percentage()
	$ProgressBar.value = progress
	if progress >= 100.0:
		self.set_process(false)


func _input(event):
	if $Button.pressed:
		if not self.research.in_progress and self.resource_manager.use_capital(research.cost):
			research.start_progress()
			self.set_process(true)
