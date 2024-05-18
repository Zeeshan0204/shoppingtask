import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertask/core/config/themes/app_colors.dart';
import 'package:fluttertask/main.dart';
import 'package:fluttertask/widgets/gradient_background.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textOneEditingController = TextEditingController();
    TextEditingController _textTwoEditingController = TextEditingController();
    return Center(
        child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("Base Screen"),
      ),
      body: GradientBackground(
        child: Center(
            child: Consumer<CounterModel>(builder: (context, value, child) {

              _textOneEditingController.text=value.counter.toString();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(color: AppColors.white),
                  controller: _textOneEditingController,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: AppColors.greytext),
                      hintText: "Input 1",
                      labelText: "Input 1",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textTwoEditingController,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: AppColors.greytext),
                      hintText: "Input 2",
                      labelText: "Input 2",
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: AppColors.white)),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    print("CALL ELEVATED");
                    Provider.of<CounterModel>(context, listen: false).increment();
                  },
                  child: const Text("Submit"))
            ],
          );
        })),
      ),
    ));
  }
}
