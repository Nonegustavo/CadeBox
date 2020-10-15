extends Node

const title = "#13 - SOBREVIVÊNCIA DO MAIOR"
const task = "A cada dois numeros lidos, retorne qual é o maior."
const mode = "level"
const cells = 4
const max_instructions = INF
const forbidden_cmd = []

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(rng.randi_range(10, 25)):
		var a = rng.randi_range(-99, 99)
		var b = rng.randi_range(-99, 99)
		test.input.append(a)
		test.input.append(b)
		test.output.append(a if a > b else b)
	return test
