import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import '../core/theme/app_colors.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String? _selectedGoal;
  String? _selectedDiet;
  final TextEditingController _ageController = TextEditingController();

  final List<String> _goals = [
    'Weight Loss',
    'Diabetes Management',
    'Heart Health',
    'General Wellness'
  ];

  final List<String> _diets = [
    'None',
    'Vegan',
    'Vegetarian',
    'Keto',
    'Gluten-Free'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Personalize your experience',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
             const SizedBox(height: 8),
            Text(
              'We use this to give you better food recommendations.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            
            // Age
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
                prefixIcon: Icon(Icons.cake_outlined),
              ),
            ),
            const SizedBox(height: 24),

            // Health Goal
            DropdownButtonFormField<String>(
              value: _selectedGoal,
              decoration: const InputDecoration(
                labelText: 'Health Goal',
                prefixIcon: Icon(Icons.flag_outlined),
              ),
              items: _goals.map((goal) {
                return DropdownMenuItem(value: goal, child: Text(goal));
              }).toList(),
              onChanged: (val) => setState(() => _selectedGoal = val),
            ),
            const SizedBox(height: 24),

            // Dietary Preference
            DropdownButtonFormField<String>(
              value: _selectedDiet,
              decoration: const InputDecoration(
                labelText: 'Dietary Preference',
                prefixIcon: Icon(Icons.restaurant_menu),
              ),
              items: _diets.map((diet) {
                return DropdownMenuItem(value: diet, child: Text(diet));
              }).toList(),
              onChanged: (val) => setState(() => _selectedDiet = val),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () {
                // Mock Saving
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile Saved!')),
                );
                Future.delayed(const Duration(seconds: 1), () {
                  if(mounted) context.go('/dashboard');
                });
              },
              child: const Text('Save & Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
