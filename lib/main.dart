import 'package:flutter/material.dart';
import 'CoreFlow.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CounterApp();
  }
}

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _updateCounter(int newCounter) {
    setState(() {
      _counter = newCounter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CoreFlow<int>(
      state: _counter,
      update: _updateCounter,
      child: MaterialApp(
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coreFlow = CoreFlow.of<int>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Counter App')),
      body: Center(
        child: Text(
          'Counter: ${coreFlow.state}',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => coreFlow.update(coreFlow.state + 1),
        child: Icon(Icons.add),
      ),
    );
  }
}
