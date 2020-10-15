extends RichTextLabel

func _ready():
	text = Main.level.title + "\n\n" + Main.level.task
