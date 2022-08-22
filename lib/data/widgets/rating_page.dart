import 'dart:math';

import 'package:newbookapp/controllers/controller.dart';
import 'package:newbookapp/data/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingDialog extends StatefulWidget {
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  final c = Get.find<AuthController>();

  final _ratingPageController = PageController();
  var _starPosition = 200.0;
  var _rating = 0;
  var _selectedChipIndex = -1;
  var _isMoreDetailActive = false;
  final _moreDetailFocusNode = FocusNode();
  TextEditingController reviewC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference review = firestore.collection('review');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Thanks Note
          SizedBox(
            height: max(300, Get.height * 0.3),
            child: PageView(
              controller: _ratingPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _causeOfRating(),
              ],
            ),
          ),
          // Done Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: color1,
              child: MaterialButton(
                onPressed: _addRating,
                child: const Text('Done'),
                textColor: Colors.white,
              ),
            ),
          ),
          // Skip Button
          Positioned(
            right: 0,
            child: MaterialButton(
              onPressed: _closeDialog,
              child: const Text('Close'),
            ),
          ),
          // Star Rating
          AnimatedPositioned(
            top: _starPosition,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  icon: index < _rating
                      ? const Icon(
                          Icons.star,
                          size: 32,
                        )
                      : const Icon(
                          Icons.star_border,
                          size: 32,
                        ),
                  color: color2,
                  onPressed: () {
                    _ratingPageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                    setState(() {
                      _starPosition = 35.0;
                      _rating = index + 1;
                    });
                  },
                ),
              ),
            ),
            duration: const Duration(milliseconds: 300),
          ),
          // Back Button
          if (_isMoreDetailActive)
            Positioned(
              left: 0,
              top: 0,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _isMoreDetailActive = false;
                  });
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
        ],
      ),
    );
  }

  _buildThanksNote() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Thanks for reviewing the book',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            color: color1,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const Text('Share your thoughts about the book'),
      ],
    );
  }

  _causeOfRating() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !_isMoreDetailActive,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('What is your opinion?'),
              // Cause Selection
              // Wrap(
              //   spacing: 8.0,
              //   alignment: WrapAlignment.center,
              //   children: List.generate(
              //       6,
              //       (index) => InkWell(
              //             onTap: () {
              //               setState(() {
              //                 _selectedChipIndex = index;
              //               });
              //             },
              //             child: Chip(
              //               backgroundColor: _selectedChipIndex == index
              //                   ? color1
              //                   : Colors.grey[300],
              //               label: Text(
              //                 'Text ${index + 1}',
              //                 // style: TextStyle(color: Colors.white),
              //               ),
              //             ),
              //           )),
              // ),
              const SizedBox(height: 16),
              // Tell Us More
              InkWell(
                onTap: () {
                  _moreDetailFocusNode.requestFocus();
                  setState(() {
                    _isMoreDetailActive = true;
                  });
                },
                child: const Text(
                  'Want to tell us more?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          replacement: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Tell Us More'),
              // Chip(
              //   label: Text('Text ${_selectedChipIndex + 1}'),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  focusNode: _moreDetailFocusNode,
                  controller: reviewC,
                  decoration: InputDecoration(
                    hintText: 'Write your review here...',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _closeDialog() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {}
  }

  _addRating() {
    if (Navigator.canPop(context)) {
      c.tambahRating(_rating, reviewC.text);

      Navigator.pop(context);

      // if (_rating != null) {
      //   print(_rating);
      //   print(reviewC.text);
      //   // TODO: BISA DISETOR KE FIREBASE
      //   FirebaseFirestore firestore = FirebaseFirestore.instance;
      //   Future<void> addRating(int rating, String review) async {
      //     CollectionReference review =
      //         FirebaseFirestore.instance.collection('review');
      //     final checkRating = await review.doc(review.id).get();
      //     if (checkRating.data() == null) {
      //       await review.doc(review.id).set({
      //         'rating': rating,
      //         'review': review,
      //       });
      //     } else {
      //       print("Rating Error");
      //     }
      //     // return review
      //     //     .add({
      //     //       'rating': rating,
      //     //       'review': review,
      //     //     })
      //     //     .then((value) => print("Rating Added"))
      //     //     .catchError((error) => print("Failed to add rating: $error"));
      //   }
      // } else {
      //   print("Error saving the rating");
    }
  }
}
