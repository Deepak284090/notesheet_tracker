import 'package:flutter/material.dart';

class ProposerDashboard extends StatelessWidget {
  const ProposerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: const Center(child: Text('Welcome, Admin!')),
    );
  }
}
