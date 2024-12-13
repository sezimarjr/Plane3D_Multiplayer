extends Node
var lobby_id:int = 0
var lobby_max_members :int = 10




# Called when the node enters the scene tree for the first time.
func _ready():
	Steam.lobby_match_list.connect(_on_lobby_match_list)
	
	if OS.has_feature("dedicated_server"):
		print("Starting dedicated server...")
		MultiplayerManager.become_host()
		

	

func _on_host_button_pressed() -> void:
	print("Become host pressed")
	%HUD.hide()
	MultiplayerManager.become_host()


func _on_join_game_pressed() -> void:
	print("Join as player 2")
	%HUD.hide()
	MultiplayerManager.join_as_player_2()


func list_steam_lobbies():
	print("Lista de lobies da steam")
	SteamNetworkingManager.list_lobbies()
	
	
func join_lobby(lobby_id = 0):
	print("Joining lobby %s" % lobby_id)
	SteamNetworkingManager.join_as_client(lobby_id)
	%SteamHUD.hide()
	#%PingServer.show()
	
	

	

func _on_lobby_match_list(lobbies: Array):
	print("On lobby match list")
	
	for lobby_child in $"../SteamHUD/Panel/Lobbies/VBoxContainer".get_children():
		lobby_child.queue_free()
		
	for lobby in lobbies:
		var lobby_name: String = Steam.getLobbyData(lobby, "name")
		
		if lobby_name != "":
			var lobby_mode: String = Steam.getLobbyData(lobby, "mode")
			
			var lobby_button: Button = Button.new()
			lobby_button.set_text(lobby_name + " | " + lobby_mode)
			lobby_button.set_size(Vector2(300, 30))
			lobby_button.add_theme_font_size_override("font_size", 18)
			
			lobby_button.set_name("lobby_%s" % lobby)
			lobby_button.alignment = HORIZONTAL_ALIGNMENT_LEFT
			lobby_button.connect("pressed", Callable(self, "join_lobby").bind(lobby))
		
			$"../SteamHUD/Panel/Lobbies/VBoxContainer".add_child(lobby_button)


func _on_host_p_2p_game_pressed() -> void:
	SteamNetworkingManager.become_host()
	%SteamHUD.hide()
	#%PingServer.show()
	
	
	
