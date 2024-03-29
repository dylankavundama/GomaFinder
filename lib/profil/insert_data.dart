import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:core';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:upato/NavBarPage.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Afficher le message pop-up après le rendu initial de la page
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            iconColor: CouleurPrincipale,
            title: const Text("Instructions pour ajouter des données"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                    "1. Ouvrez la page d'enregistrement d'une entreprise dans votre application."),
                Text(
                    "2. Remplissez tous les champs nécessaires avec les informations de l'entreprise que vous souhaitez enregistrer."),
                Text(
                    "3. Sélectionnez la catégorie de votre entreprise dans le menu déroulant."),
                Text(
                    "4. Cliquez sur le bouton \"Récupérer ma position\" pour obtenir votre position actuelle (C’est a dire les données GPS de  l'entreprise)."),
                Text(
                    "5. Sélectionnez deux images de l'entreprise en cliquant sur le bouton \"la photo1\" ou \"la photo2\"(De bonne qualité)."),
                Text(
                    "6. Assurez-vous que tous les champs sont remplis correctement avant de continuer."),
                Text(
                    "7. Cliquez sur le bouton \"Enregistrer\" pour soumettre les données."),
                Text("8. Attendez la confirmation de l'enregistrement."),
                Text(
                    "9. Une fois l'enregistrement réussi, vous serez redirigé vers la page principale de l'application."),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    });
    getrecord();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late String idenseu;
  var selectens;

  showToast({required String msg}) {
    return Fluttertoast.showToast(msg: msg);
  }

  List dataens = [];
  Future<void> getrecord() async {
    var url = "http://$Adress_IP/goma/read-enseignant.php";
    try {
      var response = await http.get(Uri.parse(url));
      setState(() {
        dataens = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> savadatas(Entreprise entreprise, String email) async {
    if (nom.text.isEmpty ||
        detail.text.isEmpty ||
        tel.text.isEmpty ||
        site.text.isEmpty ||
        log.text.isNotEmpty ||
        latt.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vous avez un champ vide'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    try {
      var url = "http://$Adress_IP/goma/entreprise/add-Entreprise.php";
      Uri ulr = Uri.parse(url);
      var request = http.MultipartRequest('POST', ulr);
      request.fields['nom'] = nom.text;
      request.fields['cat'] = idenseu;
      request.fields['site'] = site.text;
      request.fields['det'] = detail.text;
      request.fields['tel'] = tel.text;
      request.fields['log'] = log.text = long;
      request.fields['lat'] = latt.text = lat;
      request.fields['auteur'] = email; // Insert email here
      request.files.add(http.MultipartFile.fromBytes(
          'image1', File(_image!.path).readAsBytesSync(),
          filename: _image!.path));

      request.files.add(http.MultipartFile.fromBytes(
          'image2', File(_image2!.path).readAsBytesSync(),
          filename: _image2!.path));
      var res = await request.send();
      var response = await http.Response.fromStream(res);

      if (response.statusCode == 200) {
        showToast(msg: "Succès !");
      } else {
        showToast(msg: "Problème d'insertion !");
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

//insert picture
  File? _image;
  File? _image2;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection de l\'image : $e');
    }
  }

  Future<void> _pickImage2(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image2 = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection de l\'image : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sreenh = MediaQuery.of(context).size.height;
    User? user = FirebaseAuth.instance.currentUser;
    final sreenw = MediaQuery.of(context).size.width;
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Colors.green,
    //     statusBarBrightness: Brightness.light,
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CouleurPrincipale,
        title: Text(
          ' ${user?.displayName ?? "Non défini"}',
          style: TextStyle(fontSize: 15),
        ),
        // actions: [
        //   CircleAvatar(
        //     backgroundImage: user?.photoURL != null
        //         ? NetworkImage(user!.photoURL!) as ImageProvider<Object>?
        //         : AssetImage('assets/default_avatar.png'),
        //     radius: 22,
        //   ),
        // ]
      ),
      body: SingleChildScrollView(
        child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.only(top: 0),
                  child: Center(
                    child: Text(
                      "Enregistrement d'une entreprise",
                      style: TitreStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Stack(
                    children: [
                      const TextField(
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
                  padding: EdgeInsets.only(top: 5),
                ),
                Container(
                  width: sreenw,
                  height: 44,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //   foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
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
                                "Localisation(MAP): latitude:$lat longitude:$long";
                          });
                        },
                      );

                      _liveLocation();
                    },
                    child: Text(
                      "Récupérer ma position",
                      style: TitreStyleWhite,
                    ),
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                  child: Text(locationMessage),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "sélectionnée :",
                      style: TitreStyle,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Définir la couleur du bouton
                        // Autres propriétés de style du bouton peuvent être définies ici
                      ),
                      child: Text(
                        "la photo1",
                        style: TitreStyleWhite,
                      ),
                      onPressed: () => _pickImage(ImageSource.gallery),
                    ),
                    SizedBox(width: 4),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Définir la couleur du bouton
                        // Autres propriétés de style du bouton peuvent être définies ici
                      ),
                      child: Text(
                        "la photo2",
                        style: TitreStyleWhite,
                      ),
                      onPressed: () => _pickImage2(ImageSource.gallery),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: sreenh * 0.2,
                      width: sreenw * 0.45,
                      child: Center(
                        child: _image == null
                            ? Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        Colors.black26, // Couleur de la bordure
                                    width: 1.0, // Épaisseur de la bordure
                                  ),
                                ),
                                child: Center(
                                  child: Text('Aucune image sélectionnée'),
                                ),
                              )
                            : Image.file(_image!),
                      ),
                    ),
                    SizedBox(width: 3),
                    Container(
                      height: sreenh * 0.2,
                      width: sreenw * 0.45,
                      child: Center(
                        child: _image2 == null
                            ? Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        Colors.black26, // Couleur de la bordure
                                    width: 1.0, // Épaisseur de la bordure
                                  ),
                                ),
                                child: Center(
                                  child: Text('Aucune image sélectionnée'),
                                ),
                              )
                            : Image.file(_image2!),
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  minWidth: double.maxFinite,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: CouleurPrincipale,
                  onPressed: () {
                    if (idenseu.isEmpty) {
                      showToast(msg: "y'a une case vide");
                    } else if (site.text.isEmpty) {
                      showToast(msg: "Y'a une case vide");
                    } else if (detail.text.isEmpty &&
                        idenseu.isEmpty &&
                        site.text.isEmpty) {
                      showToast(msg: "Y'a une case vide");
                    } else {
                      setState(() {
                        _isLoading = true;
                      });
                      savadatas(
                        Entreprise(
                          nom: idenseu.trim(),
                          detail: detail.text.trim(),
                          site: site.text.trim(),
                          lat: lat,
                          log: long,
                        ),
                        FirebaseAuth.instance.currentUser?.displayName ?? '',
                      ).then((value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const NavBarPage()));
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
              ],
            ),
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

class Entreprise {
  int? code;
  String? nom;
  String? detail;
  String? site;

  String? lat;
  String? log;

  Entreprise({this.code, this.nom, this.detail, this.site, this.lat, this.log});

  factory Entreprise.fromJson(Map<String, dynamic> json) =>
      _$EntrepriseFromJson(json);
  Map<String, dynamic> toJson() => _$EntrepriseToJson(this);
}

Entreprise _$EntrepriseFromJson(Map<String, dynamic> json) {
  return Entreprise(
      code: json['id'] as int,
      nom: json['nom'] as String,
      site: json['site'] as String,
      lat: json['lat'] as String,
      log: json['log'] as String,
      detail: json['detail'] as String);
}

Map<String, dynamic> _$EntrepriseToJson(Entreprise instance) =>
    <String, dynamic>{
      'nom': instance.nom,
      'detail': instance.detail,
      'site': instance.site,
      'lat': instance.lat,
      'log': instance.log
    };
