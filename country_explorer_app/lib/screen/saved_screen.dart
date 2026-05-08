import 'package:flutter/material.dart';
import 'package:country_explorer_app/models/country.dart';
import 'package:country_explorer_app/screen/detail_screen..dart';
import 'package:country_explorer_app/services/saved_countries_service.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final SavedCountriesService _savedService = SavedCountriesService();
  List<Country> _savedCountries = [];

  @override
  void initState() {
    super.initState();
    _loadSavedCountries();
  }

  Future<void> _loadSavedCountries() async {
    final countries = await _savedService.getSavedCountries();
    setState(() {
      _savedCountries = countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Countries')),
      body: _savedCountries.isEmpty
          ? const Center(
              child: Text(
                'No saved countries yet.\nTap the bookmark icon on country details to save.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _savedCountries.length,
              itemBuilder: (context, index) {
                final country = _savedCountries[index];
                return ListTile(
                  leading: Image.network(
                    country.flags.png,
                    width: 50,
                    height: 30,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.flag),
                  ),
                  title: Text(country.name.common),
                  subtitle: Text(
                    '${country.region} - ${country.capital.isNotEmpty ? country.capital.first : "N/A"}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(country: country),
                      ),
                    ).then(
                      (_) => _loadSavedCountries(),
                    ); // Refresh after returning
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await _savedService.removeCountry(country);
                      _loadSavedCountries();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Country removed from saved'),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
