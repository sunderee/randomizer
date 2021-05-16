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

  var mode = random.nextBool() ? 'TPP' : 'FPP';
  var map = MAPS.elementAt(random.nextInt(MAPS.length));
  if (map == 'Gun Game (Library)') {
    return RandomizerModel(
      _generateTeams(players, random),
      mode,
      map,
    );
  }

  var weapon = WEAPONS.elementAt(random.nextInt(WEAPONS.length));
  return RandomizerModel(
    _generateTeams(players, random),
    mode,
    map,
    weapon: weapon,
  );
}

Tuple<List<String>, List<String>> _generateTeams(
  List<String> players,
  Random randomInstance,
) {
  var shuffledPlayers = players.toList()..shuffle();
  var perTeam = players.length ~/ 2;
  return Tuple(
    shuffledPlayers.sublist(0, perTeam),
    shuffledPlayers.sublist(perTeam, players.length),
  );
}
