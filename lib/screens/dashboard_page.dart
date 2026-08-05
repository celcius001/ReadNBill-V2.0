import 'package:flutter/material.dart';
import 'package:readnbill/database/database_helper.dart';
import 'package:readnbill/models/tempreading_model.dart';
import 'package:readnbill/screens/transaction_page.dart';

class DashboardPage extends StatefulWidget {
  final String? routeNo;

  const DashboardPage({super.key, required this.routeNo});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController searchController = TextEditingController();
  List<TempModel> readings = [];
  List<TempModel> filteredReadings = [];

  @override
  void initState() {
    super.initState();

    _loadReadings();
  }

  Future<void> _loadReadings() async {
    final data = await DatabaseHelper.instance.getReadingsByRoute(
      widget.routeNo!,
    );

    setState(() {
      readings = data;
      filteredReadings = data;
    });
  }

  void _search(String value) {
    final query = value.toLowerCase();

    setState(() {
      filteredReadings =
          readings.where((reading) {
            return reading.consumerName.toLowerCase().contains(query) ||
                reading.accountNumber.toLowerCase().contains(query) ||
                reading.shortAccountNumber.toLowerCase().contains(query) ||
                reading.meterNumber.toLowerCase().contains(query) ||
                reading.sequenceNumber.toString().contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search Consumer...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            _search('');
                          },
                        )
                        : null,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredReadings.length,
              itemBuilder: (context, index) {
                final reading = filteredReadings[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(reading.sequenceNumber.toString()),
                    ),
                    title: Text(
                      reading.consumerName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("Account: ${reading.shortAccountNumber}"),
                        Text("Meter: ${reading.meterNumber}"),
                        Text("Address: ${reading.consumerAddress}"),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Reading", style: TextStyle(fontSize: 12)),
                        Text(
                          reading.powerReading.toStringAsFixed(0),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => TransactionPage(reading: reading),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
