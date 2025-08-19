import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_audio_app/resources/constant.dart';

class IsolatePage extends StatefulWidget {
  const IsolatePage({super.key});

  @override
  State<IsolatePage> createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Isolate Page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          ElevatedButton(
            onPressed: () {
              // ⚠️ Freezes UI
              final result = findPrimes(2000000);
              print("Sync result: $result");
            },
            child: const Text("Run on Main Isolate (Freeze UI)"),
          ),
          ElevatedButton(
            onPressed: () async {
              // ✅ Smooth UI
              final result = await runWithCompute(2000000);
              print("Compute result: $result");
            },
            child: const Text("Run with compute()"),
          ),
          ElevatedButton(
            onPressed: () async {
              // ✅ Smooth UI
              final result = await runWithIsolate(2000000);
              print("Isolate result: $result");
            },
            child: const Text("Run with Isolate"),
          ),
        ],
      ),
    );
  }

  // 2. Compute wrapper
  Future<List<int>> runWithCompute(int n) {
    return compute(findPrimes, n);
  }

  // 3. Isolate example
  Future<List<int>> runWithIsolate(int n) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_isolateEntry, [n, receivePort.sendPort]);
    return await receivePort.first as List<int>;
  }
}

List<int> findPrimes(int max) {
  List<int> primes = [];
  for (int i = 2; i <= max; i++) {
    bool isPrime = true;
    for (int j = 2; j * j <= i; j++) {
      if (i % j == 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) primes.add(i);
  }
  return primes;
}

_isolateEntry(List<dynamic> args) {
  final n = args[0] as int;
  final sendPort = args[1] as SendPort;

  final result = findPrimes(n);
  sendPort.send(result);
}
