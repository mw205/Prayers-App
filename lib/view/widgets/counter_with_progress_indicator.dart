import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/constants.dart';

class CounterWithProgressIndicator extends StatelessWidget {
  CounterWithProgressIndicator(
      {super.key,
      required this.progress,
      required this.onTap,
      required this.count});
  final double progress;
  final void Function()? onTap;
  final count;
  @override
  Widget build(BuildContext context) {
    double side = MediaQuery.of(context).size.height;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Center(
          child: SizedBox(
            width: side * 0.22,
            height: side * 0.22,
            child: CircularProgressIndicator(
            
              strokeWidth: 5,
              value: progress,
              backgroundColor: const Color.fromARGB(0, 158, 158, 158),
              valueColor: const AlwaysStoppedAnimation<Color>(primColor),
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: side * 0.21,
              height: side * 0.21,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 36.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
