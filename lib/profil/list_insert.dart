import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
// import 'package:payment_teacher/salaire/AjouterSalaire.dart';
// import 'package:payment_teacher/salaire/UpdateSalaire.dart';

import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:upato/profil/insert_data.dart';

// ignore: camel_case_types
class List_Data extends StatefulWidget {
  const List_Data({super.key});
  @override
  State<List_Data> createState() => _List_DataState();
}

// ignore: camel_case_types
class _List_DataState extends State<List_Data> {
  //rapport

  List userdata = [];
  Future<void> delrecord(String id) async {
    try {
      var url = "http://192.168.1.76/goma/goma.php";
      var result = await http.post(Uri.parse(url), body: {"id": id});
      var reponse = jsonDecode(result.body);
      if (reponse["Success"] == "True") {
        debugPrint("record deleted");
        getrecord();
      } else {
        debugPrint("Erreur de suppression");
        getrecord();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getrecord() async {
    var url = "http://192.168.1.76/goma/goma.php";
    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        userdata = jsonDecode(response.body);
        print(userdata);
      });
    } catch (e) {
      print(e);
    }
  }
// List<String> items = List.generate(10, (index) => "Item ${index + 1}");

  @override
  void initState() {
    // TODO: implement initState
    getrecord();
    // getrecordssss();
    print(userdatas);
    //print(getrecord);
    super.initState();
  }

  List userdatas = [];

  Future<List<dynamic>> getrecordssss() async {
    var url = "http://192.168.1.76/goma/goma.php";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parse the JSON response
        userdatas = jsonDecode(response.body);
        return userdatas; // Return the list
      } else {
        // Handle non-200 status code
        print("Error: ${response.statusCode}");
        return []; // Return an empty list on error
      }
    } catch (e) {
      print("Error de sssss $e");
      return []; // Return an empty list on error
    }
  }

  @override
  Widget build(BuildContext context) {
    final ss = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salaires"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(199, 3, 204, 244),
      ),
      body: ListView.builder(
        itemCount: userdata.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: GestureDetector(
              child: Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                  elevation: 1,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey)),
                              child: const Icon(LineIcons.userCircle, size: 35),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        userdata[index]["nom"],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    userdata[index]["tel"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w200),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(LineIcons.discourse,
                                              color: Colors.blue, size: 15),
                                          SizedBox(width: 5),
                                          Text(
                                            "nom : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(userdata[index]["categorie_id"]),
                                      Text(userdata[index]["site"]),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: Inset_Data(),
                );
              }).then((value) {});
        },
        backgroundColor: Color.fromARGB(199, 3, 204, 244),
        child: const Icon(Icons.add),
      ),
    );
  }
}
