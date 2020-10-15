extends Node

const title = "#D2 - POSITIVIDADE ABSOLUTA"
const task = "Leia todos os números e retorne-os. Mas retire o sinal dos números negativos."
const mode = "level"
const cells = 1
const max_instructions = INF
const forbidden_cmd = []

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(20):
		var a = rng.randi_range(-99, 99)
		test.input.append(a)
		test.output.append(abs(a))
	return test
