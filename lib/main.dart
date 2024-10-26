import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'display.dart'; // Import the display.dart file

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Entry App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EntryForm(),
    );
  }
}

class EntryForm extends StatefulWidget {
  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final _textController = TextEditingController();
  XFile? _image;
  XFile? _video;
  String? _audioPath;
  final ImagePicker _picker = ImagePicker();
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _video = pickedFile;
    });
  }

  Future<void> _pickAudio() async {
    String? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    ).then((value) => value?.files.single.path);
    setState(() {
      _audioPath = result;
    });
  }

  Future<void> _submitEntry() async {
  if (_textController.text.isEmpty || (_image == null && _video == null && _audioPath == null)) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all fields and select at least one media file.")));
    return;
  }

  final uri = Uri.parse("http://<your-computer-ip>:3000/addEntry");
  var request = http.MultipartRequest("POST", uri);

  request.fields['date'] = _selectedDate.toIso8601String();
  request.fields['text'] = _textController.text;

  // Add files if they exist
  if (_image != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'image', _image!.path,
      contentType: MediaType('image', 'jpeg'), // Add appropriate MIME type
    ));
  }
  if (_video != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'video', _video!.path,
      contentType: MediaType('video', 'mp4'), // Add appropriate MIME type
    ));
  }
  if (_audioPath != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'audio', _audioPath!,
      contentType: MediaType('audio', 'mpeg'), // Add appropriate MIME type
    ));
  }

  try {
    final response = await request.send();
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Entry added!")));
      _textController.clear();
      setState(() {
        _image = null;
        _video = null;
        _audioPath = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add entry. Status: ${response.statusCode}")));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Media Entry'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EntryList()),
          );
        },
        child: Icon(Icons.list),
        tooltip: 'View Entries',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Add Your Media Entry',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              Text(
                'Select Media',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildMediaButton('Pick Image', _pickImage, _image?.name),
              _buildMediaButton('Pick Video', _pickVideo, _video?.name),
              _buildMediaButton('Pick Audio', _pickAudio, _audioPath?.split('/').last),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitEntry,
                child: Text("Submit Entry"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaButton(String label, Function onPressed, String? fileName) {
    return Column(
      children: [
        TextButton(
          onPressed: () => onPressed(),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
          child: Text(label),
        ),
        if (fileName != null) Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            "Selected: $fileName",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
