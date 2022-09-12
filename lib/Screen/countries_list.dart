import 'package:covid_19_apps/Screen/detail_contries.dart';
import 'package:covid_19_apps/api_url.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppUrl appUrl = AppUrl();

    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextField(
                controller: controller,
                onChanged: (vallue) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search Country',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: appUrl.getContriesCovidModel(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
                                  child: Column(children: [
                                    ListTile(
                                        leading: Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.white,
                                        ),
                                        title: Container(
                                          width: double.infinity,
                                          height: 10,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          width: 80,
                                          height: 10,
                                          color: Colors.white,
                                        )),
                                    Divider()
                                  ]));
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name =
                                  snapshot.data![index]['country'].toString();
                              if (controller.text.isEmpty) {
                                return Column(
                                  children: [
                                    ListTile(
                                      contentPadding:const EdgeInsets.symmetric(horizontal: 20),
                                      //  dense: true,
                                      leading: Image(
                                          width: 50,
                                          height: 35,
                                          image: NetworkImage(snapshot
                                              .data![index]['countryInfo']
                                                  ['flag']
                                              .toString())),
                                      title: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(snapshot.data![index]
                                                ['country']
                                            .toString()),
                                      ),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailContries(
                                                      name: snapshot.data![index]['country'].toString(),
                                                      Case: snapshot.data![index]['cases'].toString(),
                                                      recovered: snapshot.data![index]['recovered'].toString(),
                                                      deaths: snapshot.data![index]['deaths'].toString(),
                                                      population: snapshot.data![index]['population'].toString(),
                                                      active: snapshot.data![index]['active'].toString(),
                                                      tests: snapshot.data![index]['tests'].toString(),
                                                      image: snapshot.data![index]['countryInfo']['flag'].toString(),

                                                    )));
                                      },
                                    ),
                                    Divider()
                                  ],
                                );
                              } else if (name
                                  .toLowerCase()
                                  .contains(controller.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Image(
                                          width: 50,
                                          height: 35,
                                          image: NetworkImage(snapshot
                                              .data![index]['countryInfo']
                                                  ['flag']
                                              .toString())),
                                      title: Text(snapshot.data![index]
                                              ['country']
                                          .toString()),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailContries(
                                                     name: snapshot.data![index]['country'].toString(),
                                                      Case: snapshot.data![index]['cases'].toString(),
                                                      recovered: snapshot.data![index]['recovered'].toString(),
                                                      deaths: snapshot.data![index]['deaths'].toString(),
                                                      population: snapshot.data![index]['population'].toString(),
                                                      active: snapshot.data![index]['active'].toString(),
                                                      tests: snapshot.data![index]['tests'].toString(),
                                                      image: snapshot.data![index]['countryInfo']['flag'].toString(),

                                                    )));
                                      },
                                    ),
                                    Divider()
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            });
                      }
                    }),
              ),
            ])
            //
            ),
      ),
    );
  }
}
