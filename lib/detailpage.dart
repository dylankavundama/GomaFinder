import 'package:firebase_auth_example/googlemaps.dart';
import 'package:firebase_auth_example/style.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    Key? key,
  }) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool fav = false;
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Serena Hotel",
                              style: TitreStyle
                            ),
                            // SizedBox(
                            //   height: 4,
                            // ),
                       
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("Description",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18)),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                      style: TextStyle(fontWeight: FontWeight.w300),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Localisation",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18)),
                    SizedBox(
                      height: 4,
                    ),
                    Tooltip(
                      message: 'clic',
                      preferBelow: false,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GoogleMaps(),
                              ));
                        },
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 60,
                          decoration: BoxDecoration(color: Colors.green),
                          child: Image(
                              image: AssetImage("assets/newark.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
            
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 73,
        child: BottomAppBar(
          color: Colors.white,
          elevation: 0.0,
          child: FittedBox(
            fit: BoxFit.none,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 6.0),
                  height: 46,
                  width: 186,
                  decoration: BoxDecoration(
                    color: CouleurPrincipale,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), 
                        
                      
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Text(
                    "GPS",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
