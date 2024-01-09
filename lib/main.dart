import 'dart:convert';

// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  String searchVale = 'india';
  List<dynamic> users = [];
  void upicall() async {
    String url = 'https://newsapi.org/v2/everything?q=' +
        searchVale +
        '&from=2023-10-07&sortBy=popularity&apiKey=be540d6c2cfa4c1db5489f1c2893aa4e';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    Map<String, dynamic> json = jsonDecode(response.body);
    users = json['articles'];
    setState(() {
      users = json['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: TextField(
          controller: myController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: (value) {},
        ),
      ),
      // appBar: AppBar(
      //   title: Text('BrieflyNow'),
      // ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final title = user['title'];
            return ListTile(
              title: Text(title),
            );
          }),

      floatingActionButton: TextButton(
        onPressed: () {
          searchVale = myController.text;
          upicall();
          print(searchVale);
        },
        child: Text('Search'),
      ),
    );
  }
}
//be540d6c2cfa4c1db5489f1c2893aa4e