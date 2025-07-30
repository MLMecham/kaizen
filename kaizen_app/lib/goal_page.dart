import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalPage extends StatefulWidget {
  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final goalController = TextEditingController();
  List<String> savedGoals = [];

  @override
  void initState() {
    super.initState();
    loadGoals();
  }

  Future<void> loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedGoals = prefs.getStringList('goals') ?? [];
    });
  }

  Future<void> saveGoal() async {
    final text = goalController.text.trim();
    if (text.isEmpty) return; // Ignore empty inputs

    final prefs = await SharedPreferences.getInstance();
    savedGoals.add(text);
    await prefs.setStringList('goals', savedGoals);

    setState(() {});
    goalController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Goals"),
        leading: IconButton(
          icon: Icon(Icons.logout),
          tooltip: 'Logout',
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Input part
            TextField(
              controller: goalController,
              decoration: InputDecoration(labelText: "Enter new goal"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveGoal,
              child: Text("Save Goal"),
            ),
            SizedBox(height: 20),

            // Scrollable list of saved goals
            Expanded(
              child: savedGoals.isEmpty
                  ? Center(child: Text("No goals saved yet."))
                  : ListView.builder(
                      itemCount: savedGoals.length,
                      itemBuilder: (context, index) {
                        final goal = savedGoals[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(goal),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
