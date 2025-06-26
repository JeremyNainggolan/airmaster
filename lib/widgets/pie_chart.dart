import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class LegendPieChart extends StatelessWidget {
  final List<Map<String, Map<String, dynamic>>> data;
  const LegendPieChart({super.key, required this.data});

  Map<String, double> getDataMap() {
    final Map<String, double> result = {};
    for (var item in data) {
      final key = item.keys.first;
      final value = item[key]!['total'].toDouble();
      result[key] = value;
    }
    return result;
  }

  List<Color> getColorList() {
    return data
        .map(
          (item) => Color(
            int.parse(
                  item[item.keys.first]!['color'].toString().substring(1, 7),
                  radix: 16,
                ) +
                0xFF000000,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: getDataMap(),
      colorList: getColorList(),
      chartType: ChartType.disc,
      formatChartValues: (value) {
        return value.toStringAsFixed(0);
      },
      chartRadius: MediaQuery.of(context).size.width / 2.2,
      legendOptions: LegendOptions(showLegends: false),
      chartValuesOptions: const ChartValuesOptions(showChartValues: true),
    );
  }
}
