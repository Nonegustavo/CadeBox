extends Node

const title = "#19 - DANDO UMA ARRUMADA"
const task = "Para cada lista terminada em zero, retorne a lista ordenada em ordem crescente.\n\nBoa sorte!"
const mode = "level"
const challenge = false
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
	for _i in range(3):
		var pool = []
		for i in range(rng.randi_range(5, 10)):
			var a = rng.randi_range(1, 99)
			pool.append(a)
			test.input.append(a)
		test.input.append(0)
		pool.sort()
		for v in pool:
			test.output.append(v)
	return test
