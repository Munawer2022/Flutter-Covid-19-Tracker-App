import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/world_states_model.dart';
import '../Services/states_services.dart';
import 'countries_list.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          FutureBuilder(
              future: statesServices.fecthWorldStatesRecords(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                      controller: _controller,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          'Total':
                              double.parse(snapshot.data!.cases!.toString()),
                          'Recovered': double.parse(
                              snapshot.data!.recovered!.toString()),
                          'Deaths':
                              double.parse(snapshot.data!.deaths!.toString()),
                        },
                        chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        animationDuration: Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .06),
                        child: Card(
                          child: Column(
                            children: [
                              ReuseableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases!.toString()),
                              ReuseableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered!.toString()),
                              ReuseableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths!.toString()),
                              ReuseableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active!.toString()),
                              ReuseableRow(
                                  title: 'TodayCases',
                                  value: snapshot.data!.todayCases!.toString()),
                              ReuseableRow(
                                  title: 'TodayDeaths',
                                  value:
                                      snapshot.data!.todayDeaths!.toString()),
                              ReuseableRow(
                                  title: 'TodayRecovered',
                                  value: snapshot.data!.todayRecovered!
                                      .toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CountriesList(),
                              ));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff1aa260),
                          ),
                          child: const Center(child: Text('Track Countires')),
                        ),
                      ),
                    ],
                  );
                }
              })
        ]),
      ),
    ));
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title),
            Text(value),
          ]),
        ],
      ),
    );
  }
}
