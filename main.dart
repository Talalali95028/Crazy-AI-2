
// تطبيق Crazy AI - متكامل مع الخرائط والذكاء الاصطناعي وواجهات APIs

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // للخرائط

void main() {
  runApp(CrazyAIApp());
}

class CrazyAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crazy AI',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SearchScreen()),
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            'Crazy AI',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crazy AI Assistant")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "What do you need?",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Search with AI"),
              onPressed: () {
                // محاكاة تحليل النص (NLU/NLP)
                String query = controller.text.toLowerCase();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultsScreen(query: query)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final String query;
  ResultsScreen({required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results for '$query'")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Result #$index"),
                    subtitle: Text("Description for result #$index"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailsScreen(index: index)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            child: Text("Show Nearby on Map"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapScreen()),
              );
            },
          )
        ],
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final int index;
  DetailsScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product/Service #$index", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Full description, pricing, availability info here."),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Buy Now / Book Now"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Enter Payment Details", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "Card Number")),
            TextField(decoration: InputDecoration(labelText: "Expiry Date")),
            TextField(decoration: InputDecoration(labelText: "CVV")),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Confirm Payment"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Payment Successful!")));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nearby Locations")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(24.7136, 46.6753), // مثال: الرياض
          zoom: 12,
        ),
        markers: {
          Marker(
            markerId: MarkerId("place1"),
            position: LatLng(24.7136, 46.6753),
            infoWindow: InfoWindow(title: "Place 1"),
          ),
        },
      ),
    );
  }
}
