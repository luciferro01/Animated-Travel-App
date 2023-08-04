import 'dart:async';

import 'package:flutter/material.dart';

import 'constants.dart';
import 'image_card.dart';
import 'location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _controller;
  double _rotateY = 0.0;
  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: .7,
    );
    _controller.addListener(() {
      var currentPosition = _controller.page ?? 0;
      var converted = currentPosition % 1; // to get value 0 - 1
      if (converted >= 0.5) {
        converted = 1 - converted;
      }
      setState(() {
        _rotateY = converted;
      });
    });
    bool forward = true;
    //we will scroll every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (forward) {
        if (_selectedIndex < 4) {
          _selectedIndex++;
        } else {
          forward = false;
        }
      }
      if (!forward) {
        if (_selectedIndex <= 4 && _selectedIndex > 0) {
          _selectedIndex--;
        } else {
          forward = true;
        }
      }
      _controller.animateToPage(_selectedIndex,
          duration: const Duration(milliseconds: 1200), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        selectedIconTheme: const IconThemeData(color: kDarkColor),
        unselectedIconTheme: const IconThemeData(color: kSilverColor),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: size.height * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, size: 35.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * .15),
            child: const Text(
              'Find your\nnext vacation',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: size.height * .6,
            child: PageView.builder(
              itemCount: locations.length,
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              itemBuilder: (context, index) {
                Location location = locations[index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(_rotateY),
                    child: ImageCard(
                      size: size,
                      location: location,
                      isSelected: index == _selectedIndex ? true : false,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
