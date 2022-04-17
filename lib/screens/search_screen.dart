import 'package:flutter/material.dart';
import 'package:word_word/widgets/word_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

int value = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  int getPage() {
    return value;
  }

  void setPage(int page) {
    value = page;
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late SharedPreferences preference;

  //bool _isVisible = false;
  @override
  void initState() {
    _pageController = PageController(
      keepPage: true,
      initialPage: widget.getPage(),
    );
    init();
    super.initState();
  }
  //
  // animateIcon() {
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     setState(() {
  //       _isVisible = !_isVisible;
  //     });
  //   });
  // }
  //
  // autoNavigate() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //   });
  // }

  Future init() async {
    preference = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    //Hive.close();
    _pageController.dispose();
    //Hive.box('word_box').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.white,
      body: Word(word: ''),
    );
  }
}
