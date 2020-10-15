extends Node

const title = "#D3 - EMPILHANDO E DESEMPILHANDO"
const task = "Se um número lido for diferente de zero, armazene-o em uma lista. Se for zero, retorne o último elemento armazenado e apague-o da lista."
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
	var pool = []
	for _i in range(3):
		var a = rng.randi_range(1, 99) if rng.randf() > 0.5 else rng.randi_range(-99, -1)
		test.input.append(a)
		pool.append(a)
	for _i in range(17):
		if rng.randf() > 0.5 or pool.size() == 0:
			var a = rng.randi_range(1, 99) if rng.randf() > 0.5 else rng.randi_range(-99, -1)
			test.input.append(a)
			pool.append(a)
		else:
			test.input.append(0)
			test.output.append(pool.pop_back())
	while pool.size() > 0:
		test.input.append(0)
		test.output.append(pool.pop_back())
	return test
