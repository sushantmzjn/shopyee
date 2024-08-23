import 'package:flutter/material.dart';

class ImageViewPage extends StatelessWidget {
  String imgUrl;
  ImageViewPage({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          InteractiveViewer(
            child: Center(
                child: Image.network(
              imgUrl,
              width: double.infinity,
            )),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
