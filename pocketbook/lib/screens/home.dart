import 'package:flutter/material.dart';
import 'package:pocketbook/screens/analysis.dart';
import 'package:pie_chart/pie_chart.dart';

Map<String, double> fakedataMap = {
  "Flutter": 5,
  "React": 3,
  "Xamarin": 2,
  "Ionic": 2,
};

class FakePiChart extends StatelessWidget {
  const FakePiChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.5,
            child: PieChart(
              dataMap: fakedataMap,
              legendOptions: const LegendOptions(
                showLegends: false,
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValues: false,
              ),
            ),
          ),
        ),
        const Card(
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(child: Text('Recent transactions here')),
          ),
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AnalysisScreen(),
        settings: const RouteSettings(name: 'AnalysisScreen'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FakePiChart(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'More moni',
        child: const Icon(Icons.auto_graph),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
