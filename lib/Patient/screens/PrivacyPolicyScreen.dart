import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Revx Privacy Policy',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),

            // Introduction
            Text(
              'Introduction',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'At Revx, we are committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your personal information when you use our platform to book appointments for diagnostic tests. By using the Revx Platform, you agree to the terms outlined in this Privacy Policy.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Data Collection
            Text(
              '1. Information We Collect',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'We collect the following types of information to provide and improve our services:\n'
                  '- **Personal Information**: When you register on the Platform, we collect details such as your name, phone number, email address, birth date, and gender.\n'
                  '- **Booking Information**: Details related to your diagnostic test appointments, including test type, date, and diagnostic center.\n'
                  '- **Usage Data**: Information about how you interact with the Platform, such as IP address, device information, and browsing activity.\n'
                  '- **Health-Related Information**: Any health information you provide to facilitate diagnostic test bookings, used solely for service delivery.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Data Usage
            Text(
              '2. How We Use Your Information',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'We use your information for the following purposes:\n'
                  '- To create and manage your account.\n'
                  '- To facilitate booking, rescheduling, or cancellation of diagnostic test appointments.\n'
                  '- To communicate with you regarding your bookings or account.\n'
                  '- For analysis, research, and training to improve our services, as permitted by law.\n'
                  '- To comply with legal obligations or respond to government authorities, where required.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Data Sharing
            Text(
              '3. Sharing Your Information',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'We may share your information with:\n'
                  '- **Diagnostic Service sökors**: To fulfill your booking requests.\n'
                  '- **Affiliates and Partners**: For analysis, research, or service improvement, as per our Terms of Use.\n'
                  '- **Legal Authorities**: When required by law or to protect our rights.\n'
                  'We do not sell or rent your personal information to third parties for marketing purposes.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Data Security
            Text(
              '4. Data Security',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'We implement industry-standard security measures to protect your personal information from unauthorized access, use, or disclosure. However, no method of transmission over the internet is 100% secure, and we cannot guarantee absolute security.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // User Rights
            Text(
              '5. Your Rights',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'You have the following rights regarding your personal information:\n'
                  '- **Access**: View your booking records and personal details on the Platform.\n'
                  '- **Correction**: Update inaccurate or incomplete information in your account.\n'
                  '- **Deletion**: Permanently delete your account and personal information by following these steps: Go to My Account > Help/Need Help > Account & Booking Records > I want to delete my account > My Issue is still not resolved > type “Delete my account” > raise an enquiry. Note that deletion is irreversible, and you will need to create a new account to use our services again.\n'
                  '- **Objection**: Contact us to object to certain uses of your information, where applicable.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Third-Party Links
            Text(
              '6. Third-Party Links',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The Platform may contain links to third-party websites or services (e.g., diagnostic service providers). We are not responsible for the privacy practices or content of these third parties. Please review their respective privacy policies before sharing information.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Changes to Policy
            Text(
              '7. Changes to This Privacy Policy',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'We may update this Privacy Policy from time to time. Any changes will be posted on the Platform, and we encourage you to review it periodically to stay informed.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Contact Us
            Text(
              '8. Contact Us',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'If you have any questions or concerns about this Privacy Policy, please contact our Grievance Officer:\n'
                  '- **Name**: [Insert Name]\n'
                  '- **Email**: grievance@revx.com\n'
                  '- **Phone**: [Insert Phone Number]\n'
                  'Grievances will be acknowledged within 48 hours and resolved within 1 month.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),

            // Footer
            Center(
              child: Text(
                '© 2025 Revx. All Rights Reserved.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}