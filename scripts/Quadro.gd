extends RichTextLabel

func _ready():
	bbcode_text = Main.level.task
	if Main.level.challenge:
		get_parent().modulate = Color("#ff8080")
