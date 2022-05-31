extends Button

export (PackedScene) var Main
enum cardType {push, number, reverse}
var pileList = []
var shifter = 1


func _checkPass(card):
	for p in pileList:
		if card.tipe == cardType.push && card.tipe == p.tipe:
			return false
		else:
			if card.colo == p.colo || card.valyu == p.valyu:
				return false
	return true

func _addToPile(card):
	shifter += 1
	pileList.append(card)

func _emptyOut():
	pileList = []
	shifter = 1
