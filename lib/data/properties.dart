import 'package:flutter/material.dart';

// name, type, color, price, mortgage, rent [alone, monopoly|2stations, 1house|3stations, 2house|4stations, 3house, hotel], housePrice
// {name, type, color, price, mortgage, housePrice, rent<int[]>}
const String id = 'id';
const String name = 'name';
const String type = 'type';
const String color = 'color';
const String price = 'price';
const String mortgage = 'mortgage';
const String rent = 'rent';
const String housePrice = 'housePrice';
const String property = 'property';
const String railroad = 'railroad';
const String utility = 'utility';
const properties = [
  // { id: 'mediterranean_avenue', name: 'Mediterranean Avenue', type: 'property', color: Colors.brown, price: 60, mortgage: 30, housePrice: 50, rent: <int>[2, 4, 10, 30, 90, 160, 250]},
  //{ id: 'baltic_avenue', name: 'Baltic Avenue', type: 'property', color: Colors.brown, price: 60, mortgage: 30, housePrice: 50, rent: <int>[4, 8, 20, 60, 180, 320, 450]},
  [ 'mediterranean_avenue', 'Mediterranean Avenue', property, Colors.brown, 60, 30, 50, [2, 4, 10, 30, 90, 160, 250]],
  [ 'baltic_avenue', 'Baltic Avenue', property, Colors.brown, 60, 30, 50, [4, 8, 20, 60, 180, 320, 450]],
  [ 'oriental_avenue', 'Oriental Avenue', 'property', Colors.lightBlue, 100, 50, 50, [6, 12, 30, 90, 270, 400, 550]],
  [ 'vermont_avenue', 'Vermont Avenue', 'property', Colors.lightBlue, 100, 50, 50, [6, 12, 30, 90, 270, 400, 550]],
  [ 'connecticut_avenue', 'Connecticut Avenue', 'property', Colors.lightBlue, 120, 60, 50, [8,16,40,100,300,450,600]],
//  [ 'maryland_avenue', 'Maryland Avenue', 'property', Colors.pink, 140, 70, 100, [10,30,50, 150, 450, 625, 750]],
  [ 'St_Charles_Place', 'St. Charles Place', 'property', Colors.pink, 140, 70, 100, [10,20,50,150,450,625,750]],
  [ 'States_Avenue', 'States Avenue', 'property', Colors.pink, 140, 70, 100, [10,20,50,150,450,625,750]],
  [ 'Virginia_Avenue', 'Virginia Avenue', 'property', Colors.pink, 160, 80, 100, [12, 24,60,180,500,700,900]],
  [ 'St_James_Place', 'St. James Place', 'property', Colors.orange, 180, 90, 100, [14,28,70,200,550,750,950]],
  [ 'Tennessee_Avenue', 'Tennessee Avenue', 'property', Colors.orange, 180, 90, 100, [14,28,70,200,550,750,950]],
  [ 'New_York_Avenue', 'New York Avenue', property, Colors.orange, 200, 100, 100, [16,32,80,220,600,800,1000]],
  [ 'Kentucky_Avenue', 'Kentucky Avenue', property, Colors.red, 220, 110, 150, [18,36,90,250,700,875,1050]],
  [ 'Indiana_Avenue', 'Indiana Avenue', property, Colors.red, 220, 110, 150, [18,36,90,250,700,875,1050]],
  [ 'Illinois_Avenue', 'Illinois Avenue', property, Colors.red, 240, 120, 150, [20,40,100,300,750,925,1100]],
  // [ 'Michigan_avenue', 'Michigan Avenue', property, Colors.red],
  [ 'Atlantic_Avenue', 'Atlantic Avenue', property, Colors.yellow, 260, 130, 150, [22,44,110,330,800,975,1150]],
  [ 'Ventnor_Avenue', 'Ventnor Avenue', property, Colors.yellow, 260, 130, 150, [22,44,110,330,800,975,1150]],
  [ 'Marvin_Gardens', 'Marvin Gardens', property, Colors.yellow, 280, 140, 150, [24,48,120,360,850,1025,1200]],
  // [ 'California_Avenue', ' California Avenue ', property, Colors.yellow],
  [ 'Pacific_Avenue', 'Pacific Avenue', property, Colors.green, 300, 150, 200, [26,52,130,390,900,1100,1275]],
  // [ 'South_Carolina_Avenue', 'South Carolina Avenue', property, Colors.green]
  [ 'North_Carolina_Avenue', 'North Carolina Avenue', property, Colors.green, 300, 150, 200, [26,52,130,360,900,1100,1275]],
  [ 'Pennsylvania_Avenue', 'Pennsylvania Avenue', property, Colors.green, 320, 160, 200, [28,56,150,450,1000,1200,1400]],
  [ 'Park_Place', 'Park Place', property, Colors.blue, 350, 175, 200, [35,70,175,500,1100,1300,1500]],
  [ 'Boardwalk', 'Boardwalk', property, Colors.blue, 400, 200, 200, [50,100,200,600,1400,1700,2000]],
  [ 'Reading_Railroad', 'Reading Railroad', railroad, Colors.grey, 200, 100, 0, [25,50,100,200]],
  [ 'Pennsylvania_Railroad', 'Pennsylvania Railroad', railroad, Colors.grey, 200, 100, 0, [25,50,100,200]],
  [ 'BandO_Railroad', 'B & O Railroad', railroad, Colors.grey, 200, 100, 0, [25,50,100,200]],
  [ 'ShortLine_Railroad', 'Short Line', railroad, Colors.grey, 200, 100, 0, [25,50,100,200]],
  [ 'Electric_Company', 'Electric Company', utility, Colors.purple, 150, 75, 0, [4, 10]],
  [ 'Water_Works', 'Water Works', utility, Colors.purple, 150, 75, 0, [4, 10]],
];