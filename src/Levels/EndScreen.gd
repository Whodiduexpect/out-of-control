extends Control

func _ready():
	$Score.text = str(Global.alive_cells)
	
func _on_MenuButton_pressed():
	get_tree().change_scene("res://src/TitleScreen.tscn")
