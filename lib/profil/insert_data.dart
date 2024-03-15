import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:core';

import 'package:upato/profil/list_insert.dart';
import 'package:upato/style.dart';

class Inset_Data extends StatefulWidget {
  const Inset_Data({super.key});
  @override
  State<Inset_Data> createState() => _Inset_DataState();
}

class _Inset_DataState extends State<Inset_Data> {
  TextEditingController nom = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController site = TextEditingController();
  TextEditingController log = TextEditingController();
  TextEditingController latt = TextEditingController();
  TextEditingController image = TextEditingController();

  @override
  void initState() {
    getrecord();
    super.initState();
  }

  late String idenseu;
  var selectens;

  bool _isNumeric(String value) {
    try {
      double result = double.parse(value);
      if (result > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  showToast({required String msg}) {
    return Fluttertoast.showToast(msg: msg);
  }

  List dataens = [];
  Future<void> getrecord() async {
    var url = "http://192.168.1.76/payment_teacher/read-enseignant.php";
    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        dataens = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> savadatas(Salaire Salaire) async {
    if (nom.text.isEmpty ||
        detail.text.isEmpty ||
        tel.text.isEmpty ||
        site.text.isEmpty ||
        log.text.isEmpty ||
        latt.text.isEmpty ||
        image.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vous avez un champs vide'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    try {
      var url = "http://192.168.1.76/payment_teacher/salaire/add-salaire.php";
      Uri ulr = Uri.parse(url);

      var reponse = await http.post(ulr, body: {
        "nom": nom.text,
        "cat": idenseu,
        "site": site.text,
        "det": detail.text,
        "tel": tel.text,
        "log": log.text = long,
        "lat": latt.text = lat,
        "image": image.text,
      });
      if (reponse.statusCode == 200) {
        showToast(msg: "Succes!");
      } else {
        showToast(msg: "Probleme d'insertion!");
      }
    } catch (e) {
      showToast(msg: 'Erreur survenue');
    }
  }

  bool _isLoading = false;

  //location

  late String lat;
  late String long;

  String locationMessage = '';
  Future<Position> _getCurrentLocation() async {
    bool serviceEnamblev = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnamblev) {
      return Future.error('are disabel ');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('erro permissio');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('erro permission denied fprever');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position positon) {
      lat = positon.latitude.toString();
      long = positon.longitude.toString();

      setState(() {
        locationMessage = "latitude:$lat longitude:$long";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Image.asset("assets/en.png"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Center(
                    child: Text(
                  "Inscription d'une entreprise",
                  style: TitreStyle,
                )),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Stack(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(LineIcons.list),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                      readOnly: true,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: DropdownButton(
                        hint: const Text(
                            "Sélectionner la catégorie de votre entreprise"),
                        items: dataens.map((list) {
                          return DropdownMenuItem(
                            value: list["id"],
                            child: Text(list["nom"]),
                          );
                        }).toList(),
                        value: selectens,
                        onChanged: (value) {
                          selectens = value;
                          idenseu = selectens;
                          print("Valeur: " + selectens);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),

              TextField(
                keyboardType: TextInputType.text,
                controller: nom,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.home_filled),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    hintText: "Nom de l'entreprise",
                    labelText: "Nom de l'entreprise"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),

              TextField(
                keyboardType: TextInputType.text,
                controller: detail,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    hintText: "Description (adress)",
                    labelText: "Description"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),

              TextField(
                keyboardType: TextInputType.number,
                controller: tel,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.call),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    hintText: "Numero Téléphone",
                    labelText: "Téléphone"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),

              TextField(
                keyboardType: TextInputType.text,
                controller: site,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.web),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    hintText: "Site Web",
                    labelText: "Site Internet"),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10),
              ),

              TextField(
                keyboardType: TextInputType.text,
                controller: image,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.web),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    hintText: "Image",
                    labelText: "Image"),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  primary: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  _getCurrentLocation().then(
                    (value) {
                      lat = '${value.latitude}';
                      long = '${value.longitude}';

                      setState(() {
                        locationMessage =
                            "Postion GPS de l'entreprise:\nlatitude :$lat\nlongitude:$long";
                      });
                    },
                  );

                  _liveLocation();
                },
                child: Text(
                  "Récupérer le position de l'entreprise",
                  style: TitreStyleWhite,
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: Text(locationMessage),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              // textField(
              //     textHint: "detail",
              //     controller: detail,
              //     icon: LineIcons.archive,
              //     suffixIcon: LineIcons.dollarSign,
              //     isNumber: false),
              // const SizedBox(
              //   height: 15,
              // ),

              MaterialButton(
                minWidth: double.maxFinite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: CouleurPrincipale,
                onPressed: () {
                  if (idenseu.isEmpty) {
                    showToast(msg: "Veiller selectionner une categorie");
                  } else if (nom.text.isEmpty) {
                    showToast(msg: "y'a une case vide");
                    setState(() {
                      _isLoading = true;
                    });
                    savadatas(Salaire(
                      nom: idenseu.trim(),
                      detail: detail.text.trim(),
                      site: site.text.trim(),
                      image: image.text.trim(),
                      lat: lat,
                      log: long,
                    )).then((value) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => List_Data()));
                    }).whenComplete(() {
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  }
                },
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Enregistrer",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
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
        site.text = picked.toString().substring(0, 10);
      });
    }
  }
}

class Salaire {
  int? code;
  String? nom;
  String? detail;
  String? site;

  String? lat;
  String? log;
  String? image;

  Salaire(
      {this.code,
      this.nom,
      this.detail,
      this.site,
      this.lat,
      this.log,
      this.image});

  factory Salaire.fromJson(Map<String, dynamic> json) =>
      _$SalaireFromJson(json);
  Map<String, dynamic> toJson() => _$SalaireToJson(this);
}

Salaire _$SalaireFromJson(Map<String, dynamic> json) {
  return Salaire(
      code: json['id'] as int,
      nom: json['nom'] as String,
      site: json['site'] as String,
      lat: json['lat'] as String,
      log: json['log'] as String,
      detail: json['detail'] as String,
      image: json['image'] as String);
}

Map<String, dynamic> _$SalaireToJson(Salaire instance) => <String, dynamic>{
      'nom': instance.nom,
      'detail': instance.detail,
      'site': instance.site,
      'lat': instance.lat,
      'log': instance.log,
      'image': instance.image
    };
