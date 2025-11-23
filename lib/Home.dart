import 'dart:async';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int seconds =0;
  String selectedMode = "None";
  String exercise = "Select Your Exercise";
  Timer? timer;
  int inhaleCalm =4,
  inhaleSoft=3,
  inhaleHard=6,
  holdCalm=2,
  holdSoft=1,
  holdHard=10,
  exhaleHard=7,
  exhaleSoft=3,
  exhaleCalm=4;

  void breathingEx(int inhale, int hold, int exhale) {
    timer?.cancel();
    exercise = "Inhale";
    seconds = inhale;
    setState(() {});
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (seconds == 0) {
        if (exercise == "Inhale") {
          exercise = "Hold";
          seconds = hold;
        }
        else if (exercise == "Hold") {
          exercise = "Exhale";
          seconds = exhale;
        }
        else if (exercise == "Exhale") {
          t.cancel();
          exercise = "Done";
        }
        setState(() {});
        return;
      }
      setState(() => seconds--);
    });
  }
  void stopButton(){
    timer?.cancel();
    seconds=0;
    exercise="Stopped, Select another mode to start";
    setState(() {

    });
  }
  void updateExercise(String mode) {
    setState(() => selectedMode = mode);

    if (mode == "Calm") {
      breathingEx(inhaleCalm, holdCalm, exhaleCalm);
    } else if (mode == "Soft") {
      breathingEx(inhaleSoft, holdSoft, exhaleSoft);
    } else if (mode == "Hard") {
      breathingEx(inhaleHard, holdHard, exhaleHard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20.0,),
            const Text('Select Type Of Breathing Exercise Based On Your Mood:',style: TextStyle(fontSize: 25)),
            const SizedBox(height: 10,),
            MyDropDownMenuWidget(updateExercise),
            const SizedBox(height: 10.0),
            Text("Mode: $selectedMode",
            style: const TextStyle(fontSize: 20)
            ),
            Text("Exercise: $exercise",
                style: const TextStyle(fontSize: 24)
            ),
            Text("Seconds: $seconds",
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height:10),
            ElevatedButton(onPressed: (){stopButton();},child: Text("Stop Exercise", style: TextStyle(fontSize: 24),),),
          ],
          
        ),
      ),
    );
  }
}

class MyDropDownMenuWidget extends StatefulWidget {
  const MyDropDownMenuWidget(this.updateEx, {super.key});
  final Function(String) updateEx;
  @override
  State<MyDropDownMenuWidget> createState() => _MyDropDownMenuWidgetState();
}
class _MyDropDownMenuWidgetState extends State<MyDropDownMenuWidget> {
  String? value = "Calm";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      items: const [
        DropdownMenuItem(value: "Calm", child: Text("Calm")),
        DropdownMenuItem(value: "Soft", child: Text("Soft")),
        DropdownMenuItem(value: "Hard", child: Text("Hard")),
      ],
      onChanged: (val) {
        setState(() => value = val);
        widget.updateEx(val!);
      },
    );
  }
}

