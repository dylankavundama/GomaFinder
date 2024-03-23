import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:upato/actu/detail_actu_page.dart';
import 'package:upato/Util/style.dart';

class Event_Home_Page extends StatefulWidget {
  const Event_Home_Page({Key? key}) : super(key: key);

  @override
  State<Event_Home_Page> createState() => _Event_Home_PageState();
}

class _Event_Home_PageState extends State<Event_Home_Page> {


  bool    _isLoading = true;
  List userdata = [];

  Future<void> delrecord(String id) async {
    try {
      var url = "http://$Adress_IP/goma/goma.php";
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
    var url = "http://$Adress_IP/goma/goma.php";
    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        userdata = jsonDecode(response.body);
        print(userdata);
           _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    getrecord();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Evénement", style: DescStyle),
     
        backgroundColor: Colors.white,
      ),
      body: 
      
       _isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: CouleurPrincipale,
            ),
          )
        :
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: RefreshIndicator(
          color: CouleurPrincipale,
          onRefresh: getrecord,
          child: ListView.builder(
            itemCount: userdata.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return DetailPostPage(
                        titre: userdata[index]['nom'],
                        img: userdata[index]['image1'],
                        description: userdata[index]['detail'],
                      );
                    }),
                  );
                },

                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(userdata[index]["nom"],
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: TitreStyle),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              userdata[index]["detail"],
                              style: GoogleFonts.abel(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                              maxLines: 5,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.network(
                              "http://$Adress_IP/goma/entreprise/" +
                                  userdata[index]["image1"],
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            children: [
                              // IconButton(
                              //   color: CouleurPrincipale,
                              //   onPressed: () {},
                              //   icon: Icon(Icons.share),
                              // ),
                              TextButton(
                                  child: Text(
                                    "Réservation",
                                    style: TitreStyle,
                                  ),
                                  onPressed: () {}),
                              TextButton(
                          
                          child: 
                                      
                              Text(
                                    "Appeler",
                                    style: TitreStyle,
                                  ),
                                  onPressed: () {}),

                              TextButton.icon(
                                  icon: Icon(
                                    Icons.share_outlined,
                                    color: CouleurPrincipale,
                                  ),
                                  label: Text(
                                    "Partager",
                                    style: TitreStyle,
                                  ),
                                  onPressed: () {})
                            ],
                          ),
                        ]),
                  ),
                ),
                // child: Container(
                //   height: MediaQuery.of(context).size.height * 0.14,
                //   width: MediaQuery.of(context).size.width,
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       color: Colors.black12,
                //       style: BorderStyle.solid,
                //     ),
                //     borderRadius: BorderRadius.circular(6.0),
                //   ),
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 3),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [

                //         const Padding(padding: EdgeInsets.only(left: 11)),
                //         Padding(
                //           padding: const EdgeInsets.only(top: 11),
                //           child: SizedBox(
                //             height: MediaQuery.of(context).size.height * 0.18,
                //             width: MediaQuery.of(context).size.width * 0.60,
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   userdata[index]["nom"],
                //                   maxLines: 1,
                //                   textAlign: TextAlign.start,
                //                   style: GoogleFonts.aBeeZee(
                //                     fontSize: 16,
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.black,
                //                   ),
                //                 ),
                //                 Text(
                //                   userdata[index]["detail"],
                //                   style: GoogleFonts.abel(
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.normal,
                //                     color: Colors.black,
                //                   ),
                //                   maxLines: 5,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              );
            },
          ),
        ),
      ),
    );
  }
}
