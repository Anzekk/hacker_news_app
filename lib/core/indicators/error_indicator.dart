import 'package:flutter/material.dart';
import 'package:hacker_news_app/util/text_style_helper.dart';

class ErrorIndicator extends StatefulWidget {
  final String errorMessage;

  const ErrorIndicator({Key? key, required this.errorMessage}) : super(key: key);

  @override
  State<ErrorIndicator> createState() => _ErrorIndicatorState();
}

class _ErrorIndicatorState extends State<ErrorIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Seems like an error occurred', style: TextStyleHelper.big(), textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: RotationTransition(
                    turns: _animationController,
                    child: const Icon(Icons.settings, color: Colors.red, size: 45),
                  ),
                )
              ],
            ),
          ),
          Text(widget.errorMessage, style: TextStyleHelper.body(), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }
}
