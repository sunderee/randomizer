import 'package:flutter/material.dart';
import 'package:randomizer/utils/constants/color.const.dart';
import 'package:randomizer/utils/exceptions/randomizer.exception.dart';
import 'package:randomizer/utils/helpers/randomizer.helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _players = [];

  String _firstTeam = 'No players';
  String _secondTeam = 'No players';
  String _gameDetails = 'No details';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Randomizer'),
      ),
      body: MediaQuery.of(context).size.aspectRatio >= 1.37
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 128.0),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: Container(
                            width: 250.0,
                            height: 150.0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Team #1',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 8.0),
                                  Text(
                                    _firstTeam,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            width: 250.0,
                            height: 150.0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Team #2',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 8.0),
                                  Text(
                                    _secondTeam,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            width: 250.0,
                            height: 150.0,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Map, mode, weapon',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 8.0),
                                  Text(
                                    _gameDetails,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 56.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.66,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Player\'s name',
                          suffix: TextButton(
                            onPressed: () {
                              setState(() => _players.add(_controller.text));
                              _controller.clear();
                            },
                            child: Text(
                              'ADD',
                              style: TextStyle(color: COLOR_PRODUCT),
                            ),
                          ),
                        ),
                        onSubmitted: (String value) {
                          setState(() => _players.add(value));
                          _controller.clear();
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: _players
                          .map((String player) => GestureDetector(
                                onTap: () => setState(
                                  () => _players.remove(player),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: COLOR_PRODUCT_LIGHTER,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(player),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    _players.isEmpty ? SizedBox() : SizedBox(height: 24.0),
                    MaterialButton(
                      color: COLOR_PRODUCT,
                      elevation: 0.0,
                      onPressed: () {
                        try {
                          final data = runRandomizer(_players);
                          setState(() {
                            _firstTeam = data.teams.first.join('\n');
                            _secondTeam = data.teams.second.join('\n');
                            _gameDetails = '${data.map}\n${data.mode}\n';
                            if (data.weapon != null) {
                              _gameDetails += '${data.weapon}';
                            }
                          });
                        } on RandomizerException catch (e) {
                          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                            SnackBar(content: Text(e.message)),
                          );
                        }
                      },
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(child: Text('You need a bigger aspect ratio')),
    );
  }
}
