import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'package:records/read_records.dart';

class Personne extends StatefulWidget {
  const Personne({super.key});

  @override
  State<Personne> createState() => _PersonneState();
}

class _PersonneState extends State<Personne> {
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
        title: const Text("Bureau"),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          TextField(
            controller: nom,
            decoration:
                const InputDecoration(hintText: "Nom", labelText: "Nom"),
          ),
          TextField(
            controller: desc,
            decoration: const InputDecoration(
                hintText: "Desc", labelText: "detail"),
          ),
          TextField(
            controller: image1,
            decoration: const InputDecoration(
                hintText: "image1", labelText: "image1"),
          ),
          TextField(
            controller: image2,
            decoration: const InputDecoration(
                hintText: "image2", labelText: "image2"),
          ),
          TextField(
            controller: tel,
            decoration: const InputDecoration(
                hintText: "tel", labelText: "tel"),
          ),
          TextField(
            controller: site,
            decoration: const InputDecoration(
                hintText: "site", labelText: "site"),
          ),
          TextField(
            controller: log,
            decoration: const InputDecoration(
                hintText: "longitude", labelText: "longitude"),
          ),
          TextField(
            controller: lat,
            decoration: const InputDecoration(
                hintText: "latitude", labelText: "latitude"),
          ),

          ElevatedButton(
            onPressed: () {
              savadatas();
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewdata()));
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => const Viewdata()),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text("Ajouter"),
          ),
        ],
      ),
    );
  }
}
