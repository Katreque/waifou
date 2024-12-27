extends PanelContainer

@onready var ActionBtn: Button = $Button

func _ready() -> void:
	var defaultPanelTheme = get_theme_stylebox('panel')
	var hoverPanelTheme = load('res://assets/ui/themes/hover-panel-theme.tres')
	
	ActionBtn.mouse_entered.connect(func(): add_theme_stylebox_override('panel', hoverPanelTheme))
	ActionBtn.focus_entered.connect(func(): add_theme_stylebox_override('panel', hoverPanelTheme))
	ActionBtn.mouse_exited.connect(func(): add_theme_stylebox_override('panel', defaultPanelTheme))
	ActionBtn.focus_exited.connect(func(): add_theme_stylebox_override('panel', defaultPanelTheme))
	
	ActionBtn.move_to_front()
