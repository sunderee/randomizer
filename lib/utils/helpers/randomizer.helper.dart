import 'dart:math';

import 'package:randomizer/models/randomizer.model.dart';
import 'package:randomizer/utils/constants/game.const.dart';
import 'package:randomizer/utils/exceptions/randomizer.exception.dart';
import 'package:randomizer/utils/tuple.dart';

RandomizerModel runRandomizer(List<String> players) {
  if (players.isEmpty || players.length > 8) {
    throw RandomizerException('Minimum one, and maximum of 8 players');
  }
  final random = Random.secure();

  final mode = random.nextBool() ? 'TPP' : 'FPP';
  final maps = List.from(allMaps);
  if (players.length % 2 != 0) {
    maps.removeAt(maps.indexOf('Domination'));
  }
  final map = maps.elementAt(random.nextInt(maps.length));

  final shuffledPlayers = players.toList()..shuffle();
  final perTeam = players.length ~/ 2;
  final teams = Tuple(
    shuffledPlayers.sublist(0, perTeam),
    shuffledPlayers.sublist(perTeam, players.length),
  );

  if ((map as String).contains('Gun Game')) {
    return RandomizerModel(teams, mode, map);
  }
  var weapon = weapons.elementAt(random.nextInt(weapons.length));
  return RandomizerModel(teams, mode, map, weapon: weapon);
}
