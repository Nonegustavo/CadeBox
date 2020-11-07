extends Node

var dict = {
	"<":"Left",
	">":"Right",
	"+":"Add",
	"-":"Sub",
	"/":"Up",
	"\\":"Down",
	":":"Copy",
	"@":"Swap",
	"~":"Read",
	"^":"Print",
	"[":"Loop",
	"]":"Loop",
	"#":"Again",
	"!":"Ifzero",
	"?":"Ifnegative"
}

func _ready():
	pass # Replace with function body.

func play_sound(sound:String):
	if not Main.data.sound:
		return
		
	if sound == ".":
		$Write.play()
	elif has_node(sound):
		get_node(sound).play()
	elif dict.has(sound):
		get_node(dict[sound]).play()
