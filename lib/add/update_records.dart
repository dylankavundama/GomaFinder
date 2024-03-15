// // ignore_for_file: camel_case_types

// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:upato/add/Viewdata.dart';

// // ignore: must_be_immutable
// class Update_records extends StatefulWidget {
//   String id;
//   String name;
//   String pass;
//   String role;
//   Update_records(this.name, this.pass, this.role, this.id, {super.key});

//   @override
//   State<Update_records> createState() => _Update_recordsState();
// }

// class _Update_recordsState extends State<Update_records> {
//   String mat = "";
//   TextEditingController txtnom = TextEditingController();
//   TextEditingController pass = TextEditingController();
//   TextEditingController role = TextEditingController();

//   Future<void> update() async {
//     try {
//       var url = "https://royalrisingplus.com/upato/bureau/update.php";

//       //print("onclick");
//       var res = await http.post(Uri.parse(url), body: {
//         "nom": txtnom.text,
//         "desc": pass.text,
//         "image1": role.text,
//         "id": widget.id
//       });
//       debugPrint(widget.id);
//       var repoe = jsonDecode(res.body);

//       if (repoe["Success"] == "True") {
//         debugPrint("record updated");
//       } else {
//         debugPrint("Error on update");
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void initState() {
//     pass.text = widget.pass;
//     role.text = widget.role;
//     txtnom.text = widget.name;
//     mat = widget.id;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Update data"),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           TextField(
//             controller: txtnom,
//             decoration:
//                 const InputDecoration(hintText: "Votre Nom", labelText: "Nom"),
//           ),
//           TextField(
//             controller: pass,
//             decoration: const InputDecoration(
//                 hintText: "Votre Pass", labelText: "Password"),
//           ),
//           TextField(
//             controller: role,
//             decoration: const InputDecoration(
//                 hintText: "Votre Role", labelText: "Role"),
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 update();
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   CupertinoPageRoute(builder: (context) => const Viewdata()),
//                   (Route<dynamic> route) => false,
//                 );
//               },
//               child: const Text("Confirmer"))
//         ],
//       ),
//     );
//   }
// }
