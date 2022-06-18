/*
Tutorial link: https://www.youtube.com/watch?v=YNn8dQQck2c
*/

import 'dart:ui';

import 'package:flutter/material.dart';

class AwesomeCarousel extends StatefulWidget {
  const AwesomeCarousel({Key? key}) : super(key: key);

  @override
  _AwesomeCarouselState createState() => _AwesomeCarouselState();
}

class _AwesomeCarouselState extends State<AwesomeCarousel> {
  List<String> data = [
    "https://cdn.dribbble.com/users/3281732/screenshots/8159457/media/9e7bfb83b0bd704e941baa7a44282b22.jpg?compress=1&resize=600x600",
    "https://cdn.dribbble.com/users/3281732/screenshots/7012328/media/bcd672685071ca4da27d5f3ea44ac5db.jpg?compress=1&resize=600x600",
    "https://cdn.dribbble.com/users/3281732/screenshots/6727912/samji_illustrator.jpeg?compress=1&resize=600x600",
    "https://cdn.dribbble.com/users/3281732/screenshots/10940512/media/b2a8ea95c550e5f09d0ca07682a3c0da.jpg?compress=1&resize=600x600",
    "https://cdn.dribbble.com/users/3281732/screenshots/8616916/media/a7e39b15640f8883212421d134013e38.jpg?compress=1&resize=600x600",
    "https://cdn.dribbble.com/users/3281732/screenshots/6590709/samji_illustrator.jpg?compress=1&resize=600x600",
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Container(
            key: ValueKey<String>(data[_currentPage]),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data[_currentPage]),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 15,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.55,
          child: PageView.builder(
            itemCount: data.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data[index]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}