// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController startFrequencyController = TextEditingController();
  TextEditingController endFrequencyController = TextEditingController();
  TextEditingController incrementController = TextEditingController();
  TextEditingController durationPerIterationController =
      TextEditingController();
  TextEditingController waitingPerIterationController = TextEditingController();

  void start() {
    int? startFrequency = int.tryParse(startFrequencyController.text);
    int? endFrequency = int.tryParse(endFrequencyController.text);
    int? iterationIncrement = int.tryParse(incrementController.text);
    int? durationPerIteration =
        int.tryParse(durationPerIterationController.text);
    int? waitingPerIteration = int.tryParse(waitingPerIterationController.text);

    if (startFrequency != null &&
        endFrequency != null &&
        iterationIncrement != null &&
        durationPerIteration != null &&
        waitingPerIteration != null) {
      int count = (endFrequency - startFrequency) ~/ iterationIncrement;

      List<int> intensities = [];
      List<int> pattern = [];

      for (var i = 0; i < count; i++) {
        int secondFrequency = startFrequency! + iterationIncrement;
        intensities.addAll([startFrequency, secondFrequency]);
        pattern.addAll([waitingPerIteration, durationPerIteration]);
        startFrequency = secondFrequency;
      }

      Vibration.vibrate(pattern: pattern, intensities: intensities);
    } else {
      Fluttertoast.showToast(
          msg: "Please Fill all Inputs With numbers",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void stop() {
    Vibration.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibration',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: const Text('Vibrator'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  controller: startFrequencyController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Start frequency',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: endFrequencyController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter End frequency',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: incrementController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Iteration increment',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: durationPerIterationController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Duration per iteration',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: waitingPerIterationController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Waiting per iteration',
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            start();
                          },
                          child: const Text('Start')),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () {
                            stop();
                          },
                          child: const Text('Stop')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
