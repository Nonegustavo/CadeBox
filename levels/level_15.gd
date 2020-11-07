extends Node

const title = "#15 - VAMOS DIVIDIR!"
const task = "Para cada dois números, divida o primeiro pelo segundo e retorne o resultado.\n\nPor conveniência, temos apenas divisões exatas, sem restos."
const mode = "level"
const challenge = false
const cells = 6
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
		var res = rng.randi_range(0, 10)
		var a = rng.randi_range(1, 10)
		test.input.append(a*res)
		test.input.append(a)
		test.output.append(res)
	return test
