extends Node2D


var day = 1


func update_cure_counter(cures):
	$HUD/UI/BottomRow/CureCounter.text = str(cures)


func set_zoom(zoom):
	$Camera2D.zoom = zoom
	

func update_day():
	day += 1
	$HUD/UI/BottomRow/DayCounter.text = "Day %s" % day
