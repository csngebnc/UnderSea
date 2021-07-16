import 'package:flutter/material.dart';
import 'package:undersea/models/fight_outcome.dart';
import 'package:get/get.dart';
import 'lang/strings.dart';

class Constants {
  static const TOKEN = 'TOKEN';
  static const WINNER_SHOWN = 'WINNER_SHOWN';
  static const ROUND_NUM = 'ROUND_NUM';
  static const WINNER_DATE = 'WINNER_DATE';

  static const AUTH = 'Authorization';
  static const SOCKET = 'SendMessage';

  static const randomEventImageMap = {
    'Víz alatti tűz': 'assets/buildings/underwater_fire.jpg',
    'Aranybánya': 'assets/buildings/goldmine.png',
    'Rossz termés': 'assets/buildings/bad_harvest.png',
    'Elégedett emberek': 'assets/buildings/happy_people.jpg',
    'Elégedetlen emberek': 'assets/buildings/sad_people.jpg',
    'Jó termés': 'assets/buildings/happy_harvest.jpg',
    'Elégedett katonák': 'assets/buildings/happy_soldier.png',
    'Elégedetlen katonák': 'assets/buildings/angry_soldier.png',
    'Pestis': 'assets/buildings/plague.png',
  };

  static const resourceNamesMap = {
    'korall': 'coral',
    'gyöngy': 'pearl',
    'kő': 'stone'
  };

  static const buildingNameMap = {
    'Szonárágyú': 'szonaragyu',
    'Zátonyvár': 'zatonyvar',
    'Áramlásirányító': 'aramlasiranyito',
    'Kőbánya': 'stone_mine'
  };

  static const unitNameMap = {
    'Lézercápa': 'shark',
    'Rohamfóka': 'seal',
    'Csatacsikó': 'seahorse',
    'Felfedező': 'dora',
    'Hadvezér': 'obiwan'
  };
  static const upgradeNameMap = {
    'Iszaptraktor': 'iszaptraktor',
    'Iszapkombájn': 'iszapkombajn',
    'Korallfal': 'korallfal',
    'Szonárágyú': 'szonaragyu',
    'Vízalatti harcművészetek': 'vizicsillag',
    'Alkímia': 'alkimia',
  };

  static var outcomeMap = {
    FightOutcome.NotPlayedYet: Strings.in_progress.tr,
    FightOutcome.CurrentUser: Strings.victory.tr,
    FightOutcome.OtherUser: Strings.defeat.tr
  };

  static void snackbar(String title, String body) {
    return Get.snackbar(title, body,
        snackPosition: SnackPosition.TOP, backgroundColor: Colors.blueAccent);
  }
}
