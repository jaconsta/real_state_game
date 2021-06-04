import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:real_state_game/data/properties.dart';
import 'package:real_state_game/models/owned_property.dart';

import 'package:real_state_game/models/property_card.dart';

class PropertyScreen extends StatefulWidget {
  static const id = 'PropertyScreen';

  const PropertyScreen({Key key}) : super(key: key);

  @override
  _PropertyScreenState createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
/*
  DropdownButton<String> newPropertySelectAndrd() {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    Map<String, OwnedProperty> properties = arguments['properties'];

    return DropdownButton(value: propertyCards[0].id, onChanged: (String newId){}, items: propertyCards.where((PropertyCard realState) => !properties.containsKey(realState.id)).map((PropertyCard realState) => DropdownMenuItem(value: realState.id, child: Text(realState.name, style: TextStyle(color: realState.color),))).toList());
  }
*/

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    Map<String, OwnedProperty> properties = arguments['properties'];
    Function onAddProperty = arguments['onAddProperty'];
    Function onAddHouse = arguments['onAddHouse'];
    Function onAddHotel = arguments['onAddHotel'];
    Function onMortgage = arguments['onMortgage'];
    Function onSell = arguments['onSell'];

    return Scaffold(
      appBar: AppBar(title: Text('My real state')),
      body: Column(
        children: [
          Text('🔥     💎💎🙌🚀     🔥'),
          Flexible(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                ...propertyCards
                    .where((PropertyCard realState) =>
                        properties.containsKey(realState.id))
                    .map((PropertyCard realState) =>
                        RealStateOverview(
                            propertyCard: realState,
                            ownedProperty: properties[realState.id],
                            onAddHouse: (String propertyId, int operator) { onAddHouse(propertyId, operator); },
                            onAddHotel: (String propertyId, int operator) { onAddHotel(propertyId, operator); },
                            onSell: (String propertyId) {onSell(propertyId); Navigator.pop(context);},
                            onMortgage: onMortgage
                        ))
                    .toList()
              ],
            ),
          ),
          RealStateAdd(
            properties: properties,
            onOkPressed: (String propertyId) {onAddProperty(propertyId); Navigator.pop(context);},
          ),
        ],
      ),
    );
  }
}

class RealStateAdd extends StatelessWidget {
  final Map<String, OwnedProperty> properties;
  final Function onOkPressed;

  const RealStateAdd({Key key, this.properties, this.onOkPressed}) : super(key: key);

  Iterable<PropertyCard> getUnselectedCards() {
    return propertyCards.where((PropertyCard realState) =>
        !properties.containsKey(realState.id));
  }

  TextButton renderOptions({BuildContext context, PropertyCard realState, onPressed, selectedId}) {
    String propertyName = FlutterI18n.translate(context, 'property-${realState.id}');
    return TextButton(
        style: selectedId == realState.id
            ? TextButton.styleFrom(backgroundColor: Colors.deepPurple.shade50)
            : null,
        onPressed: onPressed,
        child: Text(
          '$propertyName   (\$${realState.purchasePrice})',
          style: TextStyle(color: realState.color),
        ));
  }

  void showPropertyList(BuildContext context) {
    String selectedId = '';
    AwesomeDialog(
        context: context,
        dialogType: DialogType.NO_HEADER,
        headerAnimationLoop: false,
        animType: AnimType.BOTTOMSLIDE,
        btnCancelOnPress: () {},
        btnOkOnPress: () { onOkPressed(selectedId); },
        body: StatefulBuilder(builder: (context, setNewState) {
          return Container(
            height: 450,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: getUnselectedCards()
                  .map((PropertyCard realState) => renderOptions(
                      context: context,
                      realState: realState,
                      selectedId: selectedId,
                      onPressed: () {
                        setNewState(() {
                          selectedId = realState.id;
                        });
                      }))
                  .toList(),
            ),
          );
        }))
      ..show();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showPropertyList(context);
        },
        child: Text('Add new'));
  }
}

class RealStateOverview extends StatelessWidget {
  final PropertyCard propertyCard;
  final OwnedProperty ownedProperty;
  final Function onAddHouse;
  final Function onAddHotel;
  final Function onMortgage;
  final Function onSell;

  static const double iconSpace = 35;
  static const BoxConstraints iconWidth = BoxConstraints(minWidth: iconSpace);

  const RealStateOverview({Key key, this.propertyCard, this.ownedProperty, this.onAddHouse, this.onAddHotel, this.onMortgage, this.onSell}) : super(key: key);

  List<Widget> getPropertyRent() {
    if (propertyCard.type == property) {
      return <Widget>[
        Text('      Rent  \$${propertyCard.rent[0]}'),
        Text('With 1 House       \$${propertyCard.rent[1]}'),
        Text('With 2 Houses     \$${propertyCard.rent[2]}'),
        Text('With 3 Houses     \$${propertyCard.rent[3]}'),
        Text('With 4 Houses     \$${propertyCard.rent[4]}'),
        Text('    With HOTEL  \$${propertyCard.rent[5]}'),
        Text(''),
        Text('Houses cost \$${propertyCard.housePrice} each')
      ];
    }
    if (propertyCard.type == railroad) {
      return <Widget>[
        Text('Rent  \$${propertyCard.rent[0]}'),
        Text('With 2 R.R.s       \$${propertyCard.rent[1]}'),
        Text('With 3 R.R.s       \$${propertyCard.rent[2]}'),
        Text('With 4 R.R.s       \$${propertyCard.rent[3]}'),
      ];
    }
    if (propertyCard.type == utility) {
      return <Widget>[
        Text('Rent'),
        Text('With 1 Utility'),
        Text('${propertyCard.rent[0]} x Dice roll'),
        Text('With 2 Utilities'),
        Text('${propertyCard.rent[1]} x Dice roll'),
      ];
    }
    return [];
  }

  void showPropertyInformation(BuildContext context) {
    String propertyName = FlutterI18n.translate(context, 'property-${propertyCard.id}');

    AwesomeDialog(
        context: context,
        borderSide: BorderSide(color: propertyCard.color, width: 5),
        dialogType: DialogType.NO_HEADER,
        headerAnimationLoop: false,
        animType: AnimType.BOTTOMSLIDE,
        body: Column(
          children: [
            Text(propertyName),
            Divider(
              color: propertyCard.color,
              thickness: 2,
            ),
            ...getPropertyRent(),
            Text(''),
            Text('Mortgage value ${propertyCard.mortgageValue}'),
            Text('Price ---- ${propertyCard.purchasePrice}'),
            SizedBox(height: 8.0),
          ],
        ),)
      ..show();
  }

  void showHouseInformation(BuildContext context, { String pType, int quantity, int limit, Function addOne, Function removeOne }) {
    String propertyName = FlutterI18n.translate(context, 'property-${propertyCard.id}');

    AwesomeDialog(
      context: context,
      title: propertyName,
      desc: '$quantity ${pType}(s)',
      btnOkText: quantity >= limit ? '-' : 'Add one',
      btnCancelText: quantity == 0 ? '-' : 'Remove',
      btnCancelOnPress: removeOne,
      btnOkOnPress: addOne
    )..show();
  }

  void showPropertyExtraOptions(BuildContext context, { Function onSell, Function onMortgage }) {
    String propertyName = FlutterI18n.translate(context, 'property-${propertyCard.id}');

    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      title: propertyName,
      desc: 'Extras...',
      btnOkText: '(un) Mortgage',
      btnCancelText: 'Sell',
      btnOkColor: Colors.yellow.shade900,
      btnCancelOnPress: onSell,
      btnOkOnPress: onMortgage
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        int ownedHouses = ownedProperty.ownedHouses;
        bool isMortgaged = ownedProperty.isMortgaged;
        String propertyName = FlutterI18n.translate(context, 'property-${propertyCard.id}');

        void addOneHouse () {
          onAddHouse(propertyCard.id, 1);
          setState((){
            ownedHouses= ownedProperty.ownedHouses;
          });
        }

        void removeOneHouse () {
          onAddHouse(propertyCard.id, -1);
          setState((){
            ownedHouses= ownedProperty.ownedHouses;
          });
        }

        void addOneHotel () {
          onAddHotel(propertyCard.id, 1);
          setState((){
            ownedHouses= ownedProperty.ownedHotels;
          });
        }

        void removeOneHotel () {
          onAddHotel(propertyCard.id, -1);
          setState((){
            ownedHouses= ownedProperty.ownedHotels;
          });
        }

        void toggleMortgaged () {
          onMortgage(propertyCard.id);
          setState((){
            isMortgaged = ownedProperty.isMortgaged;
          });
        }


        return Container(
          height: 50,
          child: Card(
            child: Row(children: [
              Container(
                color: propertyCard.color,
                width: 8,
              ),
              SizedBox(width: 7.0),
              TextButton(
                  onPressed: () {
                    showPropertyInformation(context);
                  },
                  child: Text(propertyName)),
              Expanded(child: SizedBox(width: 1.0)),
              if (propertyCard.type == property) ...[
                if(ownedProperty.isMortgaged) FaIcon(FontAwesomeIcons.ban, color: Colors.cyan,),
                IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  constraints: iconWidth,
                  icon: FaIcon(
                    FontAwesomeIcons.houseUser,
                    color: isMortgaged? Colors.grey : Colors.green,
                  ),
                  onPressed: () {
                    showHouseInformation(
                        context,
                        pType: 'house',
                        quantity: ownedProperty.ownedHouses,
                        limit: 4,
                        addOne: addOneHouse,
                        removeOne: removeOneHouse
                    );
                  },
                ),
                Text('x $ownedHouses'),
                SizedBox(width: 1.0),
                Text('|'),
                IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  constraints: iconWidth,
                  icon: FaIcon(
                    FontAwesomeIcons.hotel,
                    color: isMortgaged? Colors.grey : Colors.red,
                  ),
                  onPressed: () {
                    showHouseInformation(
                        context,
                        pType: 'hotel',
                        quantity: ownedProperty.ownedHotels,
                        limit:1,
                        addOne: addOneHotel,
                        removeOne: removeOneHotel
                    );
                  },
                ),
                Text('x ${ownedProperty.ownedHotels}'),
                IconButton(
                  constraints: iconWidth,
                  iconSize: 15,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  icon: FaIcon(
                    FontAwesomeIcons.cog,
                    color: Colors.cyan.shade200,
                  ),
                  onPressed: () { showPropertyExtraOptions(context, onSell: () {onSell(propertyCard.id);}, onMortgage: toggleMortgaged); }
                ),
              ]
            ]),
          ),
        );
      }
    );
  }
}
