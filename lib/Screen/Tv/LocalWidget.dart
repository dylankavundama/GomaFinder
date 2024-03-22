import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocalWdget extends StatelessWidget {
  const LocalWdget({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.imageLocal,
    required this.titreLocal,
  }) : super(key: key);
  final double screenHeight;
  final double screenWidth;
  final String imageLocal;
  final String titreLocal;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      titreLocal,
                      style: GoogleFonts.abel(fontSize: 19,color:Colors.white)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Image.network(
            imageLocal,
            height: screenH * 0.3,
            width: screenW,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
