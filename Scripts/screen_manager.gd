extends Node

@export var level_scene: PackedScene
@export var cutscene_scene: PackedScene

#var hud
var cutscene: Cutscene
var level: Level
var game_ended = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#hud = $HUD
	if cutscene_scene and not cutscene:
		cutscene = cutscene_scene.instantiate()
		add_child(cutscene)
		cutscene.start_pressed.connect(_on_start_level)
		_set_level(cutscene.level_scene)
	#show_main_menu()

#func _resume_play(mouse_mode: int):
	#hud.hide_menus()
	#if level.has_method("resume_play"):
		#level.resume_play(mouse_mode)
	
#func _pause_play():
	#level.pause_play()
	
#func show_main_menu():
	#level.bg_music.stream_paused = true
	#_pause_play()
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	#hud.show_main_menu()

#func _on_quit_pressed():
	#get_tree().quit()

#func _on_play_pressed():
	#if game_ended:
		#_on_restart_pressed()
	#else:
		#_resume_play(Input.MOUSE_MODE_CAPTURED)

#func _input(event):
	#if event.is_action_pressed("menu"):
		#show_main_menu()

func _restart_level():
	game_ended = false
	if level:
		level.free()
	
	var new_level = level_scene.instantiate()
	add_child(new_level)
	new_level.completed.connect(_on_level_completed)
	
	#for sig in new_level.get_signal_list():
		#if sig["name"] == "tutorial_completed":
			#new_level.tutorial_completed.connect(_on_tutorial_won)
			#break
	
	level = new_level
	Globals.set_level(level)
	
	#_resume_play(Input.MOUSE_MODE_CAPTURED)

#func _on_restart_pressed():
	#_restart_level()
	#_resume_play(Input.MOUSE_MODE_CAPTURED)

func _on_level_completed():
	game_ended = true
	#_pause_play()
	#hud.show_win_screen()
	
#func _on_tutorial_completed():
	#game_ended = true
	#_pause_play()
	#hud.show_tutorial_win_screen()

#func _on_level_selected(new_level_scene: PackedScene):
	#_set_level(new_level_scene)

func _set_level(new_level_scene: PackedScene):
	level_scene = new_level_scene
	#Globals.cur_level = level_scene

func _on_start_level():
	_restart_level()
	cutscene.queue_free()
