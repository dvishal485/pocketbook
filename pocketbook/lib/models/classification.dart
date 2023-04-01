import 'package:flutter/material.dart';

class ExpenditureData {
  ExpenditureData(this.month, this.expenditure);
  final String month;
  final double expenditure;
}

class ExpenditureCategory {
  ExpenditureCategory(this.category, this.expenditureData, this.color);
  final String category;
  final List<ExpenditureData> expenditureData;
  final Color color;

  double averageExpenditure() {
    double sum = 0;
    for (var i = 0; i < expenditureData.length; i++) {
      sum += expenditureData[i].expenditure;
    }
    return sum / expenditureData.length;
  }
}
