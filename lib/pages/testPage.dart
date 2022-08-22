import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String url = '';
  var data;
  List _topFive = [];
  var logger = Logger();

  // Fetch data from JSON file
  Future<List> readJson(String Url) async {
    final response = await http.get(Uri.parse(Url));
    final data = json.decode(response.body);
    setState(() {
      _topFive = data as List;

      print(_topFive);
    });

    return _topFive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/main_page_bg.png"),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Search Your Books",
                  style: GoogleFonts.montserrat(fontSize: 30)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  onChanged: (value) {
                    url =
                        'http://192.168.100.14:5000/recommendation/collaborative?query=' +
                            value.toString();
                  },
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (() {
                  readJson(url);
                }),
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 178, 91, 91)),
                child: const Text('Find',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              const SizedBox(height: 10),
              _topFive.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _topFive.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              leading: const Text("Some \nImage"),
                              title: Text(
                                _topFive[index],
                              ),
                              trailing: TextButton(
                                  onPressed: () {},
                                  child: const Text("More",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 178, 91, 91)))),
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text("Your books will show up here",
                          style: TextStyle(fontSize: 20)))
            ],
          ),
        ),
      ),
    );
  }
}
