import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CharacterLoadingIndicator extends StatefulWidget {
  const CharacterLoadingIndicator({super.key});

  @override
  State<CharacterLoadingIndicator> createState() => _CharacterLoadingIndicatorState();
}

class _CharacterLoadingIndicatorState extends State<CharacterLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        child: Lottie.asset('assets/animations/Cosmos.json', frameRate: FrameRate(200)),
      ),
    );
  }
}
