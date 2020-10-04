extends VBoxContainer


onready var research: Research = get_node(research_node_path)
onready var resource_manager: ResourceManager = get_node('/root/Game/ResourceManager')


var research_node_path: String


func on_after_load_game():
	resource_manager = get_node('/root/Game/ResourceManager')


func _ready():
	self.add_to_group('Purge')


func _process(delta):
	var progress = self.research.get_progress_percentage()
	$ProgressBar.value = progress
	if progress < 100.0 and progress > 0.0:
		$ProgressBar.modulate = Color(1.0, 1.0, 0.0)
	if progress >= 100.0:
		$Button.modulate = Color(0.0, 1.0, 0.0)
		$Label.modulate = Color(0.0, 1.0, 0.0)
		$ProgressBar.modulate = Color(0.0, 1.0, 0.0)
		self.set_process(false)


func _input(event):
	if $Button.pressed:
		if not self.research.in_progress and self.resource_manager.use_capital(research.cost):
			research.start_progress()
			self.set_process(true)
