extends Node

var code:Array = ["", "", ""]
var mode:String = "level" # sandbox | level
var normal_speed:float = 0.25
var fast_speed:float = 0.05
var actualCode:int = 0
var level
var save_path = "user://save_game.dat"
var actual_level:int = -1
var data

func _ready():
	var f = File.new()
	if not f.file_exists(save_path):
		data = new_data()
		save_data()
	else:
		load_data()

func new_data():
	var d:Dictionary = {
		help = false,
		sound = true,
		levels = [
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
			{success=false, commands=INF, executed=INF},
		]
	}
	return d

func new_code():
	var c = ["", "", ""]
	return c

func save_data():
	var f = File.new()
	f.open(save_path, File.WRITE)
	f.store_var(data)
	f.close()

func save_code(number = actual_level, code_data = code):
	var f = File.new()
	f.open("user://level_%d.dat" % number, File.WRITE)
	f.store_var(code_data)
	f.close()

func load_data():
	var f = File.new()
	f.open(save_path, File.READ)
	data = f.get_var()

func load_code(number):
	var f = File.new()
	if f.file_exists("user://level_%d.dat" % number):
		f.open("user://level_%d.dat" % number, File.READ)
		code = f.get_var()
	else:
		code = new_code()

func reset_data():
	data = new_data()
	save_data()
	for i in range(30):
		save_code(i, new_code())

func internal_test(code:String, limit:int):
	var tests = []
	var total_commands = 0
	for _i in range(250):
		var test = level.generate_test()
		make_test(code, test, limit*10)
		tests.append(test)
		total_commands += test.executed
		if test.error:
			return [false, test]
	return [true, total_commands/250]

func make_test(code:String, test:Dictionary, limit:int):
	test.executed = 0
	test.error = 0
	var register:int = 0
	var tape:Array = []
	var tape_pointer:int = 0
	var code_pointer:int = 0
	var input_pointer:int = 0
	var output_pointer:int = 0
	var stack:Array = []
	
	for i in range(level.cells):
		tape.append(test.cells[i] if i < test.cells.size() else 0)
	while code_pointer < code.length():
		match code[code_pointer]:
			">":
				if tape_pointer < tape.size()-1:
					tape_pointer += 1
				else:
					register = 0
			"<":
				if tape_pointer > 0:
					tape_pointer -= 1
				else:
					register = 0
			".":
				tape[tape_pointer] = register
			":":
				register = tape[tape_pointer]
			"+":
				register = clamp(register + tape[tape_pointer], -999, 999)
			"-":
				register = clamp(register - tape[tape_pointer], -999, 999)
			"/":
				register = clamp(register + 1, -999, 999)
			"\\":
				register = clamp(register - 1, -999, 999)
			"~":
				if input_pointer < test.input.size():
					register = test.input[input_pointer]
					input_pointer += 1
				else:
					code_pointer = code.length()
			"^":
				if output_pointer < test.output.size():
					if register != test.output[output_pointer]:
						code_pointer = code.length()
						test.error = true
					output_pointer += 1
				else:
					code_pointer = code.length()
					test.error = true
			"!":
				register = 1 if register == 0 else 0
			"?":
				register = 1 if register < 0 else 0
			"[":
				stack.append(code_pointer)
				if register == 0:
					var init_pointer:int = code_pointer
					while true:
						code_pointer += 1
						if code[code_pointer] == "[":
							stack.append(code_pointer)
						elif code[code_pointer] == "]":
							if stack.back() == init_pointer:
								stack.pop_back()
								break
							else:
								stack.pop_back()
						pass
			"]":
				if register == 0:
					stack.pop_back()
				else:
					code_pointer = stack.back()
			"@":
				var aux = register
				register = tape[tape_pointer]
				tape[tape_pointer] = aux
			"#":
				code_pointer = -1
				stack.clear()
		code_pointer += 1
		test.executed += 1
		if test.executed > limit:
			code_pointer = code.length()
			test.error = true
	test.error = test.error or output_pointer < test.output.size()
