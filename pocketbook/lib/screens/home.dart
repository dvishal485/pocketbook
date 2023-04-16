import 'package:flutter/material.dart';
import 'package:pocketbook/screens/analysis.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:isar/isar.dart';
import 'package:pocketbook/collections/transaction.dart';

//import 'package:pocketbook/models/classification.dart';

final expenditureDivisions = {
  for (var i = 0; i < 5; i += 1)
    dataMap[i].category: dataMap[i].averageExpenditure()
};

const APP_TITLE = "PocketBook";

class PiChart extends StatelessWidget {
  const PiChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}

class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  List<Transaction>? transactions;

  @override
  void initState() {
    super.initState;
    _readTransactions();
  }

  _readTransactions() async {
    final isar = await Isar.open([TransactionSchema]);

    //trial code to see how database works

    final trytransaction1 = Transaction()
      ..receiver = 'HDFC'
      ..amount = 999
      ..time = '16423';

    isar.writeTxn(() async {
      await isar.transactions.put(trytransaction1);
    });

    final transactionsList = isar.transactions;
    final getTransactions = await transactionsList.where().findAll();
    setState(() {
      transactions = getTransactions;
    });
  }

  List<DataRow> _buildTable() {
    List<DataRow> rows= [];
    int len = 0;
    //print(transactions);
    if (transactions != null) {
      len = transactions!.length;
    } else {
      len = 0;
    }

    for (int i = 0; i < len; i++) {
      rows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(transactions![i].id.toString())),
            DataCell(Text(transactions![i].receiver)),
            DataCell(Text(transactions![i].amount.toString())),
            DataCell(Text(transactions![i].time)),
          ],
        ),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text('Recent Transactions', 
          style: TextStyle(fontWeight: FontWeight.bold)
          ),
          DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ID',
                  ),
                ),
              ),
              DataColumn(label: Expanded(child: Text('Receiver'))),
              DataColumn(
                  label: Expanded(
                child: Text('Amount'),
              )),
              DataColumn(label: Expanded(child: Text('Time'))),
            ],
            rows: _buildTable(),
          ),
        ],
      ),
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
  void _incrementCounter() {
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
      body: ListView(children: const [PiChart(), RecentTransactions()]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'More moni',
        child: const Icon(Icons.auto_graph),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
