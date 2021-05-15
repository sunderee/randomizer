import 'package:flutter/material.dart';

void main() => runApp(App());

const Color COLOR_PRODUCT = Color(0xFF1B5299);
const Color COLOR_PRODUCT_LIGHTER = Color(0x301B5299);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: COLOR_PRODUCT,
          accentColor: COLOR_PRODUCT,
          appBarTheme: AppBarTheme(elevation: 0.0),
        ),
        home: HomeScreen(),
      );
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Randomizer'),
      ),
      body: Padding(
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
                      height: 120.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Team #1',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 250.0,
                      height: 120.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Team #2',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 250.0,
                      height: 120.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Map, weapon, mode',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Divider(),
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
                          onTap: () => setState(() => _players.remove(player)),
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
                  print('Players: $_players');
                },
                child: Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
