import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 350),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
