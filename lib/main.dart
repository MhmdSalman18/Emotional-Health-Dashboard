import 'package:flutter/material.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 234, 7, 255)),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "hello";
  var _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 193, 161, 158),
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(color: Color.fromARGB(214, 255, 7, 7),fontSize: 30),
              
            ),
            TextField(controller: TextEditingController(),),
            ElevatedButton(onPressed: (){
              setState(() {
                _textController=_textController.text as TextEditingController;
                
              });
            }, child: Text("click")),
            Text(_textController.text)
          ],
        ),
      ),
    );
  }
}
