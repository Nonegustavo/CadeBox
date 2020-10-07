extends Label

var focus = false

func _ready():
	if focus:
		grab_focus()
