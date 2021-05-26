import 'package:flutter/material.dart';
import 'package:real_state_game/data/properties.dart' as realStateData;

class PropertyCard {
  String id;
  String name;
  Color color;
  String type;

  int purchasePrice;
  int mortgageValue;
  int housePrice;

  List<int> rent;

  PropertyCard(List<dynamic> inputData) {
    id = inputData[0];
    name = inputData[1];
    type = inputData[2];
    color = inputData[3];

    purchasePrice = inputData[4];
    mortgageValue = inputData[5];
    housePrice = inputData[6];

    rent = inputData[7];
  }
}

// Move to a service
List<PropertyCard> propertyCards = realStateData.properties.map((e) => PropertyCard(e)).toList();
