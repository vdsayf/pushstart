extends Node2D

export (PackedScene) var cardSim
var revealedCard
var setDist = Vector2(0, 35) 
enum gamePhase {bankOrDeck, piling, takeOrDeck, offTurn, handmedown}
enum cardType {push, number, reverse}
enum color {red, yellow, blue, green, purple}
var currentPhase = gamePhase.bankOrDeck
var reversedBool = false
var pushing = false
var cardNum = 0

var deck = _generateDeck()

func _generateDeck():
	randomize()
	var newDeck = []
	#num is value, e is color, z for 3 times
	for num in range(1,7): 
		for e in color:
			for z in range(3):
				var newcard = load("res://cardSim.tscn").instance()
				add_child(newcard)
				newcard._setNumb(cardType.number, num, e)
				newDeck.append(newcard)
	#if 0, bomb, if 8 reverse
	for i in range(15):
		var newpush = load("res://cardSim.tscn").instance()
		newpush._setType(cardType.push)
		var newrvrse = load("res://cardSim.tscn").instance()
		newrvrse._setType(cardType.reverse)
		add_child(newpush)
		add_child(newrvrse)
		newDeck.append(newpush)
		newDeck.append(newrvrse)
	newDeck.shuffle()
	return newDeck

func _offTurn():
	currentPhase = gamePhase.offTurn

func _ifpushed():
	var a = revealedCard
	return !($PileButton._checkPass(a) || $PileButton2._checkPass(a) || $PileButton3._checkPass(a))

#ACTION
func _on_deckButton_pressed():
	if currentPhase == gamePhase.bankOrDeck || currentPhase == gamePhase.takeOrDeck:
		_offTurn()
		revealedCard = deck[0]
		revealedCard.position = $deckButton.rect_position
		move_child(revealedCard, cardNum)
		cardNum += 1
		revealedCard.show()
		deck.pop_front()
		if revealedCard.tipe == cardType.reverse:
			revealedCard._moveTo($revPile.position)
			revealedCard = null
			reversedBool = !reversedBool
			currentPhase = gamePhase.takeOrDeck
		elif _ifpushed():
			pushing = true
			_bomb()
			_trashCard(revealedCard)
			revealedCard = null
			#CHANGE
			currentPhase = gamePhase.takeOrDeck
		else:
			currentPhase = gamePhase.piling

func _endTurn():
	pass

func _swabble(cardo):
	var col = cardo.colo
	var destPil
	if col == "red":
		destPil = $points/redPts
	elif col == "yellow":
		destPil = $points/yellowPts
	elif col == "blue":
		destPil = $points/bluePts
	elif col == "green":
		destPil = $points/greenPts
	else:
		destPil = $points/purplePts
	destPil._takeCard(cardo)
	cardo._moveTo($points.rect_position + destPil.position)
		
func _takePile(pil):
	for p in pil.pileList:
		if p.tipe == cardType.push:
			pushing = true
			_trashCard(p)
		else:
			_swabble(p)
	pil._emptyOut()
	if pushing:
		_bomb()
	#CHANGE
	currentPhase = gamePhase.takeOrDeck

#ACTION
func aPilePressed(butt):
	if currentPhase == gamePhase.piling && butt._checkPass(revealedCard):
		_offTurn()
		var targetPos = butt.rect_position + butt.shifter*setDist
		revealedCard._moveTo(targetPos)
		butt._addToPile(revealedCard)
		revealedCard = null
		currentPhase = gamePhase.takeOrDeck
	elif currentPhase == gamePhase.takeOrDeck && !butt.pileList.empty():
		_offTurn()
		_takePile(butt)

func _trashCard(c):
	c._moveTo($trash.position)
	$trash._addToPile(c)

func _bomb():
	randomize()
	var bombed
	var col = randi()%5+1
	if col == 1:
		bombed = $points/redPts
	elif col == 2:
		bombed = $points/yellowPts
	elif col == 3:
		bombed = $points/bluePts
	elif col == 4:
		bombed = $points/greenPts
	else:
		bombed = $points/purplePts
	$animateOver.playAnim()
	for c in bombed.cardList:
		_trashCard(c)
	bombed._emptyColor()
	pushing = false

func _on_PileButton_pressed():
	aPilePressed($PileButton)

func _on_PileButton2_pressed():
	aPilePressed($PileButton2)

func _on_PileButton3_pressed():
	aPilePressed($PileButton3)
