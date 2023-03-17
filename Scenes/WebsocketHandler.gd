extends Node

signal auto_win

var client = WebSocketClient.new()

var phone_number = null
var code = null

func _ready():
	client.connect("connection_closed", self, "_closed")
	client.connect("connection_error", self, "_closed")
	client.connect("connection_established", self, "_connected")
	client.connect("data_received", self, "_on_data")

	var err = client.connect_to_url("wss://robotdreams.deepgram.com:443/game")
	if err != OK:
		print("Unable to connect")
		set_process(false)

func _closed(was_clean = false):
	print("Closed, clean: ", was_clean)
	set_process(false)

func _connected(proto = ""):
	print("Connected with protocol: ", proto)
	$Timer.start()

func _on_data():
	var message = client.get_peer(1).get_packet().get_string_from_utf8()
	
	if phone_number == null:
		phone_number = message
		# TODO: change this to a signal emission
		print(phone_number)
	elif code == null:
		code = message
		# TODO: change this to a signal emission
		print(code)
	elif message == "connected":
		client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
		client.get_peer(1).put_packet("Hooray, you win. You have finally woken up.".to_utf8())
		emit_signal("auto_win")
	else:
		var message_json = JSON.parse(message)
		if message_json.error == OK:
			if typeof(message_json.result) == TYPE_DICTIONARY:
				if message_json.result.has("is_final"):
					var transcript = message_json.result["channel"]["alternatives"][0]["transcript"]
					if transcript != "":
						# TODO: change this to a signal emission
						print(transcript)

func _process(_delta):
	client.poll()

func _on_Timer_timeout():
	# there seems to be a 60 second server timeout (imposed by nginx?) which requires song sort of ping
	# empirically, empty text did not work, but this works
	client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_BINARY)
	client.get_peer(1).put_packet("ping".to_utf8())
