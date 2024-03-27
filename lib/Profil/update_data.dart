import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable, camel_case_types
class Update_Data extends StatefulWidget {
  String id;
  String nom;
  String matricule;
  String dateN;
  Update_Data(this.nom, this.matricule, this.dateN, this.id, {super.key});

  @override
  State<Update_Data> createState() => _Update_DataState();
}

// ignore: camel_case_types
class _Update_DataState extends State<Update_Data> {
  String mat = "";
  TextEditingController txtnom = TextEditingController();
  TextEditingController matricule = TextEditingController();
  TextEditingController dateN = TextEditingController();

  Future<void> update() async {
    try {
      var url = "http://192.168.1.190/payment_teacher/update.php";

      var res = await http.post(Uri.parse(url), body: {
        "nom": txtnom.text,
        "matricule": matricule.text,
        "dateN": dateN.text,
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
    matricule.text = widget.matricule;
    dateN.text = widget.dateN;
    txtnom.text = widget.nom;
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
              controller: txtnom,
              decoration: const InputDecoration(hintText: "", labelText: "Nom"),
            ),
            TextField(
              controller: matricule,
              decoration:
                  const InputDecoration(hintText: "", labelText: "Matricule"),
            ),
            TextField(
              onTap: () => _selectDate(context),
              controller: dateN,
              decoration: const InputDecoration(
                  hintText: "Votre dateN", labelText: "dateN"),
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
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: const Text("Confirmer"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateN.text = picked.toString().substring(0, 10);
      });
    }
  }
}
