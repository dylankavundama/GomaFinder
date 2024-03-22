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
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
//add
            Container(
              color: Colors.black,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    // child: Image.network(
                    //   widget.image,
                    //   fit: BoxFit.cover,

                    // ),

                    child: FadeInImage.assetNetwork(
                        height: screenHeight * 0.3,
                        width: screenWidth,
                        placeholder: 'assets/bb.png',
                        image: imageLocal
                        //fit: BoxFit.cover,
                        ),
                  ),
                  Positioned(
                    top: screenHeight * 0.2,
                    width: screenWidth / 2,
                    child: Container(
                      width: screenWidth,
                      color: Color.fromARGB(221, 191, 187, 187),
                      child: Center(
                        child: Text(
                          titreLocal,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
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
