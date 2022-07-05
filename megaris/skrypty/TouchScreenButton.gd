extends TouchScreenButton

var radious = Vector2(26,26)
var boundary = 65 #65 do poprawy w razie błedu
var drag_state = -1 #stan dragu -1 bez inputu, inne wartości to poszczególne klikniecia

func getButtonPosition():
	return position + radious

var returnSpeed = 20
func _process(delta): #wracanie nie natychmiastowe po puszczeniu dla grafiki
	if drag_state == -1:
		var pos_diffrence = (Vector2(0,0) - radious) - position
		position += pos_diffrence * returnSpeed * delta

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_world_position = get_canvas_transform().xform_inv(event.position)
		var distance_from_center = (event_world_position - get_parent().global_position).length()
		
		if distance_from_center <= ((boundary * global_scale.x) + 135) or event.get_index() == drag_state:
			set_global_position(event_world_position - radious * global_scale)
			set_global_position(event_world_position - radious * global_scale)
			if getButtonPosition().length() > boundary:
				set_position(getButtonPosition().normalized() * boundary - radious)
			drag_state = event.get_index()
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == drag_state:
		drag_state = -1

var errorMargin = 10 #margines od którego wykrywa ruch na joysticku
func get_value():
	var buttonCenterPosition = getButtonPosition()
	if buttonCenterPosition.length() > errorMargin:
		return Vector2(calculatePercentValuesOfJoystick(buttonCenterPosition.x),calculatePercentValuesOfJoystick(buttonCenterPosition.y))
	return Vector2(0,0)

func calculatePercentValuesOfJoystick(value):
	return value / 65
