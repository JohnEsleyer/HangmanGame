import "package:flutter/material.dart";
import "utils.dart";

import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String word = wordslist[Random().nextInt(wordslist.length)];

  List guessedalphabets = [];
  int points = 0;
  int status = 0;
  List images = [
    "images/hangman0.png",
    "images/hangman1.png",
    "images/hangman2.png",
    "images/hangman3.png",
    "images/hangman4.png",
    "images/hangman5.png",
    "images/hangman6.png",
  ];

  String handletext() {
    String displayword = "";
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (guessedalphabets.contains(char)) {
        displayword += char + " ";
      } else {
        displayword += "? ";
      }
    }
    return displayword;
  }

  opendialog(String title) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 180,
              decoration: BoxDecoration(color: Colors.purpleAccent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: retroStyle(25, Colors.white, FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Your points: $points",
                    style: retroStyle(20, Colors.white, FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          status = 0;
                          guessedalphabets.clear();
                          points = 0;
                          word = wordslist[Random().nextInt(wordslist.length)];
                        });
                      },
                      child: Center(
                        child: Text(
                          "Play again",
                          style: retroStyle(20, Colors.black, FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  checkletter(String alphabet) {
    if (word.contains(alphabet)) {
      setState(() {
        guessedalphabets.add(alphabet);
        points += 5;
      });
    } else if (status != 6) {
      setState(() {
        status += 1;
        points -= 5;
      });
    } else {
      opendialog("You lost!");
    }

    bool isWon = true;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!guessedalphabets.contains(char)) {
        setState(() {
          isWon = false;
        });
        break;
      }
    }

    if (isWon) {
      opendialog("Hurray, you won");
    }
  }

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
        physics: ScrollPhysics(),
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
                  child: Text("${points} points",
                      style: retroStyle(15, Colors.white, FontWeight.w700)),
                ),
              ),
              SizedBox(height: 20),
              Image(
                width: 155,
                height: 155,
                image: AssetImage(images[status]),
                color: Colors.white,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 15),
              Text("${7 - status} lives left",
                  style: retroStyle(15, Colors.white, FontWeight.w700)),
              SizedBox(height: 30),
              Text(
                handletext(),
                style: retroStyle(35, Colors.white, FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 10),
                childAspectRatio: 1.3,
                physics: NeverScrollableScrollPhysics(),
                children: letters.map((alphabet) {
                  return InkWell(
                    onTap: () => checkletter(alphabet),
                    child: Center(
                      child: Text(alphabet,
                          style: retroStyle(20, Colors.white, FontWeight.w700)),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
