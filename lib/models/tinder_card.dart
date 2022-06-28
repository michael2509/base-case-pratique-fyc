import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class TinderCard extends StatelessWidget {
  final image;
  final name;
  TinderCard({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 300,
        child: Center(
            child: Swipable(
                onSwipeRight: (finalPosition) {
                  print('right');
                },
                onSwipeLeft: (finalPosition) {
                  print('left');
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber,
                        image: DecorationImage(
                          image:NetworkImage(image.toString()),
                          fit: BoxFit.cover,)),
                    height: 500,
                    width: 300,
                    child: Center(
                      child: Text(name.toString()),
                    )))));
  }
}
