import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  late double deviceHeight;
  late double deviceWeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWeight = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: deviceHeight,
        width: deviceWeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: deviceHeight,
      width: deviceWeight,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://i.ebayimg.com/images/g/rTUAAOSwFaRkfzZ8/s-l1200.jpg'),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
