import 'package:flutter/material.dart';
import 'package:step_builder/step_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StepBuilderExample(),
    );
  }
}

class StepBuilderExample extends StatelessWidget {
  const StepBuilderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Step Builder Example")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StepBuilder(
          stepCount: 4,
          stepBuilder: (context, step) {
            return Center(
              child: Text("Step ${step + 1}", style: const TextStyle(fontSize: 24)),
            );
          },
          onStepChange: (step) {
            print("Step changed to $step");
          },
          onFinish: () {
            print("Steps completed!");
          },
        ),
      ),
    );
  }
}
