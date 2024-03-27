import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:upato/Profil/UserPost.dart';
import 'package:upato/Util/style.dart';

// ignore: must_be_immutable, camel_case_types
class Update_Data extends StatefulWidget {
  String id;
  String nom;
  String detail;
  String site;
  String tel;

  Update_Data(this.tel, this.nom, this.detail, this.site, this.id, {super.key});

  @override
  State<Update_Data> createState() => _Update_DataState();
}

// ignore: camel_case_types
class _Update_DataState extends State<Update_Data> {
  String mat = "";
  TextEditingController nom = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController site = TextEditingController();
  TextEditingController tel = TextEditingController();

  Future<void> update() async {
    try {
      var url = "http://$Adress_IP/goma/entreprise/update.php";

      var res = await http.post(Uri.parse(url), body: {
        "nom": nom.text,
        "detail": detail.text,
        "site": site.text,
        "id": widget.id
      });
      debugPrint(widget.id);
      var repoe = jsonDecode(res.body);

      if (repoe["Success"] == "True") {
        debugPrint("record updated");
      } else {
        debugPrint("Error on update");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    detail.text = widget.detail;
    site.text = widget.site;
    nom.text = widget.nom;
    mat = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modifier"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: nom,
              decoration: const InputDecoration(hintText: "", labelText: "Nom"),
            ),
            TextField(
              controller: detail,
              decoration:
                  const InputDecoration(hintText: "", labelText: "detail"),
            ),
            TextField(
              controller: tel,
              decoration:
                  const InputDecoration(hintText: "", labelText: "detail"),
            ),
            TextField(
              controller: site,
              decoration:
                  const InputDecoration(hintText: "", labelText: "detail"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: MaterialButton(
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: const Color.fromARGB(199, 3, 204, 244),
                onPressed: () {
                  update();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserPost()));
                },
                child: const Text("Confirmer"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
