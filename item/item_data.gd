extends Resource

class_name ItemData

@export var name: String = ""
@export_multiline var description: String = ""
@export var type: Constants.ITEM_TYPE = Constants.ITEM_TYPE.WEAPON
@export var stackable: bool = false
@export var texture: Texture2D # AtlasTexture kan ook

func use(target):
	pass
