import 'package:flutter/material.dart';

import '../../Components/CutomAppBar.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Dark background
      appBar:CustomAppBar(
        title:  'Terms and Conditions',
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Revx Terms and Conditions',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Last Updated: May 27, 2025',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '''
Welcome to Revx, a mobile application that enables users to book appointments for diagnostic tests. By accessing or using the Revx app, you agree to be bound by the following Terms and Conditions ("Terms"). If you do not agree with these Terms, please do not use the app.

1. Acceptance of Terms
By downloading, installing, or using the Revx app, you acknowledge that you have read, understood, and agree to be bound by these Terms and our Privacy Policy. These Terms apply to all users, including but not limited to individuals booking diagnostic tests and healthcare providers.

2. Eligibility
You must be at least 18 years old or have the consent of a parent or legal guardian to use the Revx app. By using the app, you represent and warrant that you meet these eligibility requirements.

3. Services Provided
Revx provides a platform to:
- Browse and book appointments for diagnostic tests at partnered healthcare facilities.
- View test details, pricing, and availability.
- Manage appointments, including rescheduling or cancellation, subject to the policies of the healthcare provider.

Revx is not a healthcare provider and does not perform diagnostic tests. We facilitate connections between users and third-party healthcare providers.

4. User Responsibilities
- **Accurate Information**: You agree to provide accurate, complete, and up-to-date information when creating an account or booking appointments.
- **Compliance**: You agree to comply with all applicable laws and regulations and the policies of the healthcare providers you book through Revx.
- **Account Security**: You are responsible for maintaining the confidentiality of your account credentials and for all activities under your account.

5. Booking and Payments
- **Appointments**: Bookings are subject to availability and confirmation by the healthcare provider. Revx is not responsible for cancellations or changes made by healthcare providers.
- **Payments**: Payments for diagnostic tests are processed through secure third-party payment gateways. You agree to pay all applicable fees as displayed at the time of booking.
- **Refunds**: Refund policies are determined by the healthcare provider. Revx will facilitate communication regarding refunds but is not responsible for issuing them.

6. Cancellations and Rescheduling
- Users may cancel or reschedule appointments through the app, subject to the healthcare provider’s policies.
- Revx is not liable for any fees or penalties incurred due to cancellations or failure to attend scheduled appointments.

7. Intellectual Property
All content, trademarks, and intellectual property within the Revx app are owned by or licensed to Revx. You may not reproduce, distribute, or create derivative works from any content without prior written consent.

8. Limitation of Liability
- Revx is not liable for any damages arising from the use of the app, including but not limited to errors in test scheduling, issues with healthcare providers, or inaccuracies in test results.
- The app is provided "as is" without warranties of any kind, whether express or implied.

9. Third-Party Services
Revx partners with third-party healthcare providers and payment processors. We are not responsible for the actions, services, or policies of these third parties.

10. Privacy
Your use of Revx is subject to our Privacy Policy, which outlines how we collect, use, and protect your personal information. By using the app, you consent to such processing.

11. Termination
Revx reserves the right to suspend or terminate your access to the app at any time for violations of these Terms or for any other reason deemed necessary.

12. Changes to Terms
We may update these Terms from time to time. You will be notified of significant changes, and continued use of the app constitutes acceptance of the updated Terms.

13. Governing Law
These Terms are governed by the laws of the State of [Insert State/Country], without regard to its conflict of law principles.

14. Contact Us
For questions or concerns about these Terms, please contact us at:
- Email: info@revxlabs.in
- Mobile Number : 98850 12656
- Address: REV X LABS,H NO 1-8-472/1,FLAT NO 202,CHIKKADAPALLY, CIRCLE 20,HYDERABAD
                ''',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
