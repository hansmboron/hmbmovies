import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdContainner extends StatelessWidget {
  final double height;
  final AdWithView ad;

  const AdContainner({
    Key? key,
    required this.height,
    required this.ad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: height,
      color: Colors.white10,
      child: Center(
        child: AdWidget(
          key: UniqueKey(),
          ad: ad,
        ),
      ),
    );
  }
}
