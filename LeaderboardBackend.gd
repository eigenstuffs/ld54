extends Node


# entry.699247905 - Name
# entry.1588699143 - Time
const url_submit = "https://docs.google.com/forms/u/0/d/e/1FAIpQLSfpzWDGJxGIFPtuqUbozSh8Oc7OTzlMkWEhpELsl9GHkh28Lg/formResponse"
const headers = ["Content-Type: application/x-www-form-urlencoded"]
var client = HTTPClient.new()
var http

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func http_submit(_result, _response_code, _headers, _body):
	http.queue_free()
	print("connected")

func upload_stats(name, time):
	print("Attempting upload...")
	http = HTTPRequest.new()
	http.request_completed.connect(self.http_submit)
	add_child(http)
	
	var user_data = client.query_string_from_dict({
		"entry.699247905" : name,
		"entry.1588699143" : time,
	})
	
	var err = http.request(url_submit, headers, HTTPClient.METHOD_POST, user_data)
	
	if err:
		http.queue_free()
	else:
		print("submitted")
