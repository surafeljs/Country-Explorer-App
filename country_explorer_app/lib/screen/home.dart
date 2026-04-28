import 'package:country_explorer_app/models/country.dart';
import 'package:country_explorer_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Country>> futureCountries;

  @override
  void initState() {
    super.initState();
    futureCountries = ApiService().fetchCountry();

    // debugPrintCountries();
  }

  // Future<void> debugPrintCountries() async {
  //   final countries = await futureCountries;

  //   for (var c in countries) {
  //     print(c.capital);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
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
              child: Row(
                children: [
                  _filterChip("All countries", true),
                  _filterChip("Europe", false),
                  _filterChip("Asia", false),
                  _filterChip("Africa", false),
                ],
              ),
            ),

            const SizedBox(height: 20),

            FutureBuilder<List<Country>>(
              future: futureCountries,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
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
                            const SizedBox(height: 10),

                            Text(
                              country.name.common,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                Text(country.region),
                                const SizedBox(width: 10),
                                Text(country.subregion),
                              ],
                            ),

                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Capital',
                                  style: TextStyle(fontSize: 15.0),
                                ),
                                const SizedBox(width: 90),
                                FittedBox(
                                  child: Text(
                                    " ${country.capital..join(', ')}",
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
      ),
    );
  }

  Widget _filterChip(String title, bool selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF9AD872) : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
        child: Text(title),
      ),
    );
  }
}
