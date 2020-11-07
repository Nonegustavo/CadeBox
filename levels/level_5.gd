extends Node

const title = "#5 - ALÔ, VIZINHOS!"
const task = "Para cada número lido da entrada, retorne o número anterior e o número seguinte a ele. Use os novos comandos [color=black]/[/color] e [color=black]\\[/color]."
const mode = "level"
const challenge = false
const cells = 4
const max_instructions = INF
const forbidden_cmd = ["[", "]", "?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(5):
		var a = rng.randi_range(1, 98)
		test.input.append(a)
		test.output.append(a-1)
		test.output.append(a+1)
	return test
