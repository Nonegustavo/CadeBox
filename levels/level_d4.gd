extends Node

const title = "#D4 - AGULHA NO PALHEIRO"
const task = "Para cada lista terminada em zero, retorne qual é o menor número."
const mode = "level"
const cells = 3
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
		var pool = []
		for i in range(rng.randi_range(3, 10)):
			var a = rng.randi_range(1, 999)
			pool.append(a)
			test.input.append(a)
		test.input.append(0)
		test.output.append(pool.min())
	return test
