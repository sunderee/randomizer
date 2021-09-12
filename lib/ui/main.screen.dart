import 'package:flutter/material.dart';
import 'package:randomizer/models/randomizer.model.dart';
import 'package:randomizer/ui/widgets/players_list.widget.dart';
import 'package:randomizer/ui/widgets/results.widget.dart';
import 'package:randomizer/utils/constants/color.const.dart';
import 'package:randomizer/utils/exceptions/randomizer.exception.dart';
import 'package:randomizer/utils/helpers/randomizer.helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _playerNamesList = [];

  RandomizerModel? _randomizerResult;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.aspectRatio > 0.8
              ? 350.0
              : MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Randomizer',
                style: Typography.material2018().englishLike.headline5,
              ),
              Text(
                'Generate PUBG teams when playing rooms (up to 8 players)',
                style: Typography.material2018().englishLike.caption,
              ),
              const SizedBox(height: 24.0),
              TextField(
                controller: _controller,
                autocorrect: false,
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: colorProduct),
                  ),
                  hintText: 'Player\'s name',
                  suffix: TextButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        setState(() => _playerNamesList.add(_controller.text));
                        _controller.clear();
                      } else {
                        _showSnackbarError(
                            'You cannot use an empty player name');
                      }
                    },
                    child: const Text(
                      'ADD',
                      style: TextStyle(color: colorProduct),
                    ),
                  ),
                ),
                onSubmitted: (String value) {
                  if (value.isNotEmpty) {
                    setState(() => _playerNamesList.add(value));
                    _controller.clear();
                  } else {
                    _showSnackbarError('You cannot use an empty player name');
                  }
                },
              ),
              const SizedBox(height: 8.0),
              PlayersListWidget(
                playerNames: _playerNamesList,
                removeAtIndex: (int index) {
                  setState(() => _playerNamesList.removeAt(index));
                },
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.aspectRatio > 0.8
                    ? 350.0
                    : MediaQuery.of(context).size.width * 0.8,
                child: MaterialButton(
                  color: colorProduct,
                  child: Text(
                    'Randomize'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    try {
                      setState(() {
                        _randomizerResult = runRandomizer(_playerNamesList);
                      });
                    } on RandomizerException catch (exception) {
                      _showSnackbarError(exception.message);
                    } catch (exception) {
                      _showSnackbarError(exception.toString());
                    }
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              ResultsWidget(
                data: _randomizerResult,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackbarError(String message) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
