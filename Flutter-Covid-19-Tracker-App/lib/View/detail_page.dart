import 'package:api/View/world_states.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DetailPage extends StatefulWidget {
  dynamic image;
  String name;
  int total;
  int recovered;
  int deaths;
  int active;
  int todayCases;
  int todayDeaths;
  int todayRecovered;
  DetailPage({
    Key? key,
    required this.image,
    required this.active,
    required this.deaths,
    required this.name,
    required this.recovered,
    required this.todayCases,
    required this.todayDeaths,
    required this.todayRecovered,
    required this.total,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PieChart(
            dataMap: {
              'Total': double.parse(widget.total.toString()),
              'Recovered': double.parse(widget.recovered.toString()),
              'Deaths': double.parse(widget.deaths.toString()),
            },
            chartValuesOptions:
                ChartValuesOptions(showChartValuesInPercentage: true),
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            animationDuration: Duration(milliseconds: 1200),
            chartType: ChartType.ring,
            colorList: colorList,
          ),
          const SizedBox(height: 40),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReuseableRow(
                        title: 'Total',
                        value: widget.total.toString(),
                      ),
                      ReuseableRow(
                          title: 'Recovered',
                          value: widget.recovered.toString()),
                      ReuseableRow(
                          title: 'Deaths', value: widget.deaths.toString()),
                      ReuseableRow(
                          title: 'Active', value: widget.active.toString()),
                      ReuseableRow(
                          title: 'TodayCases',
                          value: widget.todayCases.toString()),
                      ReuseableRow(
                          title: 'TodayDeaths',
                          value: widget.todayDeaths.toString()),
                      ReuseableRow(
                          title: 'TodayRecovered',
                          value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
