import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Actualite_Page extends StatefulWidget {
  const Actualite_Page({super.key});

  @override
  State<Actualite_Page> createState() => _Actualite_PageState();
}

class _Actualite_PageState extends State<Actualite_Page> {
  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;

    final screenh = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(4),
          child: GestureDetector(
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: ((context) {
            //         return Detail(
            //           image: post.image!,
            //           titre: post.titre!,
            //           desc: post.description!,
            //         );
            //       }),
            //     ),
            //   );
            // },
            child: Container(
              height: screenh * 0.15,
              // height: screenH * 0.1,
              width: screenW,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black26, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(6.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Image.asset(
                    //   "assets/entre.png",
                    //   width: screenW * 0.47,

                    //   height: screenh * 0.30,
                    //   fit: BoxFit.cover,
                    //   // errorBuilder: (context, error, stackTrace) {
                    //   //   return Image.asset('asset/team/tp.jpg');
                    //   // },
                    // ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/entre.png',
                        width: screenW * 0.30,
                        height: screenh * 0.10,
                        fit: BoxFit.cover,
                        // errorBuilder: (context, error, stackTrace) {
                        //   return const erreurICON();
                        // },
                      ),
                    ),

                    const Padding(padding: EdgeInsets.only(left: 30)),
                    SizedBox(
                      height: screenh * 0.15,
                      width: screenW * 0.35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kinshasa: renforcement de capacité des femmes et",
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.aBeeZee(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            "La fondation Chris Ngal en collaboration avec la synergie des jeunes africains pour la consolidation de la paix a organisé du 11 au 12 mars une formation sur les droits des femmes et des filles.",
                            style: GoogleFonts.abel(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
