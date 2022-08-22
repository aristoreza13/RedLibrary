import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newbookapp/controllers/controller.dart';
import 'package:newbookapp/data/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newbookapp/data/widgets/borrow_page.dart';

import '../data/widgets/rating_page.dart';

class DetailsPage extends StatelessWidget {
  final c = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
      //   height: 45,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(30.0),
      //     color: color1,
      //   ),
      //   child: TextButton(
      //     onPressed: () {},
      //     style: ButtonStyle(
      //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //         RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(30.0),
      //         ),
      //       ),
      //     ),
      //     child: Text(
      //       "Add to Library",
      //       style: GoogleFonts.montserrat(
      //         fontSize: 14,
      //         fontWeight: FontWeight.w600,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: Get.height * 0.4,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bg.png"),
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.1),
                        // Book Info
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Fihi Ma",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  Text(
                                    "Fihi",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 20),
                                            const Text(
                                              "Jalaluddin Rumi",
                                              maxLines: 5,
                                              style: TextStyle(
                                                  color: kLightBlackColor,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(height: 20),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return const Dialog(
                                                        child: BorrowDialog(),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                height: Get.height * 0.05,
                                                width: Get.width * 0.3,
                                                decoration: BoxDecoration(
                                                  color: color1,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Borrow",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.favorite_border),
                                          ),
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
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: const Offset(3, 7),
                                                    blurRadius: 20,
                                                    color: const Color(0xFD303030)
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/images/fihi-ma-fihi.jpg",
                              height: 200,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Tab
            Container(
              height: 450,
              margin: const EdgeInsets.only(top: 23, bottom: 36),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor:
                            const Color.fromARGB(255, 122, 114, 114),
                        labelStyle: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: GoogleFonts.tinos(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        indicatorColor: color2,
                        tabs: const [
                          Tab(
                            text: "Description",
                          ),
                          Tab(
                            text: "Reviews",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 400, //height of TabBarView
                      child: TabBarView(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 6.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                    child: const SingleChildScrollView(
                                      child: Text(
                                          "Tanpa pikiran, bentuk-bentuk tak dapat bergerak dan mati. Sehingga, barang siapa yang hanya melihat pada bentuk, berarti dia juga mati; dia tak mampu menangkap makna. Dia adalah seorang anak kecil dan tidak matang, meski dalam bentuk dia adalah seorang syekh yang berumur seratus tahun \n\n***\n\nSiang dan malam di dunia ini engkau mencari ketenteraman dan kedamaian, walaupun sesungguhnya tidak mungkin engkau mencapai mereka di dunia. Namun demikian, pencarianmu tentu tidak sia-sia. Ketenteraman dan kedamaian tentu bisa hadir, meski hanya sekejap. Kedamaian apa pun yang engkau temukan di dunia ini tidaklah abadi. Kehadirannya bagai kilat yang menyambar, la hadir disertai situasi penuh guntur, hujan, salju, dan godaan.",
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                    ),
                                  ))),
                          StreamBuilder(
                            stream: c.firestore.collection('user').snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot docs =
                                          snapshot.data.docs[index];
                                      return Card(
                                        child: ListTile(
                                          title: Text(docs['email']),
                                          subtitle: docs['review'][0]['review']
                                                  .toString()
                                                  .isEmpty
                                              ? const Text('No Review')
                                              : Text(
                                                  docs['review'][0]['review']
                                                      .toString(),
                                                ),
                                          trailing: Column(children: [
                                            const Icon(Icons.star, color: kIconColor),
                                            Text(docs['review'][0]['rating']
                                                .toString())
                                          ]),
                                        ),
                                      );
                                    });
                              }
                              return const Text("No Data");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline6,
                      children: const [
                        TextSpan(
                          text: "You might also ",
                        ),
                        TextSpan(
                          text: "like...",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      const SizedBox(
                        height: 160,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 24, top: 24, right: 150),
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: const Color(0xFFFFF8F9),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                      color: kBlackColor),
                                  children: const [
                                    TextSpan(
                                      text: "Jejak Langkah \n",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    TextSpan(
                                      text: "Pramoedya Ananta Toer \n",
                                      style: TextStyle(color: kLightBlackColor),
                                    ),
                                  ],
                                ),
                              ),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(3, 7),
                                            blurRadius: 20,
                                            color: const Color(0xFD303030)
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
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: Get.height * 0.07,
                                        width: Get.width * 0.5,
                                        decoration: BoxDecoration(
                                          color: color1,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "See More",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/images/jejak-langkah.png",
                          height: 160,
                          width: 150,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
