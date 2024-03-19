import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/views/eventDetailsPage.dart';
import 'package:flutter/material.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Events'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search events',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterEvents,
            ),
          ),
          Expanded(
            child: _buildEventsList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsList(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final filteredEvents = snapshot.data!.docs.where((document) {
              final eventData = document.data() as Map<String, dynamic>;
              final eventName = eventData['eventName'].toString().toLowerCase();
              final searchQuery = _searchController.text.toLowerCase();
              return eventName.contains(searchQuery);
            }).toList();
            return ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final document = filteredEvents[index];
                final data = document.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(
                    data['eventName'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data['eventDate']),
                  onTap: () {
                    _navigateToEventDetails(
                        context, document.id); // Pass event ID
                  },
                );
              },
            );
          }
        }
      },
    );
  }

  void _navigateToEventDetails(BuildContext context, String eventId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailsPage(eventId: eventId),
      ),
    );
  }

  void _filterEvents(String query) {
    setState(() {
      // Trigger rebuilding the event list with the filtered events
    });
  }
}
