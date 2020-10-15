extends HBoxContainer

func _ready():
	if Main.mode == "level":
		$InOut.show()
	else:
		$TecladoNumerico.show()
		$VBox.show()
