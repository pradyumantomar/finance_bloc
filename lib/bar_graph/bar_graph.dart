import 'package:finance_app/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBarGraph extends StatelessWidget {
  final int? maxY;
  final int sunAmount;
  final int monAmount;
  final int tuesAmount;
  final int wedAmount;
  final int thrusAmount;
  final int friAmount;
  final int satAmount;
  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tuesAmount,
    required this.wedAmount,
    required this.thrusAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    // initialize the Bar Data
    BarData myBarData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tuesAmount: tuesAmount,
        wedAmount: wedAmount,
        thrusAmount: thrusAmount,
        friAmount: friAmount,
        satAmount: satAmount);

    myBarData.initializeBarData();

    return BarChart(BarChartData(
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: bottomTileBar,
                  reservedSize: 24)),
        ),
        maxY: maxY?.toDouble(),
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      width: 24,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY?.toDouble(),
                        color: Colors.grey[200],
                      ),
                      toY: data.y.toDouble(),
                      color: Colors.grey[800])
                ]))
            .toList()));
  }

  Widget bottomTileBar(double value, TitleMeta meta) {
    TextStyle styleFont = GoogleFonts.manrope(
      color: Colors.black,
      fontSize: 18,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = Text(
          'S',
          style: styleFont,
        );
        break;
      case 1:
        text = Text(
          'M',
          style: styleFont,
        );
        break;
      case 2:
        text = Text(
          'T',
          style: styleFont,
        );
        break;
      case 3:
        text = Text(
          'W',
          style: styleFont,
        );
        break;
      case 4:
        text = Text(
          'T',
          style: styleFont,
        );
        break;
      case 5:
        text = Text(
          'F',
          style: styleFont,
        );
        break;
      case 6:
        text = Text(
          'S',
          style: styleFont,
        );
        break;
      default:
        text = Text('', style: styleFont);
    }

    return Expanded(
        child: SideTitleWidget(axisSide: meta.axisSide, child: text));
  }
}
