import 'package:randomizer/utils/tuple.dart';

class RandomizerModel {
  final Tuple<List<String>, List<String>> teams;
  final String mode;
  final String map;
  final String? weapon;

  const RandomizerModel(
    this.teams,
    this.mode,
    this.map, {
    this.weapon,
  });
}
