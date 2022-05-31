extends Position2D

var cardList = []

var sum = 0

func _setLabel():
	$Label.set_text(str(sum))

func _takeCard(card):
	sum += card.valyu
	cardList.append(card)
	_setLabel()

func _emptyColor():
	if !cardList.empty():
		cardList = []
		sum = 0
		_setLabel()
