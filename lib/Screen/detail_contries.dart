import 'package:covid_19_apps/Screen/word_state.dart';
import 'package:covid_19_apps/api_url.dart';
import 'package:covid_19_apps/widget/reuseble_row.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DetailContries extends StatelessWidget {
  DetailContries(
      {Key? key,
      this.name,
      this.Case,
      this.recovered,
      this.deaths,
      this.active,
      this.population,
      this.tests,
      this.image})
      : super(key: key);

  // int?;
  String? name, Case, recovered, deaths, image, active, tests, population;

  @override
  Widget build(BuildContext context) {
    AppUrl appUrl = new AppUrl();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name!),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PieChart(
                dataMap: {
                  'total': double.parse(Case!.toString()),
                  'Recovered': double.parse(recovered!.toString()),
                  'Deaths': double.parse(deaths!.toString()),
                },
                chartValuesOptions:
                    const ChartValuesOptions(showChartValuesInPercentage: true),
                colorList: colorList,
                animationDuration: const Duration(milliseconds: 1200),
                chartType: ChartType.ring,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                legendOptions:
                    const LegendOptions(legendPosition: LegendPosition.left),
              ),
              const SizedBox(height: 20,),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                    child: SingleChildScrollView(
                      child: Card(
                        child: Column(
                          children: [
                            ReUsebleRow(title: 'Case', value: Case),
                            ReUsebleRow(title: 'Recover', value: recovered),
                            ReUsebleRow(title: 'Deaths', value: deaths),
                            ReUsebleRow(title: 'population', value: population),
                            ReUsebleRow(title: 'active', value: active),
                            ReUsebleRow(title: 'tests', value: tests),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                      radius: 40, backgroundImage: NetworkImage(image!))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
