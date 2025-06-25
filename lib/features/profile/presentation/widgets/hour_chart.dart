import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HourChart extends StatelessWidget {
  const HourChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 5,
                getTitlesWidget: (value, _) {
                  return Text('${value.toInt()} h',
                      style: const TextStyle(fontSize: 10));
                },
              ),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 13,
          minY: 0,
          maxY: 25,
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: const Color(0xFF704C24),
              barWidth: 1,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFC49A6C).withValues(alpha: 0.9),
                    const Color(0xFFC49A6C).withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              spots: const [
                FlSpot(0, 20),
                FlSpot(1, 21),
                FlSpot(2, 22),
                FlSpot(3, 23), // highlighted
                FlSpot(4, 21),
                FlSpot(5, 19),
                FlSpot(6, 22),
                FlSpot(7, 23),
                FlSpot(8, 20),
                FlSpot(9, 21),
                FlSpot(10, 22),
                FlSpot(11, 21),
                FlSpot(12, 20),
                FlSpot(13, 19),
              ],
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  if (spot.x == 3) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Colors.green,
                      strokeWidth: 0,
                    );
                  }
                  return FlDotCirclePainter(
                    radius: 3,
                    color: Colors.transparent,
                    strokeWidth: 0,
                  );
                },
              ),
            )
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (c) => Colors.white,
              tooltipBorder: const BorderSide(color: Colors.green),
              getTooltipItems: (touchedSpots) => touchedSpots.map((touched) {
                return LineTooltipItem(
                  '${touched.y.toInt()} h',
                  const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
            touchCallback: (_, __) {},
            handleBuiltInTouches: true,
          ),
        ),
      ),
    );
  }
}
