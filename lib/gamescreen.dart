import "package:flutter/material.dart";
import "utils.dart";

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        centerTitle: true,
        title: Text("Hangman",
            style: retroStyle(30, Colors.white, FontWeight.w700)),
        actions: [
          IconButton(
            icon: Icon(Icons.volume_up_sharp),
            onPressed: () {},
            iconSize: 40,
            color: Colors.purpleAccent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(color: Colors.lightBlueAccent),
                height: 30,
                child: Center(
                  child: Text("12 points",
                      style: retroStyle(15, Colors.white, FontWeight.w700)),
                ),
              ),
              SizedBox(height: 20),
              Image(
                width: 155,
                height: 155,
                image: AssetImage("images/hangman0.png"),
                color: Colors.white,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 15),
              Text("7 lives left",
                  style: retroStyle(15, Colors.grey, FontWeight.w700))
            ],
          ),
        ),
      ),
    );
  }
}
