import 'package:flutter/material.dart';

enum SkeltonType { prayersList, none }

class Skelton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final SkeltonType? skeltonType;
  const Skelton({
    super.key,
    required this.color,
    required this.height,
    required this.width,
    this.skeltonType,
  });

  Skelton.type({
    required this.skeltonType,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    double rwidth = MediaQuery.of(context).size.width;
    double rheight = MediaQuery.of(context).size.height;
    if (skeltonType == SkeltonType.prayersList) {
      return ListView.separated(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Skelton(
                width: rwidth * 0.8,
                height: rheight * 0.075,
                color: Colors.black,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 5,
            );
          },
          itemCount: 6);
    } else {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color!.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage("assets/images/6348833.jpg"),
            fit: BoxFit.cover,
            opacity: 0.05,
          ),
        ),
      );
    }
  }
}
