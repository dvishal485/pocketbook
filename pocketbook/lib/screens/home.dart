import 'package:flutter/material.dart';
import 'package:pocketbook/screens/analysis.dart';
import 'package:pie_chart/pie_chart.dart';
//import 'package:pocketbook/models/classification.dart';

final expenditureDivisions = {
  for (var i = 0; i < 5; i += 1)
    dataMap[i].category: dataMap[i].averageExpenditure()
};

class PiChart extends StatelessWidget {
  const PiChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnalysisScreen(),
                  settings: const RouteSettings(name: 'AnalysisScreen'),
                ),
              );
            },
            child: PieChart(
              dataMap: expenditureDivisions,
              legendOptions: const LegendOptions(
                showLegends: true,
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValues: true,
              ),
            ),
          ),
        ),
        const Card(
          child: Center(child: Text('Recent transactions here')),
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
      body: const PiChart(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'More moni',
        child: const Icon(Icons.auto_graph),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
