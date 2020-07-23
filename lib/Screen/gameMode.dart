
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameMode {
  int id;
  String gameMode;

  GameMode({this.id, this.gameMode});
  static List<GameMode> getMode() {
    return <GameMode>[
      GameMode(id: 1, gameMode:"FOREST"),
      GameMode(id: 2, gameMode:"MOUNTAIN"),
      GameMode(id: 3, gameMode:"DESERT"),
      GameMode(id: 4, gameMode:"RANDOM"),
    ];
  }



}

class TankColor
{
  int colorId;
  Color color;
  bool selectedColor;
  String colorName;
  TankColor({this.colorId,this.colorName,this.selectedColor,this.color});

  static List<TankColor> getColors() {
    return <TankColor>[
      TankColor(colorId:1,selectedColor:true,colorName: "green",color: Colors.green),
      TankColor(colorId:2,selectedColor:true,colorName: "amber",color: Colors.amber),
      TankColor(colorId:3,selectedColor:true,colorName: "yellow",color: Colors.yellow),
      TankColor(colorId:4,selectedColor:true,colorName: "pink",color: Colors.pink),
      TankColor(colorId:5,selectedColor:true,colorName: "brown",color: Colors.brown),
      TankColor(colorId:6,selectedColor:true,colorName: "blue",color: Colors.blue),
    ];
  }
}

class PlayerDetails{

  int noOfPlayer;
  String playerName;
  int selectedMode;
  String selectedTankColor;
  Map<String,String> playerDetails = {};

  PlayerDetails(){
    this.noOfPlayer = 2;
    this.selectedMode = 4;
    this.playerName = "";
  }


  void addPlayer(String playerName,String tankColor)
  {
    playerDetails[tankColor] = playerName;
  }
}

