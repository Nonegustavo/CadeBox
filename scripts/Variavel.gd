extends Label

var num = 0 setget set_num, get_num

func _ready():
	pass # Replace with function body.


func set_num(arg):
	num = clamp(arg, -999, 999)
	text = str(num)


func get_num():
	return num
