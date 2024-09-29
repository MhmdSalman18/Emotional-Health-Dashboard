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
      home: HomeScreen1(),
    );
  }
}

class HomeScreen1 extends StatefulWidget {
  HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
  final name1 = TextEditingController();
  String head1="hedding";
  
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
              head1,
              style: const TextStyle(color: Color.fromARGB(214, 255, 7, 7),fontSize: 30),
              
            ),
            TextField(controller: name1,),
            ElevatedButton(onPressed: (){
                setState(() {
                  head1=name1.text;
                });
                print(name1.text);
            }, child: Text("click")),
            Text(head1),
            
          ],
        ),
      ),
    );
  }
}
