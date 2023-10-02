extends Node

signal stop_timer

var can_move : bool = false

@onready var data_resource = preload("res://Data.tres")

# entry.699247905 - Name
# entry.1588699143 - Time
const url_submit = "https://docs.google.com/forms/u/0/d/e/1FAIpQLSfpzWDGJxGIFPtuqUbozSh8Oc7OTzlMkWEhpELsl9GHkh28Lg/formResponse"
const url_get = "https://opensheet.elk.sh/17-PK8DnVYqZJ16bS1SGHe-EvttL0fVuobM4VZCDypHY/CleanData"
const headers = ["Content-Type: application/x-www-form-urlencoded"]
var client = HTTPClient.new()
#var http

# Called when the node enters the scene tree for the first time.
func _ready():
#	upload_stats("TEST", "6", "1", "42")
	download_stats()

	

func http_submit(_result, _response_code, _headers, _body, http):
	print("Result: " + str(_result))
	print("Response code: " + str(_response_code))
	http.queue_free()
	print("Submission confirmed")
	

func http_get(_result, _response_code, _headers, _body, http):
	http.queue_free()
	if !_result:
		var data = JSON.parse_string(_body.get_string_from_utf8())
		print("Decoding complete")
		print(data)
		data_resource.data = data
	


func download_stats():
	print("Attempting download...")
	var http = HTTPRequest.new()
	http.request_completed.connect(self.http_get.bind(http))
	add_child(http)
	
	var get_headers = ["Content-Type: application/x-www-form-urlencoded"]
	
	var err = http.request(url_get, get_headers, HTTPClient.METHOD_GET)
#	err = client.request(HTTPClient.METHOD_POST, url_submit, post_headers, user_data)
	if err:
		http.queue_free()
		print("errored")
	else:
		print("received")

func upload_stats(username, score, level, time = 999):
	print("Attempting upload...")
	var http = HTTPRequest.new()
	http.request_completed.connect(self.http_submit.bind(http))
	add_child(http)
	
	var formdict : Dictionary = {}
	formdict["entry.247576926"] = username
	formdict["entry.1711361103"] = score
	formdict["entry.1236303721"] = level
	formdict["entry.1925959218"] = time
	
	var user_data = client.query_string_from_dict(formdict)
	
#	var user_data = {
#		"entry.699247905" : name,
#		"entry.1588699143" : time,
#	}
	
	var post_headers = ["Content-Type: application/x-www-form-urlencoded", "Content-Length: " + str(user_data.length())]
	
	var err = http.request(url_submit, post_headers, HTTPClient.METHOD_POST, user_data)
#	err = client.request(HTTPClient.METHOD_POST, url_submit, post_headers, user_data)
	if err:
		http.queue_free()
		print("errored")
	else:
		print("submitted")
