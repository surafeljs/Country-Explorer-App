import 'package:country_explorer_app/models/country.dart';
import 'package:country_explorer_app/screen/africa.dart';
import 'package:country_explorer_app/screen/asia.dart';
import 'package:country_explorer_app/screen/detail_screen..dart';
import 'package:country_explorer_app/screen/europe.dart';
import 'package:country_explorer_app/services/api_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Country>> futureCountries;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureCountries = ApiService().fetchCountry();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });

    // debugPrintCountries();
  }

  // Future<void> debugPrintCountries() async {
  //   final countries = await futureCountries;

  //   for (var c in countries) {
  //     print(c.capital);
  //   }
  // }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;

  List<Country> _filterCountries(List<Country> countries) {
    if (_searchQuery.isEmpty) {
      return countries;
    }

    final query = _searchQuery.toLowerCase();
    return countries.where((country) {
      final name = country.name.common.toLowerCase();
      final capital = country.capital.isNotEmpty
          ? country.capital[0].toLowerCase()
          : '';
      final region = country.region.toLowerCase();
      final subregion = country.subregion.toLowerCase();

      return name.contains(query) ||
          capital.contains(query) ||
          region.contains(query) ||
          subregion.contains(query);
    }).toList();
  }

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
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search countries by name or capital',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                ),
              ),
            ),

            const SizedBox(height: 25),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,

                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('All Continents'),
                    ),
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),

                  const SizedBox(width: 10),

                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Africa'),
                    ),
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                  ),
                  const SizedBox(width: 10),

                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Asia'),
                    ),
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                  ),
                  const SizedBox(width: 10),

                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Europe'),
                    ),
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            IndexedStack(
              index: _currentIndex,
              children: [
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
                    final filteredCountries = _filterCountries(countries);

                    return filteredCountries.isEmpty
                        ? Center(
                            child: Text(
                              _searchQuery.isEmpty
                                  ? 'No countries found'
                                  : 'No countries match "$_searchQuery"',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredCountries.length,
                            itemBuilder: (context, index) {
                              final country = filteredCountries[index];

                              return GestureDetector(
                                child: Card(
                                  elevation: 8,
                                  margin: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            Text(
                                              'Capital',
                                              style: TextStyle(fontSize: 15.0),
                                            ),
                                            const SizedBox(width: 90),
                                            FittedBox(
                                              child: Text(
                                                " ${country.capital.join(', ')}",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
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
                                            Text(
                                              " ",
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                        // Text("Capital: ${country.capital.join(', ')}"),
                                        // Text("Currency"),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailScreen(country: country),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                  },
                ),
                Africa(),
                Asia(),
                Europe(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
