import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Divider(),
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: SizedBox(
                      width: 350,
                      height: 160.0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 22.0,
                              top: 30.0,
                            ),
                            child: Align(
                              alignment: AlignmentGeometry.topLeft,
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
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hint: Text('Ethiopia'),
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: CloseButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 22.0),
                  Card(
                    elevation: 8.0,
                    margin: EdgeInsets.all(20.0),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 20.0,
                          ),
                          child: Container(
                            width: width,
                            height: 200,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.0),
                                bottomLeft: Radius.circular(12.0),
                              ),
                              color: Color.fromARGB(16, 233, 30, 98),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'Ethiopia',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 6, 6, 62),

                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),

                                child: Row(
                                  spacing: 20.0,

                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Africa',
                                      style: TextStyle(
                                        color: Color(0xFF2F2FE4),
                                        fontSize: 16,
                                      ),
                                    ),

                                    Text(
                                      'East africa',
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
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Capital',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 100.0),
                                    Text(
                                      'Addis Ababa',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.0),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Text(
                                      'Currency',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 88.0),

                                    Text('ETB', style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
