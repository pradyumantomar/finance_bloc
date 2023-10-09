import 'package:finance_app/bar_graph/individual_graph_model.dart';

class BarData {
  final int sunAmount;
  final int monAmount;
  final int tuesAmount;
  final int wedAmount;
  final int thrusAmount;
  final int friAmount;
  final int satAmount;

  BarData(
      {required this.sunAmount,
      required this.monAmount,
      required this.tuesAmount,
      required this.wedAmount,
      required this.thrusAmount,
      required this.friAmount,
      required this.satAmount});

  List<IndividualGraph> barData = [];

  //initialize bar data
  void initializeBarData() {
    barData = [
      IndividualGraph(x: 0, y: sunAmount),
      IndividualGraph(x: 1, y: monAmount),
      IndividualGraph(x: 2, y: tuesAmount),
      IndividualGraph(x: 3, y: wedAmount),
      IndividualGraph(x: 4, y: thrusAmount),
      IndividualGraph(x: 5, y: friAmount),
      IndividualGraph(x: 6, y: satAmount),
    ];
  }
}
