import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
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
              'Revx Terms and Conditions',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),

            // Introduction
            Text(
              '1. General',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'These Terms of Use (“Terms”) constitute an electronic record under the Information Technology Act, 2000, and do not require physical or digital signatures. They are published in compliance with Rule 3(1) of the Information Technology (Intermediaries Guidelines and Digital Media Ethics Code) Rules, 2021.\n\n'
                  'We, Revx, a company incorporated under the Companies Act, 2013, with its registered office at [Insert Address], India (“Revx”, “We”, “Us”, “Our”), provide services to individuals accessing or using our website ([Insert Website URL]) and mobile application (collectively, “Platform”) for booking diagnostic test appointments (“You”, “User”). These Terms, along with the Privacy Policy, Return Policy, and Payment & Refunds Policy at [Insert Website URL], form the entire agreement between Revx and You.\n\n'
                  'By accessing or using the Platform, you agree to these Terms. If you disagree, you must discontinue use of the Platform. Revx may assign or transfer its rights under these Terms to a third party, and you will remain bound by these Terms.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Eligibility
            Text(
              '2. Eligibility',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'To use the Platform, you must:\n'
                  '- Be at least 18 years old or use the Platform under the supervision of a parent/guardian, who will be deemed the end-user.\n'
                  '- If under 18, have a registered parent/guardian transact on your behalf.\n'
                  '- Be legally competent to contract under the Indian Contract Act, 1872.\n'
                  '- Not have been previously suspended or removed by Revx.\n'
                  '- Create only one account with accurate, current information and maintain its security.\n'
                  '- Not share your login ID with others.\n'
                  'Revx reserves the right to terminate access if you are under 18, violate these Terms, or for any other reason without notice. Organizations or businesses may not register as Users.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Services
            Text(
              '3. Our Services',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Revx provides the following services (“Services”):\n'
                  '- **Account Creation and Management**: Register with personal details (e.g., name, phone number, email, birth date, gender) to use the Platform.\n'
                  '- **Booking Diagnostic Test Appointments**: Book, reschedule, or cancel appointments with diagnostic service providers. Confirmations are sent via SMS, email, or the Platform. Revx may reschedule or cancel appointments due to unforeseen circumstances, with appropriate resolutions (e.g., rescheduling or refunds). Appointments can be modified free of charge up to 30 minutes prior to the scheduled time, with one free rescheduling per booking.\n'
                  '- **Accessing Booking Records**: View your booking history on the Platform.\n'
                  '- **Other Services**: Additional services as introduced on the Platform, subject to these Terms.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Use of Platform
            Text(
              '4. Your Use of the Platform',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'You agree to:\n'
                  '- **Due Diligence**: Provide accurate personal and health information and protect your account credentials. You are responsible for all activities under your account.\n'
                  '- **Scope of Services**: Services are provided by diagnostic service providers, not Revx. Revx facilitates connections but is not liable for service outcomes or errors. You are responsible for assessing the suitability of services.\n'
                  '- **Prohibitions**: You may not reproduce, modify, or exploit Platform content, impersonate others, upload prohibited content, or contact service providers outside the Platform.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Prohibited Content
            Text(
              '5. Prohibited Content',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'You shall not upload or distribute content that:\n'
                  '- Belongs to others without rights.\n'
                  '- Is harmful, defamatory, obscene, or violates Indian laws.\n'
                  '- Harms minors, infringes intellectual property, or promotes illegal activities.\n'
                  '- Is false, misleading, or threatening to India’s security or public order.\n'
                  '- Contains viruses or disrupts Platform functionality.\n'
                  'Revx may remove such content and terminate your access for violations.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Indemnity
            Text(
              '6. Indemnity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'You agree to indemnify Revx, its affiliates, and diagnostic service providers for losses arising from:\n'
                  '- Inaccurate or incomplete information provided by you.\n'
                  '- Misinterpretation of test results or failure to follow instructions.\n'
                  '- Unauthorized use of payment methods.\n'
                  '- Third-party access to your account.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Limitation of Liability
            Text(
              '7. Limitation of Liability',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'To the extent permitted by law:\n'
                  '- Services are provided by diagnostic service providers, not Revx. Revx is not liable for service quality or outcomes.\n'
                  '- Revx does not guarantee the accuracy or suitability of diagnostic services.\n'
                  '- Revx is not liable for indirect, incidental, or consequential damages arising from Platform use or third-party services.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Modification
            Text(
              '8. Modification of the Platform',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Revx may modify or discontinue the Platform or its features without notice. You agree that Revx is not liable for such changes.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Data Policy
            Text(
              '9. Data & Information Policy',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'We respect your privacy. See our Privacy Policy at [Insert Website URL]/privacy for details on data collection and use.\n'
                  'You may delete your account permanently by following these steps: Go to My Account > Help/Need Help > Account & Booking Records > I want to delete my account > My Issue is still not resolved > type “Delete my account” > raise an enquiry. Deletion is irreversible.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Intellectual Property
            Text(
              '10. Intellectual Property',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'All Platform content and intellectual property belong to Revx. You may not copy, modify, or distribute content without written permission.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Miscellaneous
            Text(
              '11. Miscellaneous',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '- **Third-Party Links**: The Platform may link to third-party sites. Revx is not responsible for their content or services.\n'
                  '- **Amendments**: Revx may update these Terms. Check periodically for changes.\n'
                  '- **Force Majeure**: Revx is not liable for delays due to events beyond our control (e.g., natural disasters, strikes).\n'
                  '- **Termination**: Revx or you may terminate this agreement at any time. Revx may suspend access for violations.\n'
                  '- **Governing Law**: These Terms are governed by Indian law, with disputes subject to the courts of [Insert City]. Disputes unresolved within 30 days may be referred to arbitration in [Insert City] under the Indian Arbitration and Conciliation Act, 1996.\n'
                  '- **Severability**: Unenforceable provisions will be enforced to the maximum extent possible.\n'
                  '- **Waiver**: Waivers must be in writing and signed by Revx.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Contact Us
            Text(
              '12. Contact Us',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'For grievances, contact our Grievance Officer:\n'
                  '- **Name**: [Insert Name]\n'
                  '- **Email**: grievance@revx.com\n'
                  '- **Phone**: [Insert Phone Number]\n'
                  'For escalations, contact our Grievance-cum-Nodal Officer:\n'
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