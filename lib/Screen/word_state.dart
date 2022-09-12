import 'package:covid_19_apps/api_url.dart';
import 'package:covid_19_apps/Screen/countries_list.dart';
import 'package:covid_19_apps/model/covid_model.dart';
import 'package:covid_19_apps/widget/reuseble_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

final colorList = [
    const Color(0xff4285f4),
    const Color(0xff1aa268),
    const Color(0xffde5246)
  ];
class WordState extends StatefulWidget {
  const WordState({Key? key}) : super(key: key);

  @override
  State<WordState> createState() => _WordStateState();
}

// ickerProviderStateMixin
class _WordStateState extends State<WordState> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  
  @override
  Widget build(BuildContext context) {
    CovidModel covidModel = CovidModel();
    AppUrl appUrl = AppUrl();

    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: appUrl.getAllCovidModel(),
                      builder: (context, AsyncSnapshot<CovidModel> snapshot) {
                        if (!snapshot.hasData) {
                          return const Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return Column(children: [
                            PieChart(
                              dataMap: {
                                'total': double.parse(
                                    snapshot.data!.cases!.toString()),
                                'Recovered': double.parse(
                                    snapshot.data!.recovered.toString()),
                                'Deaths': double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              colorList: colorList,
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReUsebleRow(
                                      title: 'totol Cases',
                                      value: snapshot.data!.cases.toString(),
                                    ),
                                    ReUsebleRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    ReUsebleRow(
                                      title: 'Recover',
                                      value: snapshot.data!.recovered.toString(),
                                    ),
                                    ReUsebleRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString(),
                                    ),
                                    ReUsebleRow(
                                      title: 'Critical',
                                      value: snapshot.data!.critical.toString(),
                                    ),
                                    ReUsebleRow(
                                      title: 'TodayDeaths',
                                      value:
                                          snapshot.data!.todayDeaths.toString(),
                                    ),
                                    //  ReUsebleRow(title: 'TodayRecovered', value:  snapshot.data!.todayRecovered.toString(),)
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountriesList()));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xff1aa268),
                                    borderRadius: BorderRadius.circular(10)),
                                child:
                                    const Center(child: Text('Track Contries')),
                              ),
                            )
                          ]);
                        }
                      }),
                )
              ],
            )),
      ),
    );
  }
}
