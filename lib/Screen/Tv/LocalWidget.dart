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

  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: CouleurPrincipale ,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  // child: Image.network(widget.image, width: 150),

                  child: FadeInImage.assetNetwork(
                    width: 150,
                    placeholder: 'assets/bb.png',
                    image: imageLocal,
                    fit: BoxFit.cover,
                  ),
                ),
                const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  titreLocal,
                    maxLines: 1,
                    style: GoogleFonts.abel(
                        fontSize: 16,
                        color:Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 19),
                  Text(
               "     widget.date,",
                    maxLines: 2,
                    style: theme.textTheme.bodyMedium!.copyWith(
                       color: Color.fromARGB(130, 255, 255, 255), fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6)),
                        padding: const EdgeInsets.symmetric(
                            //ici
                            horizontal: 10,
                            vertical: 6),
                        child: Text(
                          'For kid',
                          style: theme.textTheme.labelSmall!.copyWith(
                              color:CouleurPrincipale , fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Spacer(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
