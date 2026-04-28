import 'package:country_explorer_app/models/country.dart';
import 'package:country_explorer_app/services/api_service.dart';
import 'package:country_explorer_app/services/region.dart';
import 'package:flutter/material.dart';

class Africa extends StatefulWidget {
  const Africa({super.key});

  @override
  State<Africa> createState() => _AfricaState();
}

class _AfricaState extends State<Africa> {
  late Future<List<Country>> futureCountries;

  @override
  void initState() {
    super.initState();
    futureCountries = Region().fetchByRegion('africa');

    // debugPrintCountries();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(),

          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 350,
              height: 160,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 22, top: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Discover Nations',
                        style: TextStyle(
                          color: Color.fromARGB(255, 6, 6, 62),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 22, top: 8),
                    child: Text(
                      'Access detailed economic, geographic, and cultural data from 195+ countries across the globe.',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search countries by name or capital',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
                 
                ],
              ),
          ),

          const SizedBox(height: 20),

          FutureBuilder<List<Country>>(
            future: futureCountries,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              final countries = snapshot.data ?? [];
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];

                  return Card(
                    elevation: 8,
                    margin: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width,
                            height: 200,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(22.0),
                                bottomLeft: Radius.circular(25.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  country.flags.png.toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          Text(
                            country.name.common,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF124170),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Row(
                            children: [
                              Text(
                                country.region,
                                style: TextStyle(
                                  fontSize: 20.0,

                                  color: Color(0xFF170C79),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                country.subregion,
                                style: TextStyle(
                                  fontSize: 15.0,

                                  color: Color(0xFF170C79),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Capital', style: TextStyle(fontSize: 15.0)),
                              const SizedBox(width: 90),
                              FittedBox(
                                child: Text(
                                  " ${country.capital.join(', ')}",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                'Currency',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              const SizedBox(width: 80),
                              Text(" ", style: TextStyle(fontSize: 18.0)),
                            ],
                          ),
                          // Text("Capital: ${country.capital.join(', ')}"),
                          // Text("Currency"),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
