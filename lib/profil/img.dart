// Future<void> _pickImage(ImageSource source) async {
//   try {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       final croppedImagePath = await cropImage(XFile(pickedFile.path));
//       if (croppedImagePath != null) {
//         setState(() {
//           _image = File(croppedImagePath);
//         });
//       }
//     }
//   } catch (e) {
//     print('Erreur lors de la sélection de l\'image : $e');
//   }
// }

// Future<String?> cropImage(XFile pickedFile) async {
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
//         toolbarColor: Colors.red,
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
//   return croppedFile?.path;
// }
