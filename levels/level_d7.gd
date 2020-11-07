extends Node

const title = "#D7 - PODE SOLETRAR?"
const task = "Para cada número lido, retorne cada um de seus dígitos. Exemplo: se for lido 456, retorne 4, 5 e 6, nesta ordem."
const mode = "level"
const challenge = true
const cells = 5
const max_instructions = INF
const forbidden_cmd = []

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(5):
		var a = rng.randi_range(1, 999)
		test.input.append(a)
		for v in str(a):
			test.output.append(int(v))
	return test
