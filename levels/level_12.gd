extends Node

const title = "#12 - DE TRÁS PARA FRENTE"
const task = "Para cada lista terminada em zero, retorne todos os elementos em ordem inversa."
const mode = "level"
const cells = 20
const max_instructions = INF
const forbidden_cmd = []

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(rng.randi_range(3, 5)):
		var out = []
		for i in range(rng.randi_range(5, 10)):
			var a = rng.randi_range(1, 99)
			test.input.append(a)
			out.insert(0, a)
		test.input.append(0)
		for v in out:
			test.output.append(v)
	return test
