import 'package:flutter/material.dart';

class AllTestsScreen extends StatefulWidget {
  @override
  _AllTestsScreenState createState() => _AllTestsScreenState();
}

class _AllTestsScreenState extends State<AllTestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tests'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: () {
              // Handle filter button press
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for lab tests (CBP, X-Ray...)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.teal,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'Lab Tests'),
              Tab(text: 'Condition based'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab 1 content (Lab Tests)
                ListView(
                  children: [
                    _buildTestCategoryItem('Anaemia', '26 Tests Available'),
                    _buildTestCategoryItem('Diabetes', '18 Tests Available'),
                    _buildTestCategoryItem('Heart', '21 Tests Available'),
                    _buildTestCategoryItem('Liver', '35 Tests Available'),
                    _buildTestCategoryItem('Lungs', '1 Tests Available'),
                    _buildTestCategoryItem('Fertility', '13 Tests Available'),
                    _buildTestCategoryItem('Kidney', '23 Tests Available'),
                    _buildTestCategoryItem('Allergy', '2 Tests Available'),
                    _buildTestCategoryItem('Vitamins', '10 Tests Available'),
                  ],
                ),
                // Tab 2 content (Condition based)
                Center(
                  child: Text('Condition based content goes here'),
                ),
              ],
            ),
          ),
        ],
      )
      );
  }
  Widget _buildTestCategoryItem(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Handle tap
      },
    );
  }
}
