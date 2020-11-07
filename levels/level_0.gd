extends Node

const title = "#0 - DESCOBERTA"
const task = "Faça um programa que pegue 3 números da ENTRADA e coloque-os na SAÍDA.\n\nDigite o código na aba TECLADO e depois teste na aba TESTAR."
const mode = "level"
const challenge = false
const cells = 4
const max_instructions = INF
const forbidden_cmd = ["#","<",">",".",":","@","+","-","/","\\", "[", "]", "?", "!"]

var rng = RandomNumberGenerator.new()

func generate_test():
	var test = {
		input = [],
		output = [],
		cells = []
	}
	for _i in range(3):
		var a = rng.randi_range(1, 20)
		test.input.append(a)
		test.output.append(a)
	return test
