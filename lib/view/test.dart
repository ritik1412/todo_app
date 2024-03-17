import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Test(),
    debugShowCheckedModeBanner: false,
  ));
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black,
                  ),
                  height: 8,
                  width: MediaQuery.of(context).size.width - 70,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(50),
                    ),
                    color: Colors.green,
                  ),
                  width: ((MediaQuery.of(context).size.width - 72) / 6),
                  height: 8,
                ),
                Positioned(
                  left: ((MediaQuery.of(context).size.width - 72) / 6),
                  child: Container(
                    color: Colors.lightGreen,
                    width: ((MediaQuery.of(context).size.width - 72) / 6),
                    height: 8,
                  ),
                ),
                Positioned(
                  left: ((MediaQuery.of(context).size.width - 72) / 3),
                  child: Container(
                    color: Colors.yellow,
                    width: ((MediaQuery.of(context).size.width - 72) / 6),
                    height: 8,
                  ),
                ),
                Positioned(
                  left: ((MediaQuery.of(context).size.width - 72) / 2),
                  child: Container(
                    color: Colors.orange,
                    width: ((MediaQuery.of(context).size.width - 72) / 6),
                    height: 8,
                  ),
                ),
                Positioned(
                  left: ((MediaQuery.of(context).size.width - 72) * 2 / 3),
                  child: Container(
                    color: Colors.red,
                    width: ((MediaQuery.of(context).size.width - 72) / 6),
                    height: 8,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    color: Colors.brown,
                    width: ((MediaQuery.of(context).size.width - 72) / 6),
                    height: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
