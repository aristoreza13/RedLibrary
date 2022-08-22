import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/controller.dart';
import '../global.dart';

class BorrowDialog extends StatefulWidget {
  const BorrowDialog({Key? key}) : super(key: key);

  @override
  State<BorrowDialog> createState() => _BorrowDialogState();
}

class _BorrowDialogState extends State<BorrowDialog> {
  final c = Get.find<AuthController>();
  TextEditingController borrowC = TextEditingController();

  final _borrowPageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Stack(
        children: [
          SizedBox(
            height: max(300, Get.height * 0.3),
            child: PageView(
              controller: _borrowPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildBorrowNote(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: color1,
              child: MaterialButton(
                onPressed: _addBorrow,
                child: const Text('Done'),
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBorrowNote() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        Text(
          'You are about to borrow this book',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: color1,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Text('How long you would borrow the book?'),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: 30,
            child: TextField(
              controller: borrowC,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 20),
          const Text("Days")
        ]),
      ],
    );
  }

  _addBorrow() {
    if (Navigator.canPop(context)) {
      c.addBorrow(borrowC.text);

      Navigator.pop(context);
    }
  }
}
