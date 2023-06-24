import 'package:covid_tracker_project/Models/World_state_model.dart';
import 'package:covid_tracker_project/Services/states_services.dart';
import 'package:covid_tracker_project/View/countries_list.dart';
import 'package:covid_tracker_project/Widget/reusable_row.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{
  late final AnimationController _container =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..forward();

  @override
  void dispose() {
    super.dispose();
    _container.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            FutureBuilder(
              future: stateServices.fetchWorldStatesRecords(),
              builder: (context,AsyncSnapshot<WorldStateModel> snapshot) {
              if(!snapshot.hasData){
                 return Expanded(
                     flex: 1,
                     child: SpinKitFadingCircle(
                       color: Colors.white,
                       size: 50,
                       controller: _container,

                     ));
              } else{
                return Column(
                  children: [
                    PieChart(dataMap: {
                      "Total":double.parse(snapshot.data!.cases!.toString()),
                      "Recover":double.parse(snapshot.data!.recovered!.toString()),
                      "Deaths":double.parse(snapshot.data!.deaths!.toString()),
                    },
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true
                      ),
                      chartRadius: MediaQuery.of(context).size.width/3.2,
                      legendOptions: LegendOptions(
                          legendPosition: LegendPosition.left
                      ),
                      animationDuration: const Duration(milliseconds: 1200),
                      chartType: ChartType.ring,
                      colorList: colorList,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 10,bottom: 5,left: 10,right: 10),
                      child: Card(
                          child: Column(
                            children: [
                              ReusableRow(title: "Total",value: snapshot.data!.cases.toString(),),
                              ReusableRow(title: "Recover",value: snapshot.data!.recovered.toString(),),
                              ReusableRow(title: "Active",value: snapshot.data!.active.toString(),),
                              ReusableRow(title: "Death",value: snapshot.data!.deaths.toString(),),
                              ReusableRow(title: "Toady Recover",value: snapshot.data!.todayRecovered.toString(),),
                              ReusableRow(title: "Toady New Case",value: snapshot.data!.todayCases.toString(),),
                              ReusableRow(title: "Toady Death",value: snapshot.data!.todayDeaths.toString(),),
                            ],
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen(),));
                       },
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        height: 50,
                        width: MediaQuery.of(context).size.width*0.9,
                        decoration: BoxDecoration(
                            color: const Color(0xff1aa260),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(child: Text("Track Countries")),
                      ),
                    )
                  ],
                );
              }
            },),


            ],
          ),
        ),


      ),
    );
  }
}
