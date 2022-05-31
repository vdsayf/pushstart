extends CanvasLayer

var cardList = []

func _takeCard(val):
	var value = val/10
	var colo = val%10
	if colo == 1:
		redList.append(value)
	elif colo == 2:
		purpleList.append(value)
	elif colo == 3:
		blueList.append(value)
	elif colo == 4:
		yellowList.append(value)
	elif colo == 5:
		greenList.append(value)
