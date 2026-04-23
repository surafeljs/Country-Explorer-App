import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                      height: 180.0,
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
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 22.0, top: 10.0),

                            child: Text(
                              'Access detailed economic, geographic, and cultural data from 195+ countries across the globe.',
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
                      decoration: InputDecoration(
                        hint: Text('Search countries by name capital or'),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 60, 97, 161),

                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 22.0,
                                  ),
                                  child: const Text('All countries'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 22.0,
                                ),
                                child: const Text('Europe'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 22.0,
                                ),
                                child: const Text('Asia'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 22.0,
                                ),
                                child: const Text('Africa'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  Card(
                    elevation: 8.0,

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
                            width: 320,
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
                                      style: TextStyle(fontSize: 16),
                                    ),

                                    Text(
                                      'East africa',
                                      style: TextStyle(fontSize: 16),
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
