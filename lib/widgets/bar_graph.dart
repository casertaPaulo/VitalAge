import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatefulWidget {
  final bool showGrid;
  final List<BarChartGroupData> bars;
  final Color cor;
  const MyBarGraph(
      {super.key,
      required this.showGrid,
      required this.bars,
      required this.cor});

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 30,
          left: widget.showGrid ? 0 : 18,
          top: 30,
        ),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.start,
            maxY: 200,
            minY: 0,
            gridData: FlGridData(
              show: widget.showGrid,
              drawVerticalLine: false,
              horizontalInterval: 30,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.shade200,
                  strokeWidth: 0.1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey.shade400,
                  strokeWidth: 0.1,
                );
              },
            ),
            borderData: FlBorderData(border: Border.all(width: 0)),
            baselineY: 0,
            groupsSpace: 45,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.white,
                tooltipPadding: const EdgeInsets.all(12.0),
                tooltipRoundedRadius: 50,
              ),
            ),
            titlesData: FlTitlesData(
              bottomTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: getBottomTiles,
                  reservedSize: 40,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: widget.showGrid,
                    getTitlesWidget: getBottomTiles,
                    reservedSize: 45),
              ),
            ),
            barGroups: widget.bars,
          ),
        ),
      ),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'RobotoCondensed');

  Widget text;

  switch (value.toInt()) {
    case > 0 && < 20000:
      String formattedValue = value.truncate().toString();
      if (formattedValue.length == 4) {
        formattedValue =
            '${formattedValue.substring(0, 2)}/${formattedValue.substring(2)}';
      }
      text = Text(formattedValue, style: style);
      break;

    default:
      text = Container(); // Atribua um widget vazio aqui.
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
