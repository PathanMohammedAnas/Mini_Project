import 'package:flutter/material.dart';
import 'package:untitled/Screen/Weather_Screen.dart';
import 'package:untitled/Screen/product_list.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Cities list
  final List<Map<String, dynamic>> cities = [
    {"name": "Ahmedabad", "latitude": 23.0225, "longitude": 72.5714},
    {"name": "Surat", "latitude": 21.1702, "longitude": 72.8311},
    {"name": "Himmatnagar", "latitude": 23.1775, "longitude": 72.9522},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Colors.deepPurpleAccent.shade100,
              Colors.deepPurpleAccent.shade400,
              Colors.deepPurple.shade900,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header for Weather Section
              Text(
                "Choose Your City",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              // Updated City Cards with 3D effect and custom gradient
              Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeatherDetailsPage(
                              cityName: city["name"],
                              latitude: city["latitude"],
                              longitude: city["longitude"],
                            ),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.pinkAccent.shade100,
                              Colors.deepPurple.shade800,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 12,
                              offset: Offset(4, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              city["name"],
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.cloud_circle,
                              color: Colors.lightBlueAccent,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Header for Product Section
              SizedBox(height: 20),
              Text(
                "Explore Products",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),

              // Product Card with new 3D effect and glowing border
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(),
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.orangeAccent.shade200,
                        Colors.deepOrange.shade600,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepOrange.withOpacity(0.5),
                        blurRadius: 12,
                        offset: Offset(4, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "View Products",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
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
