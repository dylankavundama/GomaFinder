import 'package:upato/Detail_UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/style.dart';
import 'package:flutter/material.dart';

class Widget_UI extends StatelessWidget {
  const Widget_UI({
    required this.image,
    required this.titre,
    required this.desc,
    super.key,
  });

  final String image;
  final String titre;
  final String desc;
  @override
  Widget build(BuildContext context) {
    final ww = MediaQuery.of(context).size.width;
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => DetailPage()),
      //   );
      // },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.white10, // Specify your desired border color here.
            width: 2.0,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              // Prend toute la taille de l'écran
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.23,
              // Enfant : Image
              child: Image.network(
                image, // URL de l'image
                fit: BoxFit
                    .cover, // Ajustement de l'image pour couvrir tout le container
              ),
            ),
            ButtonBar(
              children: <Widget>[
                SizedBox(
                  height: 30,
                  child: Padding(
                    padding: EdgeInsets.only(right: 300),
                    child: Text(
                      titre,
                      style: TitreStyle,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: CouleurPrincipale,
                      size: 18,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 110),
                      child: Text(
                        desc,
                        style: SousTStyle,
                        maxLines: 1,
                      ),
                    ),
                    // Text(
                    //   'Call',
                    // )
                  ],
                ),
                // ElevatedButton(
                //   child: Text('Button 2'),
                //   onPressed: () {},
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
