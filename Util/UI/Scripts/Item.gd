extends Resource
class_name Item

@export var title : String
@export var texture : Texture2D
@export var level: int

#default reset function to be overridden in sublasses
func reset():
	pass
