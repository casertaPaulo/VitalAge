import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyBarGraph extends StatefulWidget {
  final List<BarChartGroupData> bars;
  final Color cor;
  const MyBarGraph({super.key, required this.bars, required this.cor});

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.start,
            maxY: 250,
            minY: 5,
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(border: Border.all(width: 0)),
            baselineY: 5,
            groupsSpace: 30,
            titlesData: const FlTitlesData(
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true, getTitlesWidget: getBottomTiles)),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: false, getTitlesWidget: getBottomTiles))),
            barGroups: widget.bars,
          ),
        ),
      ),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold);

  Widget text;

  switch (value.toInt()) {
    case > 0 && < 100:
      text = Text("${value.truncate()}", style: style);
      break;

    default:
      text = Container(); // Atribua um widget vazio aqui.
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
