import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upato/style.dart';

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
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        child: ListTile(
          subtitle: Text(
            titreLocal,
            style: GoogleFonts.abel(fontSize: 18),
            maxLines: 1,
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageLocal),
            radius: 25,
          ),
          title: Text(
            'la chaine des devirtissement footable music ',
            style: GoogleFonts.aBeeZee(fontSize: 16),
          ),
          trailing: Icon(Icons.play_circle, color: CouleurPrincipale),
        ),
      ),
    );
  }
}
