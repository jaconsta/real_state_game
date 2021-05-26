import 'dart:math';

import 'package:flutter/material.dart';

class RandomCard extends StatefulWidget {
  static const id = 'RandomCard';

    const RandomCard({Key key}) : super(key: key);

  @override
  _RandomCardState createState() => _RandomCardState();
}

class _RandomCardState extends State<RandomCard> {

  String selectedCard = '';

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    String title = arguments['title'];
    List<String> cards = arguments['data'];
    int randomCard = new Random().nextInt(cards.length);
    String cardText = cards[randomCard];

    return Scaffold(
        appBar: AppBar(
            title: Text(title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(child:Text('  Your card'), width: double.infinity,),
                    SizedBox(height: 30.0),
                    Text(cardText, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),),
                    SizedBox(height: 20.0),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('Go back'),),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
