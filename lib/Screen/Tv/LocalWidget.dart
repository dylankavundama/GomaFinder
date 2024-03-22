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
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Image.network(
        height:screenHeight * 0.2,
       width :screenWidth,
        imageLocal)
    
    );
  }
}
