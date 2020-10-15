extends Node

const title = "#D1 - DENTRO DA CAIXA"
const task = "Para cada dois números lidos, retorne todos os números entre eles."
const mode = "level"
const cells = 5
const max_instructions = INF
const forbidden_cmd = ["?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(5):
		var a = rng.randi_range(0, 9)
		var b = a + rng.randi_range(3, 9)
		test.input.append(a)
		test.input.append(b)
		for i in range(a+1, b):
			test.output.append(i)
	return test
