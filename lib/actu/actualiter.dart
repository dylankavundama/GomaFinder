import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:upato/actu/detail_actu_page.dart';
import 'package:upato/profil/insert_data.dart';
import 'package:upato/style.dart';

class Actu_Home extends StatefulWidget {
  const Actu_Home({super.key});
  @override
  State<Actu_Home> createState() => _Actu_HomeState();
}

// ignore: camel_case_types
class _Actu_HomeState extends State<Actu_Home> {
  //rapport

  List userdata = [];
  Future<void> delrecord(String id) async {
    try {
      var url = "http://192.168.0.13/goma/goma.php";
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
    var url = "http://192.168.0.13/goma/goma.php";
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
    getrecordssss();
    print(userdatas);
    //print(getrecord);
    super.initState();
  }

  List userdatas = [];

  Future<List<dynamic>> getrecordssss() async {
    var url = "http://192.168.0.13/goma/goma.php";
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
    final screenW = MediaQuery.of(context).size.width;

    final screenh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          title: Text("Entreprises"),
          centerTitle: true,
          backgroundColor: CouleurPrincipale),
      body: ListView.builder(
        itemCount: userdata.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return DetailPostPage(
                    //id: userdata[index]['id'],
                    titre: userdata[index]['nom'],
                    img: userdata[index]['image1'],
                    description: userdata[index]['detail'],
                  );
                }),
              );
            },
            child: Container(
              height: screenh * 0.14,
              // height: screenH * 0.1,
              width: screenW,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black12, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(6.0)),
              child: Padding(
                padding: EdgeInsets.only(left: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),

                      // child: Image.asset(
                      //   'assets/entre.png',

                      // ),

                      child: Image.network(
                        "http://192.168.0.13/goma/entreprise/" +
                            userdata[index]["image1"],

                        width: screenW * 0.30,
                        height: screenh * 0.12,
                        fit: BoxFit.cover,
                        // errorBuilder: (context, error, stackTrace) {
                        //   return const erreurICON();
                        // },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 11)),
                    Padding(
                      padding: const EdgeInsets.only(top: 11),
                      child: SizedBox(
                        height: screenh * 0.18,
                        width: screenW * 0.60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userdata[index]["nom"],
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              userdata[index]["detail"],
                              style: GoogleFonts.abel(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
