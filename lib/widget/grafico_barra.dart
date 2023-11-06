import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



Widget dibujaGrafico(double temperatura, double hora) {
  return LineChart(
    LineChartData(
      titlesData: FlTitlesData(
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (_ ,value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            if (value == 25) return '25°C';
            if (value == 30) return '30°C';
            return '';
          },
          margin: 12,
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (_,value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            return hora.toString() + ':00 AM';
          },
          margin: 8,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: const Color(0xff37434d),
          width: 1,
        ),
      ),
      minX: 1,
      maxX: 2,
      minY: 25,
      maxY: 30,
      gridData: FlGridData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, temperatura),
          ],
          isCurved: true,
          colors: [Colors.blue],
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    ),
  );
}
