extends Node

const title = "#D8 - REUNIÃO DE FAMÍLIA"
const task = "Leia os números e retorne apenas os números primos.\n\nUm número primo é divisível apenas por ele mesmo e por 1."
const mode = "level"
const challenge = true
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
	for _i in range(10):
		var a = rng.randi_range(2, 19)
		test.input.append(a)
		var found = false
		for i in range(a, 1, -1):
			if a % i == 0:
				if found:
					found = false
					break
				found = true
		if found:
			test.output.append(a)
	if test.output.size() == 0:
		test.input.append(2)
		test.output.append(2)
	return test
