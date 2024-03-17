import 'package:upato/style.dart';
import 'package:flutter/material.dart';

class Widget_UI extends StatelessWidget {
  const Widget_UI({
    required this.image,
    required this.titre,
    required this.desc,
    this.maxLength = 44,
    super.key,
  });

  final String image;
  final String titre;
  final String desc;
  final int maxLength;
  @override
  Widget build(BuildContext context) {
    final ww = MediaQuery.of(context).size.width;
    String displayedText =
        desc.length <= maxLength ? desc : desc.substring(0, maxLength) + '...';
    return Card(
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
              "http://192.168.0.13/goma/entreprise/" + image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Text(
                    'Erreur de chargement de l\'image',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              },
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
                  Text(
                    displayedText,
                    style: SousTStyle,
                    maxLines: 3,
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
    );
  }
}
