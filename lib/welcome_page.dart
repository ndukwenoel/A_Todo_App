import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'homePage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
  Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const  BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.bottomCenter,
              //     end: Alignment.topCenter,
              //     colors: [
              //   Colors.black.withOpacity(0.9),
              //   Colors.black.withOpacity(0.6),
              //   Colors.black.withOpacity(0.4)
              // ]),
            color: Colors.black
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 230),
                  child: Text(
                """TASK \n IT.""",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 90,
                  fontWeight: FontWeight.w800,
                  color: Colors.lightBlueAccent[100],
                ),
              )),
              const Expanded(child: SizedBox(height: 30)),
              const Spacer(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Your Daily ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "Tasks",
                        style: TextStyle(
                          color: Colors.lightGreenAccent[100],
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Management",
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Task management is the process of\n"
                    "managing a task through it's life cycle.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: "assets/fonts/Montserrat-Regular.ttf",
                      wordSpacing: 2,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 50, top: 20),
                    width: 450,
                    height: 70,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.lightGreenAccent,
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) =>  const HomePage()));
                        },
                        child: const Text(
                          "Get Started",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            fontFamily: "Montserrat",

                          ),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      );
  }
}
