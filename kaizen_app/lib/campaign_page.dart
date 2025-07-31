import 'package:flutter/material.dart';

class CampaignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Campaigns'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Old'),
              Tab(text: 'Current'),
              Tab(text: 'Upcoming'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: TabBarView(
            children: [
              _buildCampaignSection('Old Campaigns', ['Campaign A', 'Campaign B']),
              _buildCampaignSection('Current Campaigns', ['Campaign C']),
              _buildCampaignSection('Upcoming Campaigns', ['Campaign D', 'Campaign E']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignSection(String title, List<String> campaigns) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Expanded(
          child: campaigns.isEmpty
              ? Center(child: Text('No campaigns to show.'))
              : ListView.builder(
                  itemCount: campaigns.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(campaigns[index]),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
