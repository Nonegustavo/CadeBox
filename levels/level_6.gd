extends Node

const title = "#6 - POTENCIALIZADOR"
const task = "Para cada número lido, retorne o dobro dele."
const mode = "level"
const cells = 2
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
		var a = rng.randi_range(0, 99)
		test.input.append(a)
		test.output.append(a*2)
	return test
