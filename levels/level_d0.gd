extends Node

const title = "#D0 - MÁXIMA POTÊNCIA"
const task = "Para cada número, retorne ele vezes 50."
const mode = "level"
const cells = 1
const max_instructions = INF
const forbidden_cmd = ["[", "]", "?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(20):
		var a = rng.randi_range(-19, 19)
		test.input.append(a)
		test.output.append(a*50)
	return test
