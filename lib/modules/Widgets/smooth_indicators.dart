import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothIndicators extends StatelessWidget {
  final PageController pageController;
  final int indicatorsNumber;
  const SmoothIndicators({Key? key,required this.pageController,required this.indicatorsNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: indicatorsNumber,
      axisDirection: Axis.horizontal,
      effect: const SlideEffect(
          spacing:  8.0,
          radius:  10.0,
          dotWidth:  15.0,
          dotHeight:  15.0,
          paintStyle:  PaintingStyle.stroke,
          strokeWidth:  1.5,
          dotColor:  Colors.grey,
          activeDotColor: secondColor
      ),
    );
  }
}
