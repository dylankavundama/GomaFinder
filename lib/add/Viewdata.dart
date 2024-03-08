import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:upato/add/Update_records.dart';
import 'package:upato/style.dart';
import 'Add_Data.dart';

class Viewdata extends StatefulWidget {
  const Viewdata({super.key});

  @override
  State<Viewdata> createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  List userdata = [];
  bool _isLoading = true;
  Future<void> delrecord(String id) async {
    try {
      var url = "https://royalrisingplus.com/upato/bureau/delete.php";
      var result = await http.post(Uri.parse(url), body: {"id": id});
      var reponse = jsonDecode(result.body);
      if (reponse["Success"] == "True") {
        print("record deleted");
        getrecord();
      } else {
        print("Erreur de suppression");
        getrecord();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getrecord() async {
    var url = "https://royalrisingplus.com/upato/bureau/read.php";
    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        _isLoading = false;
        userdata = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getrecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: CouleurPrincipale))
          : ListView.builder(
              itemCount: userdata.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(userdata[index]["image2"]),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Update_records(
                              userdata[index]["nom"],
                              userdata[index]["desc"],
                              userdata[index]["image1"],
                              userdata[index]["id"]),
                        ),
                      );
                    },
                    title: Text(userdata[index]["nom"]),
                    subtitle: Text(userdata[index]["desc"]),
                    trailing: IconButton(
                        onPressed: () {
                          delrecord(userdata[index]["id"]);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getrecord();
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => const Add_Data()),
            (Route<dynamic> route) => false,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
