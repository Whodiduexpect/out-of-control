extends Control

var day = 5

func update_day():
	pass
	
func update_cure_counter(_cures):
	pass
	
func _on_PlayButton_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()


func screenshake():
	pass

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://src/Levels/Game.tscn")
