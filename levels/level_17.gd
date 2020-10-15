extends Node

const title = "#17 - SEM REPETIR"
const task = "Retorne todos os números lidos, com exceção dos números que já foram retornados antes."
const mode = "level"
const cells = 30
const max_instructions = INF
const forbidden_cmd = []

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	var pool = []
	for _i in range(20):
		var a = rng.randi_range(1, 9)
		test.input.append(a)
		if not (a in pool):
			pool.append(a)
			test.output.append(a)
	return test
