import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Yearly extends StatelessWidget {
  final data = [
    new SalesData(0, 1500000),
    new SalesData(1, 1735000),
    new SalesData(2, 1678000),
    new SalesData(3, 1890000),
    new SalesData(4, 1907000),
    new SalesData(5, 2300000),
    new SalesData(6, 2360000),
    new SalesData(7, 1980000),
    new SalesData(8, 2654000),
    new SalesData(9, 2789070),
    new SalesData(10, 3020000),
  ];

  _getSeriesData() {
    List<charts.Series<SalesData, int>> series = [
      charts.Series(
          id: "Sales",
          data: data,
          domainFn: (SalesData series, _) => series.year,
          measureFn: (SalesData series, _) => series.sales,
          colorFn: (SalesData series, _) =>
              charts.MaterialPalette.blue.shadeDefault)
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 34,
        ),
        SizedBox(
          height: 200,
          width: 400,
          child: charts.LineChart(
            _getSeriesData(),
            animate: true,
          ),
        ),
      ],
    );
  }
}

class Monthly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 34,
        ),
        Text("Month"),
      ],
    );
  }
}

class Weekly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 34,
        ),
        Text("Week"),
        const ListDay(),
      ],
    );
  }
}

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}

class ListDay extends StatelessWidget {
  const ListDay({Key? key}) : super(key: key);
  static List<String> products = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 600, //        <-- Use Expanded
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  products[index],
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                subtitle: const Text('25/3/2022'),
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    Container(
                      height: 42.0,
                      width: 42.0,
                      color: Colors.green,
                      alignment: Alignment.center,
                      child: const Text('A',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    Container(
                      height: 42.0,
                      width: 42.0,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: const Text('B',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    Container(
                      height: 42.0,
                      width: 42.0,
                      color: Colors.green,
                      alignment: Alignment.center,
                      child: const Text('C',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blueAccent,
                          )),
                    ),
                    Container(
                      height: 42.0,
                      width: 42.0,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: const Text('D',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blueAccent,
                          )),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
