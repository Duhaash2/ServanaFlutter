import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Filter By", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: Icon(Icons.trending_up, color: Colors.green),
            title: Text("Lower Price"),
            onTap: () {
              // call API or set filter state
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.trending_down, color: Colors.red),
            title: Text("Higher Price"),
            onTap: () {
              // call API or set filter state
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.amber),
            title: Text("Top Rated"),
            onTap: () {
              // call API or set filter state
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
