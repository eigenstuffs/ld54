extends Node


# entry.699247905 - Name
# entry.1588699143 - Time
const url_submit = "https://docs.google.com/forms/u/0/d/e/1FAIpQLSfpzWDGJxGIFPtuqUbozSh8Oc7OTzlMkWEhpELsl9GHkh28Lg/formResponse"
const headers = ["Content-Type: application/x-www-form-urlencoded"]
var client = HTTPClient.new()
var http

# Called when the node enters the scene tree for the first time.
func _ready():
	upload_stats("TEST", "69.42")

	

func http_submit(_result, _response_code, _headers, _body):
	print("Result: " + str(_result))
	print("Response code: " + str(_response_code))
	print("Body: " + _body.get_string_from_utf8())
	http.queue_free()
	print("connected")

func upload_stats(username, time):
	print("Attempting upload...")
	http = HTTPRequest.new()
	http.request_completed.connect(self.http_submit)
	add_child(http)
	
	var formdict : Dictionary = {}
	formdict["entry.247576926"] = username
	formdict["entry.1711361103"] = time
	
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
