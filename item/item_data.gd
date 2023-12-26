extends Resource


class_name ItemData

@export var name: String = ""
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var texture: AtlasTexture # individuele Texture kan ook

func use(target):
	pass
