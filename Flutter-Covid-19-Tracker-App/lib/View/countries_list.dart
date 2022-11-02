import 'package:api/View/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/states_services.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  StatesServices statesServices = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                hintText: 'Search Country',
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(children: [
                                ListTile(
                                  title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white),
                                  subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white),
                                  leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white),
                                )
                              ]));
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                          active: snapshot.data![index]
                                              ['active'],
                                          deaths: snapshot.data![index]
                                              ['deaths'],
                                          name: snapshot.data![index]
                                              ['country'],
                                          recovered: snapshot.data![index]
                                              ['recovered'],
                                          todayCases: snapshot.data![index]
                                              ['todayCases'],
                                          todayDeaths: snapshot.data![index]
                                              ['todayDeaths'],
                                          todayRecovered: snapshot.data![index]
                                              ['todayRecovered'],
                                          total: snapshot.data![index]['cases'],
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                        ),
                                      ));
                                },
                                child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']))),
                              )
                            ]);
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                          active: snapshot.data![index]
                                              ['active'],
                                          deaths: snapshot.data![index]
                                              ['deaths'],
                                          name: snapshot.data![index]
                                              ['country'],
                                          recovered: snapshot.data![index]
                                              ['recovered'],
                                          todayCases: snapshot.data![index]
                                              ['todayCases'],
                                          todayDeaths: snapshot.data![index]
                                              ['todayDeaths'],
                                          todayRecovered: snapshot.data![index]
                                              ['todayRecovered'],
                                          total: snapshot.data![index]['cases'],
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                        ),
                                      ));
                                },
                                child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']))),
                              )
                            ]);
                          } else {
                            return Container();
                          }
                        });
                  }
                }),
          )
        ]),
      ),
    );
  }
}
