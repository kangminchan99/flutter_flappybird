import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_game/barrier.dart';
import 'package:flutter_game/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bird variables
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9; // how strong the gravity is
  double velocity = 3.5; // how strong the jump is
  double birdWidth = 0.1; // out of 2, 2 being the entire width of the screen
  double birdHeight = 0.1; // out of 2, 2 being the entire height of the screen
  static double barrierXone = 1;

  double barrierXtwo = barrierXone + 2;

  //game settings
  bool gameHasStarted = false;

  // 베리어 다트에서 사이즈를 가져왔는데 이거 맞나?
  // get size => MyBarrier();

  // //barrier variables
  // static List<double> barrierX = [2, 2 + 1.5];
  // static double barrierWidth = 0.5; // out of 2
  // List<List<double>> barrierHeight = [
  //   // out of 2, where 2 is the entire height of the screen
  //   // [topHeight, bottomHeight]
  //   [0.6, 0.4],
  //   [0.4, 0.6]
  // ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 13), (timer) {
      // a real physical jump is the same as an upside down parabola
      // so this is a simple quadratic equation
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialPos - height;
      });

      setState(() {
        if (barrierXone < -2) {
          barrierXone += 4;
        } else {
          barrierXone -= 0.01;
        }
      });

      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 4;
        } else {
          barrierXtwo -= 0.01;
        }
      });

      // check if bird is dead
      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }

      // keep the time going!!
      time += 0.01;
    });
  }

  // void moveMap() {
  //   for (int i = 0; 1 < barrierX.length; i++) {
  //     // keep barriers moving
  //     setState(() {
  //       barrierX[i] -= 0.05;
  //     });
  //
  //     // if barrier exits time left part of the screen, keep it looping
  //     if (barrierX[i] < -1.5) {
  //       barrierX[i] += 3;
  //     }
  //   }
  // }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
      barrierXone = 1;
      barrierXtwo = barrierXone + 2;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                'Game Over',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                  onTap: resetGame,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.white,
                      child: Text(
                        'Play Again',
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  ))
            ],
          );
        });
  }

  // check if the bird is hitting top or the bottom of the screen
  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }

    // size  변수 가져와서 해봤는데 기둥에 맞으면 멈춤 왜그러지?

    // if (barrierXone <= birdWidth &&
    //     barrierXone >= -birdWidth &&
    //     (birdY <=  size || birdY + birdHeight >=  size)) {
    //   return false;
    // }

    // // hits barriers
    // for (int i = 0; i < barrierX.length; i++) {
    //   if (barrierX[i] <= birdWidth &&
    //       barrierX[i] + barrierWidth >= -birdWidth &&
    //       (birdY <= -1 + barrierHeight[i][0] ||
    //           birdY + birdHeight >= 1 - barrierHeight[i][1])) {
    //     return true;
    //   }
    // }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              //blue 컬러 비율 늘리기
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdY: birdY,
                        birdWidth: birdWidth,
                        birdHeight: birdHeight,
                      ),
                      // tap to play
                      // MyCoverScreen(gameHasStarted: gameHasStarted),

                      // Top barrier 0
                      // MyBarrier(
                      //   barrierX: barrierX[0],
                      //   barrierWidth: barrierWidth,
                      //   barrierHeight: barrierHeight[0][1],
                      //   isThisBottomBarrier: false,
                      // ),
                      //
                      // // Bottom barrier 0
                      // MyBarrier(
                      //   barrierX: barrierX[0],
                      //   barrierWidth: barrierWidth,
                      //   barrierHeight: barrierHeight[0][1],
                      //   isThisBottomBarrier: true,
                      // ),
                      //
                      // // Top barrier 1
                      // MyBarrier(
                      //   barrierX: barrierX[1],
                      //   barrierWidth: barrierWidth,
                      //   barrierHeight: barrierHeight[1][0],
                      //   isThisBottomBarrier: false,
                      // ),
                      //
                      // // Bottom barrier 1
                      // MyBarrier(
                      //   barrierX: barrierX[1],
                      //   barrierWidth: barrierWidth,
                      //   barrierHeight: barrierHeight[1][1],
                      //   isThisBottomBarrier: true,
                      // ),

                      Container(
                        alignment: Alignment(0, -0.5),
                        child: Text(
                          gameHasStarted ? '' : 'TAP TO PLAY',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      // X축을 barrierXone,barrierXtwo로 설정하여 double로 설정해준 뒤
                      // 게임이 시작하면 one과 two를 -=를 사용하여 배리어를 뒤로 이동시킨다.
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierXone, 1.1),
                        child: MyBarrier(
                          size: 200.0,
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierXone, -1.1),
                        child: MyBarrier(
                          size: 200.0,
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierXtwo, 1.1),
                        child: MyBarrier(
                          size: 150.0,
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierXtwo, -1.1),
                        child: MyBarrier(
                          size: 250.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child:
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("score",style: TextStyle(color: Colors.white)),
                      SizedBox(height: 20,),
                      Text("0"),],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("best"),
                      SizedBox(height: 20,),
                      Text("10"),],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
