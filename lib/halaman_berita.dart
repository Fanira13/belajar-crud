import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HalamanBerita extends StatefulWidget {
  const HalamanBerita({super.key});

  @override
  State<HalamanBerita> createState() => _HalamanBeritaState();
}

class _HalamanBeritaState extends State<HalamanBerita> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
    try {
      final respon =
          await http.get(Uri.parse('http://192.168.136.68:8000/notes'));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          _listdata = data;
          _loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Halaman Berita'),
          backgroundColor: Colors.deepOrange,
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _listdata.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_listdata[index]['title']),
                      subtitle: Text(_listdata[index]['description']),
                    ),
                  );
                }),
              ));
  }
}
