extends Furniture
class_name Table

func get_chairs() -> Array[Chair]:
	var result : Array[Chair] = []
	result.append(get_chair(pos + Vector2(0,1)))
	result.append(get_chair(pos + Vector2(0,-1)))
	result.append(get_chair(pos + Vector2(1,0)))
	result.append(get_chair(pos + Vector2(-1,0)))
	return result

func get_chair(at_pos : Vector2) -> Chair:
	var furniture : Furniture = furnitures[at_pos]
	if not furniture is Chair:
		return null
	
	return null
