library step_builder;

import 'package:flutter/material.dart';

class StepBuilder extends StatefulWidget {
  final int stepCount;
  final IndexedWidgetBuilder stepBuilder;
  final ValueChanged<int>? onStepChange;
  final VoidCallback? onFinish;
  final Color progressColor;
  final Color backgroundColor;
  final TextStyle? stepTextStyle;

  const StepBuilder({
    Key? key,
    required this.stepCount,
    required this.stepBuilder,
    this.onStepChange,
    this.onFinish,
    this.progressColor = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.stepTextStyle,
  }) : super(key: key);

  @override
  _StepBuilderState createState() => _StepBuilderState();
}

class _StepBuilderState extends State<StepBuilder> {
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < widget.stepCount - 1) {
      setState(() => _currentStep++);
      widget.onStepChange?.call(_currentStep);
    } else {
      widget.onFinish?.call();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      widget.onStepChange?.call(_currentStep);
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentStep + 1) / widget.stepCount;

    return Column(
      children: [
        // Step Counter and Progress Bar
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text(
                "Step ${_currentStep + 1} of ${widget.stepCount}",
                style: widget.stepTextStyle ?? 
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: widget.backgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(widget.progressColor),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),

        // Step Content
        Expanded(child: widget.stepBuilder(context, _currentStep)),

        // Navigation Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentStep > 0)
              ElevatedButton(
                onPressed: _previousStep,
                child: const Text("Back"),
              ),
            ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
              ),
              child: Text(
                _currentStep == widget.stepCount - 1 ? "Finish" : "Next",
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
