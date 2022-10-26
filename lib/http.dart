import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectProject extends StatefulWidget {
  const SelectProject({Key? key}) : super(key: key);

  @override
  State<SelectProject> createState() => _SelectProjectState();
}

class _SelectProjectState extends State<SelectProject> {

  int _index = 0;

  late List<String> foran;

  String selectedForan = "";

  Future<List<String>> fetchProjects() async {
    final response = await http.get(Uri.parse('https://deep-sea.ru/rest/projectNames'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return (jsonDecode(response.body) as List<dynamic>).cast<String>();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load drawings');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProjects().then((value) => {
      setState(() {
        foran = value;
        print(foran);
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(foran.toString()),
    );
  }
}
