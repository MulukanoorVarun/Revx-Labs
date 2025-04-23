import 'package:flutter/material.dart';

class PaymentRefundPolicyScreen extends StatelessWidget {
  const PaymentRefundPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment and Refund Policy'),
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
              'Revx Payment and Refund Policy',
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
              'This Payment and Refund Policy outlines the terms for processing payments and refunds for transactions on the Revx Platform ([Insert Website URL] and mobile application, collectively “Platform”) for booking diagnostic test appointments (“Services”). We, Revx, a company incorporated under the Companies Act, 2013, with its registered office at [Insert Address], India (“Revx”, “We”, “Us”, “Our”), may assign or transfer our rights under this Policy to a third party, and you will remain bound by this Policy. By using the Platform, you accept this Policy, which forms part of the Terms of Use at [Insert Website URL]/terms.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Payment
            Text(
              '2. Payment',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'i. You may use payment methods like UPI, internet banking, or debit/credit cards to pay for Services (“Fees”). Payments are processed through third-party payment aggregators/gateways (e.g., PayU, Paytm, PhonePe) under their terms and privacy policies. Your details will be shared with the aggregator as per our Privacy Policy at [Insert Website URL]/privacy.\n\n'
                  'ii. Revx is not liable for incorrect or unauthorized payment details, such as using a card not lawfully owned by you or allowing third-party access to your account. You use payment modes at your own risk.\n\n'
                  'iii. Payment aggregators or banks may block transactions for reasons like fraud, blacklisted cards, or suspicious activities.\n\n'
                  'iv. Revx is not responsible for payment rejections by banks or aggregators due to risk management, fraud suspicions, or compliance with laws, including Reserve Bank of India (RBI) guidelines.\n\n'
                  'v. We do not charge for tokenization services. Any pricing updates for Services are unrelated to tokenization.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Specific Payment Modes
            Text(
              '3. Specific Payment Modes',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'i. You must comply with the terms of your chosen payment method.\n\n'
                  'ii. **QR Code Payments**: QR codes are provided by payment aggregators. Scan the code using a payment app and enter the correct amount. Your data is processed per the aggregator’s privacy policy.\n\n'
                  'iii. **Tokenized Card Payments**: Per RBI guidelines, we do not store card details. Payment aggregators may offer tokenization, storing your card data securely with card networks (e.g., Visa, Mastercard). You agree to:\n'
                  '   a. Opt for tokenized card payments with explicit consent via additional authentication.\n'
                  '   b. Allow aggregators to disclose data if required by law, card networks, or banks.\n'
                  '   c. Register or deregister cards in the “Manage Payments” section of the Platform.\n'
                  '   d. Suspend, delete, or resume tokens in the “Manage Payments” section.\n'
                  '   e. Accept that tokenization depends on RBI, card network, and aggregator policies, which may lead to service changes or termination.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Cancellation of Lab Tests
            Text(
              '4. Cancellation of Diagnostic Tests',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'i. You may cancel a diagnostic test booking up to 2 hours before the scheduled sample collection and reschedule as needed.\n\n'
                  'ii. Payments for cancelled tests will be refunded as outlined in the “Refunds” section below.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Refunds
            Text(
              '5. Refunds',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'i. Refunds for eligible cancellations are issued via the original payment method, except for Pay on Delivery, which uses bank transfer or health credits.\n\n'
                  'ii. Card payments will not be refunded in cash.\n\n'
                  'iii. Refunds are processed only to the account holder’s bank account, matching the name on your Revx account.\n\n'
                  'iv. Refunds require a genuine cancellation request via the Platform’s cancellation button. Requests based on delays or service outcomes are not eligible.\n\n'
                  'v. Refunds are processed within 30 business days of a valid request. Contact helpdesk@revx.com for refund inquiries.\n\n'
                  'vi. No refunds will be processed after 6 months from the cancellation request, except in exceptional cases at Revx’s discretion, where refunds may be issued as health credits.\n\n'
                  'vii. Revx may modify pricing for Services at any time before billing.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Refund Timelines
            Text(
              '6. Refund Timelines',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'i. Refunds typically take 30 business days after verification of the cancellation request, subject to bank processing times and RBI guidelines.\n\n'
                  'ii. Business days exclude Saturdays, Sundays, and public holidays. Delays may occur due to external factors like bank processing or pandemics.\n\n'
                  'iii. For Pay on Delivery, refunds are processed via National Electronic Funds Transfer (NEFT) or health credits, not cash.\n\n'
                  'iv. To process a bank refund, provide:\n'
                  '   - Bank Account Number\n'
                  '   - IFSC Code\n'
                  '   - Account Holder’s Name\n\n'
                  'v. Revx is not liable for refund delays due to third-party issues, technical problems, or incomplete information provided by you.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            // Contact Us
            Text(
              '7. Contact Us',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'For questions or refund inquiries, contact our Grievance Officer:\n'
                  '- **Name**: [Insert Name]\n'
                  '- **Email**: helpdesk@revx.com\n'
                  '- **Phone**: [Insert Phone Number]\n'
                  'Grievances will be acknowledged within 48 hours and resolved within 1 month. For escalations, contact our Grievance-cum-Nodal Officer:\n'
                  '- **Name**: [Insert Name]\n'
                  '- **Email**: helpdesk@revx.com\n'
                  '- **Phone**: [Insert Phone Number]',
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