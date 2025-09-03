import 'package:covid_tracker/get_api.dart';
import 'package:covid_tracker/track_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> {
  GetApi getApi = GetApi();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            FutureBuilder(
              future: getApi.getapi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: SpinKitCircle(color: Colors.white, size: 70),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error :{$snapshot.error}");
                } else if (!snapshot.hasData) {
                  return Text("Error in loading data");
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        PieChart(
                          dataMap: {
                            "Total": double.parse(
                              snapshot.data!.cases!.toString(),
                            ),
                            "Recovered": double.parse(
                              snapshot.data!.recovered!.toString(),
                            ),
                            "Deaths": double.parse(
                              snapshot.data!.deaths!.toString(),
                            ),
                          },
                          animationDuration: Duration(milliseconds: 800),
                          chartType: ChartType.ring,
                          ringStrokeWidth: 15,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          legendOptions: LegendOptions(
                            legendPosition: LegendPosition.right,
                            legendTextStyle: TextStyle(
                              fontFamily: "DMSerifText",
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            decimalPlaces: 2,
                            chartValueStyle: TextStyle(
                              fontFamily: "DMSerifText",
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          colorList: [
                            Colors.blueAccent,
                            Colors.green,
                            Colors.redAccent,
                          ],
                        ),
                        SizedBox(height: 50),
                        Card(
                          color: Colors.black,
                          child: Column(
                            children: [
                              reuseable(
                                title: "Active",
                                value: snapshot.data!.active!.toString(),
                              ),
                              Divider(),
                              reuseable(
                                title: "Critical",
                                value: snapshot.data!.critical!.toString(),
                              ),
                              Divider(),
                              reuseable(
                                title: "Updated",
                                value: snapshot.data!.updated!.toString(),
                              ),
                              Divider(),
                              reuseable(
                                title: "Tests",
                                value: snapshot.data!.tests!.toString(),
                              ),
                              Divider(),
                              reuseable(
                                title: "Population",
                                value: snapshot.data!.population!.toString(),
                              ),
                              Divider(),
                              reuseable(
                                title: "Affected Countries",
                                value: snapshot.data!.affectedCountries!
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrackScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 70,
                            width: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black,
                              border: BoxBorder.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Track Countries",
                                style: TextStyle(
                                  fontFamily: "DMSerifText",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class reuseable extends StatefulWidget {
  final String title, value;
  const reuseable({required this.title, required this.value, super.key});

  @override
  State<reuseable> createState() => _reuseableState();
}

class _reuseableState extends State<reuseable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: "DMSerifText",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            widget.value,
            style: TextStyle(
              fontFamily: "DMSerifText",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
