import 'package:flutter/material.dart';
import 'package:yummy/constants.dart';
import 'package:yummy/models/order_manager.dart';
import 'package:yummy/screens/home_view.dart';
import 'package:yummy/models/food_category.dart';
import 'package:yummy/models/post.dart';

void main() {
  runApp(const Yummy());
}

class Yummy extends StatefulWidget {
  const Yummy({super.key});

  @override
  State<Yummy> createState() => _YummyState();
}

class _YummyState extends State<Yummy> {
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.pink;

  void changeTheme() {
    setState(() {
      if (themeMode == ThemeMode.light) {
        themeMode = ThemeMode.dark;
      } else if (themeMode == ThemeMode.dark) {
        themeMode = ThemeMode.light;
      }
    });
  }

  void changeColor(int index) {
    setState(() {
      colorSelected = ColorSelection.values[index];
    });
  }

  final OrderManager orderManager = OrderManager();
  @override
  Widget build(BuildContext context) {
    // final ThemeMode themeMode = ThemeMode.light;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(
        onPressed: () {
          changeTheme();
        },
        colorSelected: colorSelected,
        onTapColor: changeColor,
        foodCategory: FoodCategory("name", 2, "assets/food/burger.webp"),
        post: Post("1", "assets/profile_pics/person_katz.jpeg", "comment", ""),
        orderManager: orderManager,
      ),
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: colorSelected.color, // بيكب لون (ارزق فى ابيض)
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: colorSelected.color, // بيكب لون (ارزق فى اسود)
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}

// typedef ThemeToggleCallBack = void Function();
