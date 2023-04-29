import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

Widget _buildOptions(
  int first,
  int second,
  int score,
  int times,
  Function stateManager,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GestureDetector(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(
              '$first',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () => first > second ? stateManager(true) : stateManager(false),
      ),
      GestureDetector(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(
              '$second',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () => second > first ? stateManager(true) : stateManager(false),
      )
    ],
  );
}

Widget _buildBottomContainers(
  int times,
  int score,
  double gap,
  Function restarter,
) {
  if (times < 10) {
    return Container();
  } else {
    return Column(
      children: [
        Text('Correct Answers: $score'),
        Text('Incorrect Answers: ${10 - score}'),
        SizedBox(
          height: gap,
        ),
        ElevatedButton(
          onPressed: () => restarter(),
          child: const Text('Restart'),
        )
      ],
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int times = 0;
  int score = 0;

  void stateManager(bool increase) {
    setState(() {
      times++;
      if (increase) {
        score++;
      }
    });
  }

  void restarter() {
    setState(() {
      times = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double gap = MediaQuery.of(context).size.height * 0.2;

    int firstRandom = math.Random().nextInt(100);
    int secondRandom = math.Random().nextInt(100);

    secondRandom =
        firstRandom != secondRandom ? secondRandom : math.Random().nextInt(100);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Number Guesser'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildOptions(
            firstRandom,
            secondRandom,
            score,
            times,
            stateManager,
          ),
          _buildBottomContainers(times, score, gap, restarter)
        ],
      ),
    );
  }
}
