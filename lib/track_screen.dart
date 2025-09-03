import 'package:covid_tracker/detials_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:covid_tracker/get_api.dart';
import 'package:shimmer/shimmer.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  Countryapi countryapi = Countryapi();
  late Future<List<dynamic>> CountryFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CountryFuture = countryapi.countryapi();
  }

  @override
  TextEditingController searchcontroller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Countries",
          style: TextStyle(
            fontFamily: "DMSerifText",
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: CountryFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.blueGrey.withOpacity(.7),
                        highlightColor: Colors.grey.withOpacity(.5),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                width: 30,
                                height: 30,
                                color: Colors.white,
                              ),
                              title: Container(
                                width: 100,
                                height: 15,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                width: 100,
                                height: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("Error :${snapshot.error}");
              } else if (!snapshot.hasData) {
                return Text("Data not loaded");
              } else {
                return Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) => {setState(() {})},
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        controller: searchcontroller,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          hint: Text(
                            "Search by country",
                            style: TextStyle(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(.8),
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]["country"]
                                .toString();
                            if (searchcontroller.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetialsScreen(
                                            active:
                                                snapshot.data![index]["active"],
                                            cases:
                                                snapshot.data![index]["cases"],
                                            country: snapshot
                                                .data![index]["country"],
                                            continent: snapshot
                                                .data![index]["continent"],
                                            deaths:
                                                snapshot.data![index]["deaths"],
                                            flag: snapshot
                                                .data![index]["countryInfo"]["flag"],
                                            recovered: snapshot
                                                .data![index]["recovered"],
                                          ),
                                        ),
                                      ),
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                          snapshot
                                              .data![index]["countryInfo"]["flag"],
                                        ),
                                      ),
                                      title: Text(
                                        snapshot.data![index]["country"]
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index]["cases"]
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                              searchcontroller.text.toLowerCase(),
                            )) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetialsScreen(
                                            active:
                                                snapshot.data![index]["active"],
                                            cases:
                                                snapshot.data![index]["cases"],
                                            country: snapshot
                                                .data![index]["country"],
                                            continent: snapshot
                                                .data![index]["continent"],
                                            deaths:
                                                snapshot.data![index]["deaths"],
                                            flag: snapshot
                                                .data![index]["countryInfo"]["flag"],
                                            recovered: snapshot
                                                .data![index]["recovered"],
                                          ),
                                        ),
                                      ),
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                          snapshot
                                              .data![index]["countryInfo"]["flag"],
                                        ),
                                      ),
                                      title: Text(
                                        snapshot.data![index]["country"]
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index]["cases"]
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
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
    );
  }
}
