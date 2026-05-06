import 'package:flutter/material.dart';
import 'package:country_explorer_app/models/country.dart';

class DetailScreen extends StatelessWidget {
  final Country country;

  const DetailScreen({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text(country.name.common)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                country.flags.png,
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
                      'Region: ${country.region}',
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
                      'Subregion: ${country.subregion}',
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
                    'Capital: ${country.capital.isNotEmpty ? country.capital.join(", ") : "N/A"}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
