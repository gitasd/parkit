import 'package:flutter/material.dart';

class SavedParkingLots extends StatefulWidget {
  var parkingTobeSaved;
  SavedParkingLots({super.key, this.parkingTobeSaved});

  @override
  State<SavedParkingLots> createState() =>
      _SavedParkingLotsState(parkingToBeSaved: parkingTobeSaved);
}

class _SavedParkingLotsState extends State<SavedParkingLots>
    with AutomaticKeepAliveClientMixin<SavedParkingLots> {
  var parkingToBeSaved;

  _SavedParkingLotsState({this.parkingToBeSaved});

  List<String> _savedParkings = [
    "Test Parking 1",
    "Test Parking 2",
    "Test Parking 3"
  ];
  void addToSaved(String parking) {
    if (parkingToBeSaved == " ") {
      return;
    } else {
      setState(() {
        _savedParkings.add(parkingToBeSaved);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    addToSaved(parkingToBeSaved);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Saved"),
        ),
        // body: ListView.builder(itemBuilder: (context, index){
        //   return Card(

        //   );
        // } ),
        body: ListView.builder(
          itemBuilder: (context, index) => ListTile(
              onTap: () {},
              leading: Icon(Icons.local_parking),
              title: Text(_savedParkings[index].toString())),
          itemCount: _savedParkings.length,
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
