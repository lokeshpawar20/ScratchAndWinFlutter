import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//TODO: import images
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");

//TODO: get and array

  List<String> itemArray;
  int luckyNumber, numberOfChances;

//TODO: initalize array with 25 elements

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemArray = List<String>.generate(25, (index) => "empty");
    numberOfChances = 0;
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    print(random);
    setState(() {
      luckyNumber = random;
    });
  }

//TODO: define a getImage method

  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return circle;
  }

//TODO: play game method

  playGame(int index) {
    if (this.numberOfChances < 5) {
      if (luckyNumber == index) {
        setState(() {
          itemArray[index] = "lucky";
          Widget okbutton = FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              this.showAll();
            },
          );
          AlertDialog alert = AlertDialog(
            title: Text("You Won"),
            content: Text("You got Lucky You Won"),
            actions: [okbutton],
          );
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              });
        });
      } else {
        setState(() {
          itemArray[index] = "unlucky";
        });
      }
      this.numberOfChances++;
    } else {
      Widget okbutton =
          FlatButton(onPressed: Navigator.of(context).pop, child: Text("OK"));
      AlertDialog alert = AlertDialog(
        title: Text("You lost"),
        content: Text("You have already utilized all of your chances"),
        actions: [okbutton],
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }
  }

//TODO: showall
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

//TODO: resetall
  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
      numberOfChances = 0;
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch and Win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.all(20.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: itemArray.length,
                itemBuilder: (context, i) => SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          this.playGame(i);
                        },
                        child: Image(
                          image: this.getImage(i),
                        ),
                      ),
                    )),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: Text(
              "No of chances remaining:${5 - numberOfChances}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                this.showAll();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Show All",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                this.resetGame();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Reset",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(0.0),
            color: Colors.black,
            child: Text(
              'Developed by Lokesh',
              style: TextStyle(
                backgroundColor: Colors.black,
                color: Colors.white,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
