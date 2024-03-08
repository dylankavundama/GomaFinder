import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:upato/add/Viewdata.dart';

import '../style.dart';

class Add_Data extends StatefulWidget {
  const Add_Data({super.key});

  @override
  State<Add_Data> createState() => _Add_DataState();
}

class _Add_DataState extends State<Add_Data> {
  TextEditingController nom = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController image1 = TextEditingController();
  TextEditingController image2 = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController site = TextEditingController();
  TextEditingController log = TextEditingController();
  TextEditingController lat = TextEditingController();

  Future<void> savadatas() async {
    var url = "https://royalrisingplus.com/upato/bureau/create.php";
    Uri ulr = Uri.parse(url);

    await http.post(ulr, body: {
      "nom": nom.text,
      "desc": desc.text,
      "image1": image1.text,
      "image2": image2.text,
      "tel": tel.text,
      "site": site.text,
      "log": log.text,
      "lat": lat.text,
    });
  }

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
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Ajouter une entreprise",
                  style: TitreStyle,
                ),
              ),
            ),
            TextField(
              controller: nom,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  hintText: "Nom de l'entreprise",
                  labelText: "Nom"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            TextField(
              controller: desc,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  hintText: "description & l'adresse de l'entreprise",
                  labelText: "Description"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            TextField(
              controller: image1,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  hintText: "url de l'image 1",
                  labelText: "Image1"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            TextField(
              controller: image2,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  hintText: "url de l'image 2",
                  labelText: "Image2"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            TextField(
              controller: tel,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  hintText: "numéro de téléphone",
                  labelText: "Tel"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            TextField(
              controller: site,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  hintText: "url du site internet/page web",
                  labelText: "Site internet"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            TextField(
              controller: log,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  hintText: "longitude",
                  labelText: "longitude"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            TextField(
              controller: lat,
              decoration: InputDecoration(
                  focusColor: CouleurPrincipale,
                  fillColor: CouleurPrincipale,
                  hoverColor: CouleurPrincipale,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  hintText: "latitude",
                  labelText: "latitude"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: CouleurPrincipale, // Change background color here
                onPrimary: Colors.white, // Change text color here
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // Change shape here
                ),
              ),
              onPressed: () {
                savadatas();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Viewdata()));
              },
              child: Text(
                "Ajouter",
                style: TitreStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
