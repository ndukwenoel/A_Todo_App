import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor:Colors.grey ,
          body: Container(
            padding: const EdgeInsets.fromLTRB(15, 30, 10, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        // boxShadow:BoxShadow(),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                        padding: const EdgeInsets.all(5),
                        color: Colors.black,
                        iconSize: 40,
                      ),
                    ),
                    const Expanded(
                        child: SizedBox(
                      width: double.infinity,
                    )),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const ImageIcon(
                              AssetImage("assets/images/profile.png"))),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                        child: Text(
                      "Get Your Task",
                      style: TextStyle(
                        wordSpacing: 4,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    )),
                    SizedBox(height: 15),
                    SizedBox(
                      child: Text(
                        "Easily",
                        style: TextStyle(
                          wordSpacing: 4,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      child: Text(
                        "20 Tasks Available",
                        style: TextStyle(
                          wordSpacing: 4,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 30),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black87,
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            child: Text(
                              "Your Task Growth",
                              style: TextStyle(
                                  wordSpacing: 4,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            child: Text(
                              "8 Tasks Completed",
                              style: TextStyle(
                                  wordSpacing: 4,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
                      Flexible(
                          child: SizedBox(width: MediaQuery.of(context).size.width)),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
