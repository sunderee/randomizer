import 'package:flutter/material.dart';
import 'package:randomizer/utils/constants/color.const.dart';
import 'package:randomizer/utils/exceptions/randomizer.exception.dart';
import 'package:randomizer/utils/helpers/randomizer.helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
        title: const Text('Randomizer'),
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
                                  const Text(
                                    'Team #1',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 8.0),
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
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Team #2',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 8.0),
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
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Map, mode, weapon',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 8.0),
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
                    const SizedBox(height: 56.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.66,
                      color: Colors.white,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Player\'s name',
                          suffix: TextButton(
                            onPressed: () {
                              setState(() => _players.add(_controller.text));
                              _controller.clear();
                            },
                            child: const Text(
                              'ADD',
                              style: TextStyle(color: colorProduct),
                            ),
                          ),
                        ),
                        onSubmitted: (String value) {
                          setState(() => _players.add(value));
                          _controller.clear();
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
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
                                      color: colorProductLighter,
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
                    _players.isEmpty
                        ? const SizedBox()
                        : const SizedBox(height: 24.0),
                    MaterialButton(
                      color: colorProduct,
                      elevation: 0.0,
                      onPressed: () {
                        try {
                          final data = runRandomizer(_players);
                          setState(() {
                            _firstTeam = data.teams.first.join('\n');
                            _secondTeam = data.teams.second.join('\n');
                            _gameDetails = '${data.map}\n${data.mode}\n';
                            if (data.weapon != null) {
                              _gameDetails += data.weapon ?? '';
                            }
                          });
                        } on RandomizerException catch (e) {
                          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                            SnackBar(content: Text(e.message)),
                          );
                        }
                      },
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: Text('You need a bigger aspect ratio')),
    );
  }
}
