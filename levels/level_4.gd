extends Node

const title = "#4 - FUSÃO!"
const task = "Para cada dois números da entrada, retorne a soma e a subtração do primeiro número pelo segundo."
const mode = "level"
const cells = 4
const max_instructions = INF
const forbidden_cmd = ["/","\\", "[", "]", "?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(5):
		var a = rng.randi_range(0, 20)
		var b = rng.randi_range(0, 20)
		test.input.append(a)
		test.input.append(b)
		test.output.append(a+b)
		test.output.append(a-b)
	return test