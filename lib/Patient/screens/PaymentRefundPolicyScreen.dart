import 'package:flutter/material.dart';

import '../../Components/CutomAppBar.dart';

class RefundPolicyScreen extends StatelessWidget {
  const RefundPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomAppBar(
        title:  'Refund Policy',
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
                  'Revx Refund Policy',
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
At Revx, we strive to ensure a seamless experience for booking diagnostic tests. This Refund Policy outlines the conditions under which refunds may be requested for bookings made through the Revx app. Please read this policy carefully before making a booking.

1. Scope of the Policy
This Refund Policy applies to all bookings for diagnostic tests made through the Revx app. Refunds are subject to the policies of the third-party healthcare providers delivering the diagnostic services. Revx acts as a platform to facilitate bookings and does not directly provide diagnostic tests.

2. Eligibility for Refunds
Refunds may be available under the following circumstances:
- **Cancellation by User**: If you cancel a booking within the cancellation window specified by the healthcare provider, you may be eligible for a full or partial refund.
- **Cancellation by Healthcare Provider**: If a healthcare provider cancels your appointment, you are entitled to a full refund of any payments made through the Revx app.
- **Service Not Provided**: If the booked diagnostic test is not performed due to reasons attributable to the healthcare provider, you may be eligible for a refund.

3. Non-Refundable Circumstances
Refunds will not be issued in the following cases:
- Cancellations made after the healthcare provider’s cancellation window has passed.
- No-shows or failure to attend a scheduled appointment without prior cancellation.
- Partial use of services where the diagnostic test was partially completed.

4. Refund Process
- **Requesting a Refund**: To request a refund, contact Revx support via the app or email at support@revxapp.com within 7 days of the appointment date.
- **Processing Time**: Refunds, if approved, will be processed within 5-10 business days, depending on the payment method and the healthcare provider’s policies.
- **Method of Refund**: Refunds will be issued to the original payment method used for the booking.

5. Third-Party Policies
Revx partners with third-party healthcare providers, each of whom may have their own refund policies. Revx will communicate these policies at the time of booking. In cases of discrepancies, the healthcare provider’s policy will prevail.

6. Disputes
If you believe a refund was unfairly denied, you may escalate the issue by contacting Revx support. We will work with the healthcare provider to resolve the dispute but cannot guarantee a specific outcome.

7. Changes to This Policy
Revx reserves the right to update this Refund Policy at any time. Significant changes will be communicated to users via the app or email. Continued use of the app constitutes acceptance of the updated policy.

8. Contact Us
For questions or concerns about this Refund Policy, please contact us at:
- Email: info@revxlabs.in
- Mobile Number : 98850 12656
- Address: REV X LABS,H NO 1-8-472/1,FLAT NO 202,CHIKKADAPALLY, CIRCLE 20,HYDERABAD

Thank you for choosing Revx to manage your diagnostic test bookings.
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