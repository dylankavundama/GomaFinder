import 'package:firebase_auth_example/style.dart';
import 'package:flutter/material.dart';

class Detail_UI extends StatelessWidget {
  const Detail_UI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CouleurPrincipale),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'U',
              style: TextStyle(color: CouleurPrincipale),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
            ),
            Text(
              'PATO',
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.location_on_outlined,
              color: Colors.black,
              size: 18,
            )
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Image.asset(
                  'assets/test.webp',
                  fit: BoxFit.cover,
                ),
                Image.network(
                  'https://media-cdn.tripadvisor.com/media/photo-s/0b/75/c3/c6/hotl-ole-caribe.jpg',
                  fit: BoxFit.cover,
                ),
                Image.network(
                  'https://media-cdn.tripadvisor.com/media/photo-s/0b/75/c3/c6/hotl-ole-caribe.jpg',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              'Serena Hotel',
              style: TitreStyle,
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              "Google met tout en œuvre pour proposer un écosystème d'annonces qui protège les annonceurs, les éditeurs et les utilisateurs contre la fraude, mais aussi contre les mauvaises expériences publicitaires. C'est pourquoi Google peut parfois limiter le nombre d'annonces que votre compte AdMob est autorisé à diffuser. Il peut s'agir d'une limite temporaire permettant d'évaluer la qualité de votre trafic ou d'une limite appliquée suite à l'identification de problèmes de",
              style: DescStyle,
              maxLines: 6,
            ),
          ),
          Divider(),
          Row(
            children: [
              Card(
                borderOnForeground: true,
                child: Icon(
                  Icons.location_on_outlined,
                  color: CouleurPrincipale,
                ),
              ),
              Text(
                'Adress : Serena Hotel',
              ),
            ],
          ),
          Row(
            children: [
              Card(
                borderOnForeground: true,
                child: Icon(
                  Icons.navigation,
                  color: CouleurPrincipale,
                ),
              ),
              Text(
                'Site : www.serena.com',
              ),
            ],
          ),
          Row(
            children: [
              Card(
                borderOnForeground: true,
                child: Icon(
                  Icons.call,
                  color: CouleurPrincipale,
                ),
              ),
              Text(
                'Appel : 0988775478',
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
