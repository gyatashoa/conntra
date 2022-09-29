import 'package:contra/model/prediction.dart';
import 'package:contra/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  late TextEditingController _textEditingController;

  late ApiService _apiService;
  late List<Prediction> _places;

  @override
  void initState() {
    super.initState();
    _apiService = GetIt.instance<ApiService>();
    _textEditingController = TextEditingController(text: '');
    _places = [];
  }

  void searchPickUpPlace() async {
    if (_textEditingController.text.length > 1) {
      var response = await _apiService.getLocation(_textEditingController.text);
      if (response is String) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('RESPONSE FAILED ON SEARCH')));
        return;
      }
      if (response is List<Prediction>) {
        setState(() {
          _places = response;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: TextField(
          onChanged: (_) => searchPickUpPlace(),
          controller: _textEditingController,
          decoration:
              const InputDecoration.collapsed(hintText: 'Enter your location'),
        ),
      ),
      body: ListView.builder(
          itemCount: _places.length,
          itemBuilder: (_, i) => ListTile(
                onTap: () => Navigator.pop(context, _places[i]),
                leading: const Icon(Icons.location_on),
                title: Text(_places[i].mainText ?? ''),
                subtitle: Text(_places[i].secondaryText ?? ''),
              )),
    );
  }
}
