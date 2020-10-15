extends Node

var code:Array = ["", "", ""]
var mode:String = "level" # sandbox | level
var normal_speed:float = 0.25
var fast_speed:float = 0.05
var actualCode:int = 0
var level:Node = preload("res://levels/level_8.gd").new()
var actual_level:int = -1
var data:Dictionary = {
	help = false,
	levels = [
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
		{success=false, commands=0, executed=0},
	]
}

func internal_test(code:String):
	var tests = []
	var total_commands = 0
	for _i in range(250):
		var test = level.generate_test()
		make_test(code, test)
		tests.append(test)
		total_commands += test.executed
		if test.error:
			return [false, test]
	return [true, total_commands/250]

func make_test(code:String, test:Dictionary):
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
	test.error = output_pointer < test.output.size()
