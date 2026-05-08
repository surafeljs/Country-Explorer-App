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
  String? _errorMessage;

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
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final results = await _searchService.searchCountries('');
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _onSearchChanged() {
    _performSearch(_searchController.text);
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final results = await _searchService.searchCountries(query);
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Search Header
        const Divider(),
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
                        color: const Color.fromARGB(255, 6, 6, 62),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Padding(
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
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search countries...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
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

        const SizedBox(height: 22.0),

        // Search Results
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _errorMessage!.contains('No internet connection')
                            ? Icons.wifi_off
                            : Icons.error,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!.contains('No internet connection')
                            ? 'No Internet Connection'
                            : 'Failed to Load Countries',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          _errorMessage!.contains('No internet connection')
                              ? 'Please check your internet connection and try again.'
                              : 'Something went wrong while loading countries. Please try again.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_searchController.text.isEmpty) {
                            _loadInitialCountries();
                          } else {
                            _performSearch(_searchController.text);
                          }
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : _searchResults.isEmpty
              ? Center(
                  child: Text(
                    _searchController.text.isEmpty
                        ? 'Start typing to search countries...'
                        : 'No countries found matching "${_searchController.text}"',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final country = _searchResults[index];
                    return Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.all(20.0),
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
                            // Flag Image
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 20.0,
                              ),
                              child: Container(
                                width: width,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12.0),
                                    bottomLeft: Radius.circular(12.0),
                                  ),
                                ),
                                child: country.flags.png.isNotEmpty
                                    ? Image.network(
                                        country.flags.png,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.flag,
                                                  size: 80,
                                                  color: Colors.grey,
                                                ),
                                      )
                                    : const Center(
                                        child: Icon(
                                          Icons.flag,
                                          size: 80,
                                          color: Colors.grey,
                                        ),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Text(
                                      country.name.common,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 6, 6, 62),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Row(
                                      spacing: 20.0,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          country.region,
                                          style: const TextStyle(
                                            color: Color(0xFF2F2FE4),
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          country.subregion,
                                          style: const TextStyle(
                                            color: Color(0xFF2F2FE4),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 30.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Capital',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(width: 100.0),
                                        Text(
                                          country.capital.isNotEmpty
                                              ? country.capital[0]
                                              : 'N/A',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Currency',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        const SizedBox(width: 100.0),
                                        Text(
                                          country.currencies.isNotEmpty
                                              ? country
                                                        .currencies
                                                        .entries
                                                        .first
                                                        .value['name'] ??
                                                    'N/A'
                                              : 'N/A',
                                          style: const TextStyle(fontSize: 16),
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
