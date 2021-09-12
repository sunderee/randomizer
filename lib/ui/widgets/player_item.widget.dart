import 'package:flutter/material.dart';
import 'package:randomizer/utils/constants/color.const.dart';

class PlayerItemWidget extends StatelessWidget {
  final String playerName;
  final VoidCallback onRemoveCallback;

  const PlayerItemWidget({
    Key? key,
    required this.playerName,
    required this.onRemoveCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 4.0,
      ),
      child: InkWell(
        onTap: onRemoveCallback,
        child: Container(
          decoration: BoxDecoration(
            color: colorProductLighter,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(playerName),
          ),
        ),
      ),
    );
  }
}
