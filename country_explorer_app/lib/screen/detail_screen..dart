import 'package:flutter/material.dart';
import 'package:country_explorer_app/models/country.dart';
import 'package:country_explorer_app/services/saved_countries_service.dart';

class DetailScreen extends StatefulWidget {
  final Country country;

  const DetailScreen({Key? key, required this.country}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final SavedCountriesService _savedService = SavedCountriesService();
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    final isSaved = await _savedService.isCountrySaved(widget.country);
    setState(() {
      _isSaved = isSaved;
    });
  }

  Future<void> _toggleSave() async {
    if (_isSaved) {
      await _savedService.removeCountry(widget.country);
    } else {
      await _savedService.saveCountry(widget.country);
    }
    setState(() {
      _isSaved = !_isSaved;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isSaved ? 'Country saved!' : 'Country removed from saved',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.name.common),
        actions: [
          IconButton(
            icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: _toggleSave,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.country.flags.png,
                  height: 200,
                  width: width * 0.9,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.flag),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Region: ${widget.country.region}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Subregion: ${widget.country.subregion}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Capital: ${widget.country.capital.isNotEmpty ? widget.country.capital.join(", ") : "N/A"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Currencies: ${widget.country.currencies.isNotEmpty ? widget.country.currencies.entries.map((e) => '${e.key}: ${e.value['name']} (${e.value['symbol']})').join(', ') : "N/A"}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
