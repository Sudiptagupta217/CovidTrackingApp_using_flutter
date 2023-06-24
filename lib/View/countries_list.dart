import 'package:covid_tracker_project/Services/states_services.dart';
import 'package:covid_tracker_project/View/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with coountry name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),

              ),
            ),
            
            Expanded(child: 
            FutureBuilder(
              future: stateServices.countryListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>>snapshot) {
                if(!snapshot.hasData){
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                      child:   Column(
                        children: [
                          ListTile(
                            leading: Container(height: 10,width: 89,color: Colors.white,),
                            title: Container(height: 5,width: 70,color: Colors.white,),
                            subtitle: Container(height: 50,width: 50,color: Colors.white,),
                          )
                        ],
                      ));

                    },);;
                }else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if(searchController.text.isEmpty){
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => DetailsScreen(
                                      name: snapshot.data![index]['country'],
                                      image:snapshot.data![index]['countryInfo']['flag'] ,
                                      totalCase: snapshot.data![index]['cases'].toString(),
                                      todayCase: snapshot.data![index]['todayCases'].toString(),

                                    ),));
                              },
                              child: ListTile(
                                leading: Image(
                                  height:50.0,
                                  width: 50.0,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                              ),
                            )
                          ],
                        );
                      }
                      else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                        return Column(
                          children: [
                            ListTile(
                              leading: Image(
                                height:50.0,
                                width: 50.0,
                                image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                            )
                          ],
                        );
                      }
                      else{
                        return Container();
                      }

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => DetailsScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                  totalCase: snapshot.data![index]['cases'].toString(),
                                  todayCase: snapshot.data![index]['todayCases'].toString(),
                                ),

                                ));
                          },
                          child: ListTile(
                            leading: Image(
                              height:50.0,
                              width: 50.0,
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text(snapshot.data![index]['cases'].toString()),
                          ),
                        )
                      ],
                    );
                  },);
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
