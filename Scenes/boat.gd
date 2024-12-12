extends Node2D

# Number of deck segments
@export var deck_length: int
@export var deck_scene: PackedScene

# Tasks that should be filled into the deck segments
@export var deck_tasks: Array[Globals.Task_type]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_generate_boat()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _generate_boat():
	# Generate each deck segment
	# TODO: Update to generate with more than 1 deck segment
	var deck_tasks_to_place = deck_tasks
	for i in deck_length:
		var new_deck_segment = deck_scene.instantiate()
		var tasks = deck_tasks.slice(0, 4)
		new_deck_segment.initialize(tasks)
		$DeckSlot.add_child(new_deck_segment)
