import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/providers/foodlist.dart';
import 'package:project/screens/draw.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Widget content = const Center(
    child: Text("No food found. Please try again later"),
  );

  @override
  Widget build(BuildContext context) {
    final foodList = ref.watch(foodListProvider);
    if (foodList.isNotEmpty) {
      content = Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: foodList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Card(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: double.infinity,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.red.withOpacity(0.9),
                          Colors.red.withOpacity(0.1)
                        ],
                      ),
                    ),
                    child: Text(foodList[index].foodname),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Replate"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: content,
      drawer: const DrawScreen(),
    );
  }
}
