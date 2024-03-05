
import 'package:flutter/material.dart';


class Detail_UI extends StatelessWidget {
  const Detail_UI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Image.network(
                'https://media-cdn.tripadvisor.com/media/photo-s/0b/75/c3/c6/hotl-ole-caribe.jpg',
                fit: BoxFit.cover,
              ),
              Image.network(
                'https://media-cdn.tripadvisor.com/media/photo-s/0b/75/c3/c6/hotl-ole-caribe.jpg',
                fit: BoxFit.cover,
              ),
            ],
          ),
        ));
  }
}
