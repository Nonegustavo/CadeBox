extends Node

const title = "#16 - CONTANDO O REBANHO"
const task = "Para cada número lido, retorne quantas ocorrências dele existem na fita."
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
	for _i in range(10):
		test.cells.append(rng.randi_range(1, 9))
	for _i in range(5):
		var a = rng.randi_range(1, 9)
		test.input.append(a)
		test.output.append(test.cells.count(a))
	return test
