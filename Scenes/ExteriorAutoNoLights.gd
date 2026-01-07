extends Node2D

var lightArea
var lightCollider
var lightColliderShape = ConvexPolygonShape2D.new()
@onready var tilemap = get_parent()
var windows
#var source:TileSetAtlasSource = tile_set.get_source(0) as TileSetAtlasSource
#var rect = source.get_tile_texture_region(Vector2(1,0))
#var image:Image = source.get_texture().get_image()
#var tile_image:Image = image.get_region(rect)
func _ready() -> void:
	windows = tilemap.get_used_cells(0)
	#for i in tile_image.get_height():
	#	for i2 in tile_image.get_width():
	#		if tile_image.get_pixel(i2,i) == Color.TRANSPARENT:
	#			tile_image.set_pixel(i2,i,Color.WHITE)
	#		else:
	#			tile_image.set_pixel(i2,i,Color.TRANSPARENT)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for vec:Vector2 in windows:
		lightArea = load("res://Scenes/NoLightArea.tscn").instantiate()
		lightCollider = CollisionShape2D.new()
		lightColliderShape.set_point_cloud(PackedVector2Array([Vector2(0,0),Vector2(16,0),Vector2(16,100),Vector2(0,100)]))
		lightCollider.set_shape(lightColliderShape)
		lightArea.add_child(lightCollider)
		lightArea.position = tilemap.map_to_local(vec) + Vector2(-8,-8)
		tilemap.add_child(lightArea)
