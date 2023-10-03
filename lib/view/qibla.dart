import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:prayers/constants.dart';
import 'package:prayers/controller/qibla_controller.dart';

class Qibla extends StatelessWidget {
  Qibla({super.key});
  final QiblaController qiblaController = Get.put<QiblaController>(
    QiblaController(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    double side = MediaQuery.of(context).size.height;
    return StreamBuilder(
      stream: qiblaController.qiblaDirection.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: primColor,
            ),
          );
        }
        try {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${snapshot.data!.direction.toInt()}°",
                  style: TextStyle(color: Colors.black, fontSize: 30.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  child: AnimatedBuilder(
                    animation: qiblaController.animation,
                    builder: (context, child) => Transform.rotate(
                      angle: qiblaController.animation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Color.fromARGB(86, 15, 42, 88),
                                offset: Offset(0, 5),
                                blurRadius: 1.5)
                          ],
                        ),
                        child: SvgPicture.asset(
                          height: side * 0.35,
                          "assets/images/qiblawithneedle.svg",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } catch (e) {
          return const Center(
            child: CircularProgressIndicator(
              color: primColor,
            ),
          );
        }
      },
    );
  }
}
