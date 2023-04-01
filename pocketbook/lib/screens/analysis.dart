import 'package:flutter/material.dart';
import 'package:pocketbook/models/classification.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<ExpenditureCategory> dataMap = [
  ExpenditureCategory(
      "Grocery",
      [
        ExpenditureData("Jan", 35),
        ExpenditureData("Feb", 28),
        ExpenditureData("Mar", 34),
        ExpenditureData("Apr", 32),
        ExpenditureData("May", 40)
      ],
      Colors.red),
  ExpenditureCategory(
      "Entertainment",
      [
        ExpenditureData("Jan", 20),
        ExpenditureData("Feb", 25),
        ExpenditureData("Mar", 22),
        ExpenditureData("Apr", 25),
        ExpenditureData("May", 21)
      ],
      Colors.amber),
  ExpenditureCategory(
      "Medical",
      [
        ExpenditureData("Jan", 50),
        ExpenditureData("Feb", 35),
        ExpenditureData("Mar", 39),
        ExpenditureData("Apr", 14),
        ExpenditureData("May", 31)
      ],
      Colors.cyan),
  ExpenditureCategory(
      "Travel",
      [
        ExpenditureData("Jan", 45),
        ExpenditureData("Feb", 32),
        ExpenditureData("Mar", 44),
        ExpenditureData("Apr", 27),
        ExpenditureData("May", 33)
      ],
      Colors.green),
  ExpenditureCategory(
      "Clothing",
      [
        ExpenditureData("Jan", 15),
        ExpenditureData("Feb", 18),
        ExpenditureData("Mar", 16),
        ExpenditureData("Apr", 19),
        ExpenditureData("May", 17)
      ],
      Colors.indigo),
];

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis'),
        actions: [
          IconButton(
              onPressed: () => {print("ToDo : Link Profile page")},
              icon: const Icon(Icons.person))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75))
              ],
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.black)))),
              onPressed: () {
                print("somethng happendd");
              },
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SfCartesianChart(
                      onChartTouchInteractionUp: (tapArgs) {
                        print("hey, its a single tap on chart card");
                      },
                      title: ChartTitle(text: "moniii blossom expenditure"),
                      primaryXAxis: CategoryAxis(),
                      legend: Legend(isVisible: true),
                      series: <SplineSeries<ExpenditureData, String>>[
                        // widget builder from list dataMap using loop
                        for (var i = 0; i < dataMap.length; i++)
                          SplineSeries<ExpenditureData, String>(
                            name: dataMap[i].category,
                            dataSource: dataMap[i].expenditureData,
                            color: dataMap[i].color,
                            xValueMapper: (ExpenditureData data, _) =>
                                data.month,
                            yValueMapper: (ExpenditureData data, _) =>
                                data.expenditure,
                          )
                      ])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(18),
              ),
              margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                for (var i = 0; i < dataMap.length; i++)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.circle,
                                color: dataMap[i].color,
                                size: 12.0,
                              )),
                        ),
                        Text(dataMap[i].category),
                      ]),
                      Icon(dataMap[i].averageExpenditure() > 30
                          ? Icons.emoji_emotions
                          : Icons.dangerous),
                    ],
                  ),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
