import 'package:flutter/material.dart';
import 'package:tugas_praktpm4_123200011/tourism_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourist App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<TourismPlace> places = tourismData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tourism Places'),
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.place),
            title: Text(places[index].name),
            subtitle: Text(places[index].location),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(place: places[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final TourismPlace place;

  DetailPage({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            child: Image.network(
              place.getImageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              place.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(),
                ),
              );
            },
            child: Text('Tambah Data'),
          ),
        ],
      ),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _location, _description, _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Data'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Nama Destinasi Wisata',
              ),
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Lokasi Destinasi Wisata',
              ),
              onSaved: (value) => _location = value!,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Deskripsi Destinasi Wisata',
              ),
              onSaved: (value) => _description = value!,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'URL Gambar Destinasi Wisata',
              ),
              onSaved: (value) => _imageUrl = value!,
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed : () {
                  _formKey.currentState!.save();
                  final data = DestinationData(
                    name: _name,
                    location: _location,
                    description: _description,
                    imageUrl: _imageUrl,
                  );
                  Navigator.pop(context, data);
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DestinationData {
  String name;
  String location;
  String description;
  String imageUrl;

  DestinationData({
    required this.name,
    required this.location,
    required this.description,
    required this.imageUrl,
  });
}
