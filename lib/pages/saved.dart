import 'package:flutter/material.dart';

class SavedParkingLots extends StatefulWidget {
  const SavedParkingLots({super.key});

  @override
  State<SavedParkingLots> createState() => _SavedParkingLotsState();
}

class _SavedParkingLotsState extends State<SavedParkingLots>
    with AutomaticKeepAliveClientMixin<SavedParkingLots> {
  int counts = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("counts $counts"),
          ),
          ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  counts += 1;
                });
              },
              icon: Icon(Icons.add),
              label: Text("ADD"))
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
