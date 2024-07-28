import 'dart:async';

import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rtdata/pantallas/GTemp.dart';
import 'package:rtdata/pantallas/GHume.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin<Home> {
  double humidity = 0, temperature = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Milton Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await getData();
              setState(() {
                isLoading = false;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GTemp(temperature: temperature),
                const Divider(height: 5),
                GHume(humidity: humidity),
                const Divider(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Temperatura: $temperature°C"),
                      Text("Humedad: $humidity%"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Center(
              child: Container(
                color: Colors.black54,
                child: const CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    Timer.periodic(
      const Duration(seconds: 30),
          (timer) async {
        await getData();
      },
    );
  }

  Future<void> getData() async {
    final ref = FirebaseDatabase.instance.ref();
    final temp = await ref.child("Living Room/temperature/value").get();
    final humi = await ref.child("Living Room/humidity/value").get();
    if (temp.exists && humi.exists) {
      setState(() {
        temperature = double.parse(temp.value.toString());
        humidity = double.parse(humi.value.toString());
      });
    } else {
      setState(() {
        temperature = -1;
        humidity = -1;
      });
    }
  }
}
