import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:real_state_game/data/fortune.dart' as fortuneData;
import 'package:real_state_game/data/loot_chest.dart' as lootChestData;
import 'package:real_state_game/models/movements_history.dart';
import 'package:real_state_game/models/owned_property.dart';
import 'package:real_state_game/screens/money_screen.dart';
import 'package:real_state_game/screens/movements_history_screen.dart';
import 'package:real_state_game/screens/property_screen.dart';
import 'package:real_state_game/screens/random_card.dart';


class FortuneBox extends StatelessWidget {
  const FortuneBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RandomCard.id, arguments: {'data': fortuneData.fortuneChestCards, 'deckName': 'fortune', 'deckCount': 14, 'title': 'Fortune'});
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.question, size: 40),
          Text('Fortune'),
        ],
      ),
    );
  }
}

class CommunityChestBox extends StatelessWidget {
  const CommunityChestBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RandomCard.id, arguments: {'data': lootChestData.lootChestCards, 'deckName': 'chest', 'deckCount': 15,  'title': 'Loot chest'});
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.piggyBank, size: 40),
          Text('Loot chest'),
        ],
      ),
    );
  }
}

class PropertiesBox extends StatelessWidget {
  final Map<String, OwnedProperty> properties;
  final Function onAddProperty;
  final Function onAddHouse;
  final Function onAddHotel;
  final Function onMortgage;
  final Function onSell;

  const PropertiesBox({Key key, this.properties, this.onAddProperty, this.onAddHouse, this.onAddHotel, this.onMortgage, this.onSell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PropertyScreen.id, arguments: { 'properties': properties, 'onAddProperty': onAddProperty, 'onAddHouse': onAddHouse, 'onAddHotel': onAddHotel, 'onMortgage': onMortgage, 'onSell': onSell });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.home, size: 40),
          Text('Properties'),
        ],
      ),
    );
  }
}

class DiceBox extends StatefulWidget {
  const DiceBox({Key key}) : super(key: key);

  @override
  _DiceBoxState createState() => _DiceBoxState();
}

class _DiceBoxState extends State<DiceBox> {
  static const diceFaces = 6;
  int diceOne = 0;
  int diceTwo = 0;
  final player = AudioCache();

  void onTap() {
    var random = new Random();
    player.play('audio/Shake_And_Roll_Dice-SoundBible-591494296.wav');
    HapticFeedback.mediumImpact();

    setState(() {
      diceOne = random.nextInt(diceFaces) + 1;
      diceTwo = random.nextInt(diceFaces) + 1;
    });
    // print('HISTORY - Dices - Operation - ($diceOne) ($diceTwo)');
    // movements.add(source: 'Dices', type: 'Operation', amount: '($diceOne) ($diceTwo)');
  }

  @override
  Widget build(BuildContext context) {
    int sumDice = diceOne + diceTwo;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.diceSix, size: 40),
          Text('Dices'),
          SizedBox(height: 10.0),
          Text('($diceOne) ($diceTwo) = $sumDice', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}

class MoneyBox extends StatelessWidget {
  final int money;
  final Function onChange;
  const MoneyBox({Key key, this.money, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var amount = await Navigator.pushNamed(context, MoneyScreen.id, arguments: <String, dynamic>{'currentMoney': money });
        print('HISTORY - Money - Operation - $amount');
        movements.add(source: 'Money', type: 'Operation', amount: amount);
        onChange(amount);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.moneyBill, size: 40),
          Text('Money'),
          SizedBox(height: 10.0),
          Text('$money', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}

class JournalBox extends StatelessWidget {
  const JournalBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MovementHistoryScreen.id);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.history, size: 40), // journalWhills),
          Text('History'),
        ],
      ),
    );
  }
}

class BonusCardsBox extends StatelessWidget {
  final int outOfJail;
  final Function onOutOfJail;

  const BonusCardsBox({Key key, this.outOfJail, this.onOutOfJail}) : super(key: key);

  void updateOutOfJail(int sign) {
    int newCards = outOfJail + sign;
    if (newCards < 0 ) {return;}
    onOutOfJail(newCards);
  }

  onTap(BuildContext context) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        title: 'Get out of Jail',
        desc: 'You have $outOfJail cards',
        btnOkText: 'Add one',
        btnCancelText: outOfJail == 0 ? '-' : 'Use one',
        btnCancelOnPress: () {updateOutOfJail(-1);},
        btnOkOnPress: () {updateOutOfJail(1);}
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.theaterMasks, size: 40,),
          Text('Bonus cards'),
        ],
      ),
    );
  }
}
