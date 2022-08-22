import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:newbookapp/controllers/controller.dart';
import 'package:newbookapp/data/global.dart';
import 'package:newbookapp/data/widgets/rating_page.dart';
import 'package:newbookapp/pages/details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newbookapp/pages/profile.dart';
import 'package:newbookapp/pages/testPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final c = Get.find<AuthController>();
  User? user = FirebaseAuth.instance.currentUser;

  String url = '';
  var data;
  List _topFive = [];
  final List _topFiveImage = [
    "http://images.amazon.com/images/P/0316666343.01.MZZZZZZZ.jpg",
    "http://images.amazon.com/images/P/0971880107.01.MZZZZZZZ.jpg",
    "http://images.amazon.com/images/P/0385504209.01.MZZZZZZZ.jpg",
    "http://images.amazon.com/images/P/0312195516.01.MZZZZZZZ.jpg",
    "http://images.amazon.com/images/P/0060928336.01.MZZZZZZZ.jpg",
  ];

  var logger = Logger();

  // Fetch data from JSON file
  Future<List> readJson(String Url) async {
    final response = await http.get(Uri.parse(Url));
    final data = json.decode(response.body);

    setState(() {
      _topFive = data;
      // logger.d("Error fetching data");
      print(_topFive);
    });

    return _topFive;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/main_page_bg.png"),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.1),
                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline4,
                            children: const [
                              TextSpan(text: "What are you \nreading "),
                              TextSpan(
                                text: "today?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const TestPage();
                            }));
                          },
                          // onPressed: () => Get.to(() => ProfilePage()),
                          icon: const Icon(
                            Icons.search,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfilePage();
                            }));
                          },
                          // onPressed: () => Get.to(() => ProfilePage()),
                          icon: const Icon(
                            Icons.account_box_rounded,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Body

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline5,
                            children: const [
                              TextSpan(text: "Book of The"),
                              TextSpan(
                                text: " Day",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        // Most Rated Book Card
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          height: 205,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 24,
                                      top: 24,
                                      right: Get.width * 0.3),
                                  height: 185,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 221, 212, 212)
                                            .withOpacity(.45),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Fihi Ma Fihi",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      const Text(
                                        "Jalaluddin Rumi",
                                        style:
                                            TextStyle(color: kLightBlackColor),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child: RatingDialog(),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: const Offset(3, 7),
                                                    blurRadius: 20,
                                                    color:
                                                        const Color(0xFD303030)
                                                            .withOpacity(.5),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: kIconColor,
                                                    size: 15,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    "5.0",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Expanded(
                                            child: Text(
                                              "Rumi revealed a spiritual point of view to answer the problems faced by the students and those closest to them. A spiritual education so that we live according to the will of the Creator.",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: kLightBlackColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 5,
                                top: 0,
                                child: Image.asset(
                                  "assets/images/fihi-ma-fihi.jpg",
                                  width: Get.width * 0.29,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: SizedBox(
                                  height: 40,
                                  width: Get.width * 0.3,
                                  child: GestureDetector(
                                    onTap: () => Get.to(() => DetailsPage()),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                          color: color1,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )),
                                      child: const Text(
                                        "More",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headline5,
                            children: const [
                              TextSpan(text: "Your"),
                              TextSpan(
                                text: " Books",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),

                        Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(38.5),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 10),
                                blurRadius: 33,
                                color: const Color(0xFF030303).withOpacity(.84),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(38.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Fihi Ma Fihi",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Jalaluddin Rumi",
                                                style: GoogleFonts.montserrat(
                                                    color: kLightBlackColor),
                                              ),
                                              StreamBuilder(
                                                  stream: firestore
                                                      .collection('user')
                                                      .doc(user!.email)
                                                      .snapshots(),
                                                  builder: (context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot.hasData) {
                                                      final doc = snapshot.data;
                                                      return Align(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      "Due : ",
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              kLightBlackColor)),
                                                              TextSpan(
                                                                text:
                                                                    doc['borrow']
                                                                            [0]
                                                                        ['day'],
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    " Days left",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontSize:
                                                                            10,
                                                                        color:
                                                                            kLightBlackColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return const Text(
                                                        "Data not found");
                                                  }),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          "assets/images/fihi-ma-fihi.jpg",
                                          width: 55,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          height: 550,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Most Popular Books',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.black, fontSize: 20),
                                ),
                                TextButton(
                                  onPressed: () {
                                    readJson(
                                        // 'http://192.168.43.136:5000/recommendation/popular-based'

                                        'http://192.168.100.14:5000/recommendation/popular-based');
                                  },
                                  child: Text("See All",
                                      style: GoogleFonts.montserrat(
                                          color: color1, fontSize: 16)),
                                ),
                              ],
                            ),
                            _topFive.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: _topFive.length,
                                      itemBuilder: (context, index) {
                                        String key = _topFive.elementAt(index);
                                        String image =
                                            _topFiveImage.elementAt(index);
                                        // print(_topFive['Book-Title'][index]);
                                        index = index + 1;
                                        return Card(
                                          margin: const EdgeInsets.all(10),
                                          child: ListTile(
                                            leading: SizedBox(
                                              height: 100.0,
                                              width: 50.0,
                                              child: Image.network(image),
                                            ),
                                            title: Text(
                                              "# " "$index",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 15),
                                            ),
                                            subtitle: Text(
                                              key,
                                              style: GoogleFonts.openSans(
                                                  fontSize: 15),
                                            ),
                                            trailing: const Text("More"),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Center(child: Container())
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
