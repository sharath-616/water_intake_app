import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_intake_app/widget/custome_text_widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _waterIntake = 0;
  int _dailyGoal = 0;
  final List<int> _dailyGoalOptions = [8, 10, 12];

  // app open time value on the memmory
  @override
  initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _waterIntake = (pref.getInt('waterIntake') ?? 0);
      _dailyGoal = (pref.getInt('dailyGoal') ?? 8); // set 8 defualt
    });
  }

//number of glass count increese

  Future<void> _incrementWaterIntake() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _waterIntake++;
      pref.setInt('waterIntake', _waterIntake);

      //to check waterintake graterthan or dailyintake

      if (_waterIntake >= _dailyGoal) {
        _showGoalReachDialog();
      }
    });
  }

//to reset wayterintake

  Future<void> _resetWaterIntake() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _waterIntake = 0;
      pref.setInt('waterIntake', _waterIntake);
    });
  }

// set the goal all time

  Future<void> _setDailyGoal(int newGoal) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _dailyGoal = newGoal;
      pref.setInt('dailyGoal', newGoal);
    });
  }

  // a dialog box box when the goal reached

  Future<void> _showGoalReachDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomTextWidget(text: "Congatulations..!"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                CustomTextWidget(text: "You have reached your daily goal of $_dailyGoal glass(es) of water..!"),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const CustomTextWidget(
                  text: 'Ok',
                  clr: Colors.black,
                  fs: 20,
                  fw: FontWeight.bold,
                ))
          ],
        );
      },
    );
  }

  Future<void> _showResetConfirmationDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomTextWidget(text: "Reset Water Intake..!"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: [
                CustomTextWidget(text: "Are you sure..? You want to reset your water intake..!"),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const CustomTextWidget(
                  text: 'Cancel',
                  clr: Colors.black,
                  fs: 20,
                  fw: FontWeight.bold,
                )),
            TextButton(
                onPressed: () {
                  _resetWaterIntake();
                  Navigator.of(context).pop();
                },
                child: const CustomTextWidget(
                  text: 'Reset',
                  clr: Colors.black,
                  fs: 20,
                  fw: FontWeight.bold,
                ))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = _waterIntake / _dailyGoal;
    bool goalReached = _waterIntake >= _dailyGoal;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.water_drop_rounded,
                size: 200,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomTextWidget(
                text: 'You have cousumed :',
                clr: Colors.black,
                fs: 20,
                fw: FontWeight.w500,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextWidget(
                text: '$_waterIntake  glass(es) of water',
                clr: Colors.black,
                fs: 25,
                fw: FontWeight.w600,
              ),
              const SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                minHeight: 20,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomTextWidget(
                text: 'Daily Goals',
                clr: Colors.black,
                fs: 25,
                fw: FontWeight.w600,
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton(
                  value: _dailyGoal,
                  items: _dailyGoalOptions.map((int value) {
                    return DropdownMenuItem(value: value, child: CustomTextWidget(text: '$value glasses'));
                  }).toList(),
                  onChanged: (int? newvalue) {
                    if (newvalue != null) {
                      _setDailyGoal(newvalue);
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: goalReached ? null : _incrementWaterIntake,
                child: const CustomTextWidget(
                  text: 'Add a glass of water',
                  clr: Colors.black,
                  fs: 18,
                  fw: FontWeight.w500,
                  ls: 0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _showResetConfirmationDialog();
                  
                },
                child: const CustomTextWidget(
                  text: 'Reset',
                  clr: Colors.black,
                  fs: 18,
                  fw: FontWeight.w500,
                  ls: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
