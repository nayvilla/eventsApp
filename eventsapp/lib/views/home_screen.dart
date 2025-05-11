import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.arrow_back, color: theme.iconTheme.color),
                const SizedBox(width: 16),
                Text(
                  'Welcome back 👋\nRidwan Soleh',
                  style: theme.textTheme.titleLarge?.copyWith(color: theme.iconTheme.color),
                ),
                const Spacer(),
                Icon(Icons.notifications, color: theme.iconTheme.color),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: theme.iconTheme.color),
                  const SizedBox(width: 8),
                  Text('Search Event', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Category buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _categoryButton('Music', theme),
                _categoryButton('Sport', theme),
                _categoryButton('Food', theme),
              ],
            ),
            const SizedBox(height: 16),

            // Popular Event Section
            Text('Popular Event', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            _eventCard(theme, 'International Jazz Day', '30 April 2023 - Jakarta, Indonesia', '\$135'),
            const SizedBox(height: 16),

            // Event for you Section
            Text('Event for you', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            _eventCard(theme, 'Street Food Festival', '31 December 2023 - New York, USA', '\$120'),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton(String label, ThemeData theme) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white)),
    );
  }

  Widget _eventCard(ThemeData theme, String title, String date, String price) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(date, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 8),
          Text(price, style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor)),
        ],
      ),
    );
  }
}
