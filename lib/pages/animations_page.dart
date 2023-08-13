import 'package:flutter/material.dart';

class AnimationsPage extends StatefulWidget {
  final String text;

  const AnimationsPage({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<AnimationsPage> createState() => _AnimationsPageState();
}

class _AnimationsPageState extends State<AnimationsPage> {
  double? radius;
  Color color = Color(0xFF0D47A1);

  void changeRadius(double? newRadius) {
      radius = newRadius;
  }

  void changeColor(Color newColor) {
      color = newColor;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 60),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: color,
                borderRadius: radius == null ? null : BorderRadius.circular(radius!),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    changeRadius(0);
                    changeColor(Color(0xFF0D47A1));
                    setState(() {

                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    changeRadius(30);
                    changeColor(Colors.blue);
                    setState(() {
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    changeRadius(MediaQuery.of(context).size.width / 2);
                    changeColor(Colors.red);
                    setState(() {
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 2),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
