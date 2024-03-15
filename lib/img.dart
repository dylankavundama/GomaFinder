// import 'dart:io';
// import 'package:edusys_photo/util/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// Future<String> cropImage(XFile pickedFile) async {
//   final croppedFile = await ImageCropper().cropImage(
//     sourcePath: pickedFile.path,
//     compressFormat: ImageCompressFormat.jpg,
//     compressQuality: 100,
//     aspectRatioPresets: [
//       CropAspectRatioPreset.square,
//       CropAspectRatioPreset.ratio3x2,
//       CropAspectRatioPreset.original,
//       CropAspectRatioPreset.ratio4x3,
//       CropAspectRatioPreset.ratio16x9
//     ],
//     uiSettings: [
//       AndroidUiSettings(
//         toolbarTitle: 'Rogne',
//         toolbarColor: AppTheme.colorMains,
//         toolbarWidgetColor: Colors.white,
//         initAspectRatio: CropAspectRatioPreset.original,
//         lockAspectRatio: false,
//         showCropGrid: true,
//       ),
//       IOSUiSettings(
//         title: 'Rogne',
//       ),
//     ],
//   );
//   return croppedFile!.path;
// }

// class Utils {
//   static Future<String?> getImage({
//     bool isGallery = false,
//     context,
//     Future<String> Function(XFile file)? cropImage,
//   }) async {
//     final ImagePicker picker = ImagePicker();

//     final pickedFile = await picker.pickImage(
//         source: isGallery ? ImageSource.camera : ImageSource.gallery);
//     if (pickedFile == null) return null;
//     final file = XFile(pickedFile.path);
//     return cropImage!(file);
//     // return file.path;
//   }
// }


// import 'package:edusys_photo/app/bloc/users/users_bloc.dart';
// import 'package:edusys_photo/util/app_theme.dart';
// import 'package:edusys_photo/util/image_crop.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

// class ModifImage extends StatefulWidget {
//   const ModifImage({super.key, this.matricule});
//   final matricule;

//   @override
//   State<ModifImage> createState() => _ModifImageState();
// }

// class _ModifImageState extends State<ModifImage> {
//   XFile? image;

//   var bloc;

//   @override
//   void initState() {
//     bloc = BlocProvider.of<UsersBloc>(context);
//     super.initState();
//   }

//   Future<void> getImage({bool status = false}) async {
//     try {
//       String? img = await Utils.getImage(
//         isGallery: status,
//         cropImage: cropImage,
//       );
//       setState(() {
//         if (img != null) {
//           image = XFile(img);
//           bloc.add(UsersEventSingUp(matricule: widget.matricule, path: image));
//         }
//       });
//     } catch (e) {
//       print("Erreur lors de la récupération de l'image : $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         width: double.infinity,
//         height: size.height * .15,
//         margin: MediaQuery.of(context).viewInsets,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildButton(
//                 title: "Galerie",
//                 icon: const Icon(
//                   Icons.open_in_browser,
//                   color: AppTheme.colorMains,
//                   size: 25,
//                 ),
//                 onPresse: () {
//                   setState(() {
//                     getImage(status: false);
//                   });
//                 },
//               ),
//               _buildButton(
//                 onPresse: () {
//                   setState(() {
//                     getImage(status: true);
//                   });
//                 },
//                 title: "Prendre une photo",
//                 icon: const Icon(
//                   Icons.camera_enhance_outlined,
//                   color: AppTheme.colorMains,
//                   size: 25,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _buildButton({Icon? icon, var title, VoidCallback? onPresse}) {
//     return GestureDetector(
//       onTap: onPresse,
//       child: Container(
//         height: 40,
//         width: MediaQuery.of(context).size.width,
//         child: Row(children: [
//           icon!,
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               "${title}",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: AppTheme.colorMains,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ]),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//         ),
//       ),
//     );
//   }
// }