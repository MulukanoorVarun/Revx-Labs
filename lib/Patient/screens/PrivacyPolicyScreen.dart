import 'package:flutter/material.dart';

import '../../Components/CutomAppBar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Dark background
      appBar:CustomAppBar(
      title: 'Privacy Policy',
      actions: [],
    ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(), // Smooth scrolling
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Revx Privacy Policy',
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
Revx ("we," "us," or "our") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your personal information when you use the Revx app to book diagnostic test appointments. By using the app, you consent to the practices described in this policy.

1. Information We Collect
We collect the following types of information:
- **Personal Information**: Name, email address, phone number, date of birth, and payment details provided during account creation or booking.
- **Health-Related Information**: Information related to your diagnostic test bookings, such as test types and appointment details, shared with your consent.
- **Usage Data**: Information about how you interact with the app, including IP address, device information, and app usage patterns.
- **Location Data**: Approximate location (if permitted) to suggest nearby healthcare providers.

2. How We Use Your Information
We use your information to:
- Facilitate booking and management of diagnostic test appointments.
- Process payments through secure third-party payment gateways.
- Communicate with you about bookings, updates, or support issues.
- Improve the app’s functionality and user experience through analytics.
- Comply with legal obligations and protect against fraudulent activities.

3. Sharing Your Information
We may share your information with:
- **Healthcare Providers**: To facilitate your diagnostic test bookings and appointments.
- **Payment Processors**: To securely process payments for bookings.
- **Service Providers**: Third-party vendors who assist with app operations, such as cloud storage or analytics, under strict confidentiality agreements.
- **Legal Authorities**: If required by law or to protect the rights and safety of Revx, its users, or the public.

4. Data Security
We implement industry-standard security measures, including encryption and secure servers, to protect your personal information. However, no method of transmission over the internet is 100% secure, and we cannot guarantee absolute security.

5. Your Choices
- **Account Information**: You may update or delete your account information through the app’s settings.
- **Location Data**: You can disable location services in your device settings, though this may limit some app features.
- **Marketing Communications**: You can opt out of promotional emails by following the unsubscribe instructions in those emails.

6. Data Retention
We retain your personal information only for as long as necessary to fulfill the purposes outlined in this policy or as required by law. Booking-related data may be retained for audit purposes as per applicable regulations.

7. Third-Party Links
The Revx app may contain links to third-party websites or services (e.g., healthcare provider portals). We are not responsible for the privacy practices of these third parties.

8. Children’s Privacy
The Revx app is not intended for users under 18 without parental or guardian consent. We do not knowingly collect personal information from children under 13.

9. International Users
If you access Revx from outside [Insert Country], your information may be transferred to and processed in [Insert Country]. By using the app, you consent to this transfer.

10. Changes to This Policy
We may update this Privacy Policy from time to time. Significant changes will be notified via the app or email. Continued use of the app constitutes acceptance of the updated policy.

11. Contact Us
For questions or concerns about this Privacy Policy, please contact us at:
- Email: info@revxlabs.in
- Mobile Number : 98850 12656
- Address: REV X LABS,H NO 1-8-472/1,FLAT NO 202,CHIKKADAPALLY, CIRCLE 20,HYDERABAD

Thank you for trusting Revx with your personal information.
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
      ),
    );
  }
}