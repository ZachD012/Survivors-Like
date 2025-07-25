extends Weapon
class_name SingleShot

func shoot(source, target, scene_tree):
	if target == null:
		return
	var projectile = projectile_node.instantiate()
	
#	Set properties of projectile with resource data
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.direction = (target.position - source.position).normalized()
	projectile.pierce = pierce
	scene_tree.current_scene.add_child(projectile)

#override activate function and call shoot
func activate(source, target, scene_tree):
	shoot(source, target, scene_tree)
