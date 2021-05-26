import 'package:flutter/material.dart';

import 'package:real_state_game/components/game_boxes.dart';
import 'package:real_state_game/constants.dart';
import 'package:real_state_game/models/movements_history.dart';
import 'package:real_state_game/models/owned_property.dart';

class MainGameScreen extends StatefulWidget {
  static const String id = 'MainGameScreen';

  const MainGameScreen({Key key}) : super(key: key);

  @override
  _MainGameScreenState createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen> {
  int pMoney = 2000; // initial money
  Map<String, OwnedProperty> pProperty = {};
  int outOfJail = 0;

  updateMoney(newMoney) {
    if (newMoney == null || newMoney == 0) {return;}

    movements.add(source: 'Money', type: 'Operation', amount: newMoney);
    setState(() {
      pMoney += newMoney;
    });
  }

  assignProperty(propertyId) {
    bool propertyOwned = pProperty.containsKey(propertyId);
    if(propertyOwned) { return; }

    OwnedProperty newProperty = new OwnedProperty(propertyId: propertyId);

    movements.add(source: 'Property', type: 'Add', amount: newProperty.propertyId);
    setState(() {
      pProperty[propertyId] = newProperty;
    });
  }

  addHouse(propertyId, int multiplier) {
    multiplier ??= 1;
    bool propertyOwned = pProperty.containsKey(propertyId);
    if(!propertyOwned) { return; }

    OwnedProperty myProperty = pProperty[propertyId];
    if (myProperty.ownedHotels > 0) { return; }

    int ownedHouses = myProperty.ownedHouses;
    ownedHouses += 1 * multiplier;
    if (ownedHouses > 4 || ownedHouses < 0) { return; }

    String type = multiplier == 1 ? 'Add' : 'Subtract';
    movements.add(source: 'Houses', type: type, amount: myProperty.propertyId);
    setState(() {
      myProperty.ownedHouses = ownedHouses;
    });
  }

  addHotel(propertyId, int multiplier) {
    multiplier ??= 1;
    bool propertyOwned = pProperty.containsKey(propertyId);
    if(!propertyOwned) { return; }

    OwnedProperty myProperty = pProperty[propertyId];
    if (multiplier == 1) {
      myProperty.ownedHotels = 1;
      myProperty.ownedHouses = 0;
    } else {
      myProperty.ownedHotels = 0;
      myProperty.ownedHouses = 4;
    }

    String type = multiplier == 1 ? 'Add' : 'Subtract';
    movements.add(source: 'Hotels', type: type, amount: myProperty.propertyId);
    setState(() {
      pProperty[propertyId] = myProperty;
    });
  }

  toggleMortgage(propertyId) {
    bool propertyOwned = pProperty.containsKey(propertyId);
    if(!propertyOwned) { return; }

    OwnedProperty myProperty = pProperty[propertyId];
    myProperty.isMortgaged = !myProperty.isMortgaged;

    String mortgagedText = myProperty.isMortgaged ? 'is' : 'not';
    movements.add(source: 'Mortgage', type: '', amount: '$mortgagedText ${myProperty.propertyId}');
    setState(() {
      pProperty[propertyId] = myProperty;
    });
  }

  popProperty(propertyId) {
    bool propertyOwned = pProperty.containsKey(propertyId);
    if(!propertyOwned) { return; }

    pProperty.remove(propertyId);

    movements.add(source: 'Property', type: 'Remove', amount: propertyId);
    setState(() {
      pProperty = pProperty; // ????
    });
  }

  updateOutOfJail(int newCount) {
    movements.add(source: 'outOfJail', type: 'operation', amount: newCount);
    setState(() {
      outOfJail = newCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(flex: 2, fit: FlexFit.tight, child: RowOne(),),
            Flexible(flex: 1, fit: FlexFit.tight, child: RowTwo(properties: pProperty, outOfJail: outOfJail, onOutOfJail: updateOutOfJail, onAddProperty: assignProperty, onAddHouse: addHouse, onAddHotel: addHotel, onMortgage: toggleMortgage, onSell: popProperty)),
            Flexible(flex: 1, fit: FlexFit.tight, child: RowThree(money: pMoney, onMoneyChange: updateMoney))
          ],
        ),
      ),
    );
  }
}

class RowOne extends StatelessWidget {
  const RowOne({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Flexible(flex: 2, fit: FlexFit.tight, child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Colors.blueGrey.shade300, Colors.deepOrange.shade200])), child: Text('Enjoy the \n game'), height: double.infinity)),
          Flexible(fit: FlexFit.tight,
            child: Column(children: [
              Flexible(fit: FlexFit.tight, child:
                Container(child: FortuneBox(), width: double.infinity, color: kBoxColorOne),
              ),
              Flexible(fit: FlexFit.tight, child:
                Container(child: CommunityChestBox(), width: double.infinity, color: kBoxColorTwo),
              ),
            ],),
          ),
        ],
    );
    // return Container(child: Text('Row 1'), width: double.infinity, color: Colors.lightGreen);
  }
}

class RowTwo extends StatelessWidget {
  final Map<String, OwnedProperty> properties;
  final int outOfJail;
  final Function onAddProperty;
  final Function onAddHouse;
  final Function onAddHotel;
  final Function onMortgage;
  final Function onSell;
  final Function onOutOfJail;

  const RowTwo({Key key, this.properties, this.outOfJail, this.onOutOfJail, this.onAddProperty, this.onAddHouse, this.onAddHotel, this.onMortgage, this.onSell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(fit: FlexFit.tight, child: Container(child: PropertiesBox(properties: properties, onAddProperty: onAddProperty, onAddHouse: onAddHouse, onAddHotel: onAddHotel, onMortgage: onMortgage, onSell: onSell), height: double.infinity ,color: kBoxColorOne)),
        Flexible(fit: FlexFit.tight, child: Container(child: BonusCardsBox(outOfJail: outOfJail, onOutOfJail: onOutOfJail), height: double.infinity, color: kBoxColorTwo)),
        Flexible(fit: FlexFit.tight, child: Container(child: DiceBox(), height: double.infinity, color: kBoxColorOne)),
    ],);
    // return Container(child: Text('Row 3'), width: double.infinity,color: Colors.lightBlue);
  }
}

class RowThree extends StatelessWidget {
  final int money;
  final Function onMoneyChange;
  const RowThree({Key key, this.money, this.onMoneyChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(fit: FlexFit.tight, child: Container(child: MoneyBox(money: money, onChange: onMoneyChange), height: double.infinity ,color: kBoxColorTwo)),
      Flexible(fit: FlexFit.tight, child: Container(height: double.infinity, color: kBoxColorOne)),
      Flexible(fit: FlexFit.tight, child: Container(child: JournalBox(), height: double.infinity, color: kBoxColorTwo)),
    ],);
  }
}
