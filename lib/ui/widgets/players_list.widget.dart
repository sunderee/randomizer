import 'package:flutter/material.dart';
import 'package:randomizer/ui/widgets/player_item.widget.dart';
import 'package:randomizer/utils/iterable.ext.dart';

class PlayersListWidget extends StatefulWidget {
  final List<String> playerNames;
  final Function(int) removeAtIndex;

  const PlayersListWidget({
    Key? key,
    required this.playerNames,
    required this.removeAtIndex,
  }) : super(key: key);

  @override
  State<PlayersListWidget> createState() => _PlayersListWidgetState();
}

class _PlayersListWidgetState extends State<PlayersListWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      children: widget.playerNames
          .mapIndexed((String name, int index) => PlayerItemWidget(
                playerName: name,
                onRemoveCallback: () {
                  setState(() {
                    widget.playerNames.removeAt(index);
                  });
                },
              ))
          .toList(),
    );
  }
}
