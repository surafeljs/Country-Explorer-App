import 'package:country_explorer_app/models/country.dart';
import 'package:country_explorer_app/screen/detail_screen..dart';
import 'package:country_explorer_app/services/search.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchController = TextEditingController();
  final SearchService _searchService = SearchService();
  List<Country> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialCountries();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialCountries() async {
    setState(() => _isLoading = true);
    try {
      final results = await _searchService.searchCountries('');
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // Handle error
    }
  }

  void _onSearchChanged() {
    _performSearch(_searchController.text);
  }

  Future<void> _performSearch(String query) async {
    setState(() => _isLoading = true);
    try {
      final results = await _searchService.searchCountries(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Search Header
        Divider(),
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 350,
            height: 160.0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 22.0, top: 30.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Discover Nations',
                      style: TextStyle(
                        color: Color.fromARGB(255, 6, 6, 62),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 22.0, top: 8.0),
                  child: Text(
                    'Search through detailed profiles of every sovereign nation across the seven continents.',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Search TextField
        Padding(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search countries...',
              prefixIcon: Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),

        SizedBox(height: 22.0),

        // Search Results
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _searchResults.isEmpty
              ? Center(
                  child: Text(
                    _searchController.text.isEmpty
                        ? 'Start typing to search countries...'
                        : 'No countries found matching "${_searchController.text}"',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final country = _searchResults[index];
                    return Card(
                      elevation: 8.0,
                      margin: EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(country: country),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Flag placeholder (you can add actual flag image later)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 20.0,
                              ),
                              child: Container(
                                width: width,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.0),
                                    bottomLeft: Radius.circular(12.0),
                                  ),
                                  color: Color.fromARGB(16, 233, 30, 98),
                                ),
                                child: Center(
                                  child: Text(
                                    country.flags.png.isNotEmpty
                                        ? '🇺🇳'
                                        : '🏳️',
                                    style: TextStyle(fontSize: 80),
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Text(
                                      country.name.common,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 6, 6, 62),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.0),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Row(
                                      spacing: 20.0,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          country.region,
                                          style: TextStyle(
                                            color: Color(0xFF2F2FE4),
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          country.subregion,
                                          style: TextStyle(
                                            color: Color(0xFF2F2FE4),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30.0),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Capital',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(width: 100.0),
                                        Text(
                                          country.capital.isNotEmpty
                                              ? country.capital[0]
                                              : 'N/A',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.0),

                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Region',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(width: 100.0),
                                        Text(
                                          country.region,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
