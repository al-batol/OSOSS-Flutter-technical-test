import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:task_test/pages/animations_page.dart';
import 'package:task_test/pages/pokemons.dart';
import 'package:task_test/pages/splash_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameCtr = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  TextField(
                    controller: nameCtr,
                    decoration: InputDecoration(hintText: 'Enter your name'),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    nameCtr.text.trim().isEmpty
                        ? 'Your name'
                        : nameCtr.text.trim(),
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                nameCtr.clear();
                setState(() {

                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  Text(
                    'Clear Text',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AnimationsPage(text: nameCtr.text.trim()),
                  ),
                );
              },
              padding: EdgeInsets.only(top: 15, bottom: 15),
              color: Color(0xFF0D47A0),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent)),
              textColor: Colors.white,
              minWidth: size.width,
              child: Text(
                'Go to page 1',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PokeMons(),
                ));
                nameCtr.clear();
              },
              padding: EdgeInsets.only(top: 15, bottom: 15),
              color: Color(0xFF63B2F2),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent)),
              textColor: Colors.white,
              minWidth: size.width,
              child: Text(
                'Go to page 2',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
