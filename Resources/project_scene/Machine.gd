extends MarginContainer


var box = preload("res://Variavel.tscn")
onready var register = $HBox/Registrador
var pointer = 0
var tape = []

signal output(value)

func _ready():
	for _i in range(32):
		var b = box.instance()
		$HBox/Tape/List.add_child(b)
		tape.append(b)
	tape[0].get_node("Pointer").show()

func reset():
	tape[pointer].get_node("Pointer").hide()
	pointer = 0
	tape[pointer].get_node("Pointer").show()
	tape[pointer].grab_focus()
	register.num = 0
	for v in tape:
		v.num = 0

func move_left():
	if pointer == 0:
		register.text = "0"
	else:
		tape[pointer].get_node("Pointer").hide()
		pointer -= 1
		tape[pointer].get_node("Pointer").show()
		tape[pointer].grab_focus()


func move_right():
	if pointer == tape.size()-1:
		register.text = "0"
	else:
		tape[pointer].get_node("Pointer").hide()
		pointer += 1
		tape[pointer].get_node("Pointer").show()
		tape[pointer].grab_focus()


func up():
	register.num += 1

func down():
	register.num -= 1

func add():
	register.num += tape[pointer].num

func sub():
	register.num -= tape[pointer].num

func read(arg):
	register.num = arg

func write():
	return register.num

func copy():
	register.num = tape[pointer].num

func store():
	tape[pointer].num = register.num

func if_zero():
	register.num = 1 if register.num == 0 else 0

func if_negative():
	register.num = 1 if register.num < 0 else 0

func swap():
	var aux = register.num
	register.num = tape[pointer].num
	tape[pointer].num = aux

func get_register():
	return register.num
