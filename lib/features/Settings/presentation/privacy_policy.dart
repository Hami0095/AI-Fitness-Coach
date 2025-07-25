// lib/screens/privacy_policy_screen.dart

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// A comprehensive Privacy Policy page with 13 detailed sections and clickable links.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(
      context,
    ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18);
    final titleStyle = Theme.of(
      context,
    ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 22);
    final bodyStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontSize: 14, height: 1.5);
    final linkStyle = bodyStyle?.copyWith(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    );

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Effective date: March 11, 2025',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Intro Paragraph
            RichText(
              text: TextSpan(
                style: bodyStyle,
                children: [
                  const TextSpan(
                    text:
                        'Welcome to EMCSquare Coach Inc., a leading provider of personalized fitness and wellness solutions (“we”, “us”, or “our”). This Privacy Policy explains how we collect, use, disclose, and safeguard your personal information when you visit our website ',
                  ),
                  TextSpan(
                    text: 'https://EMCSquare.coach',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchUrl('https://EMCSquare.coach'),
                  ),
                  const TextSpan(text: ' (including affiliated pages such as '),
                  TextSpan(
                    text: 'https://EMCSquare-gym.coach',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchUrl('https://EMCSquare-gym.coach'),
                  ),
                  const TextSpan(
                    text:
                        ') and our mobile application (the “App”), collectively referred to as the “Services”. By accessing or using our Services, you consent to the practices described in this policy. If you do not agree with any part of this Privacy Policy, you may discontinue use of the Services at any time.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 1. Personal Data We Collect
            Text('1. Personal Data We Collect', style: titleStyle),
            const SizedBox(height: 12),
            Text(
              'We collect information that you provide directly and information that is collected automatically when you use the Services. This data helps us personalize your experience, improve our Service offerings, and ensure the security and functionality of our platform.',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Text('a. Data You Provide Directly:', style: headingStyle),
            const SizedBox(height: 6),
            Text(
              '• Account Registration Data: Your name, email address, date of birth, gender (optional), and account credentials (password).',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Profile Information: Profile photograph, weight, height, physical measurements, and other health-related details you choose to share.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Health & Fitness Data: Workout history, exercise preferences, fitness goals, injuries, and any data imported from third-party health platforms such as Google Health Connect or Apple HealthKit.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• AI Assistant Interactions: Conversation logs and messages exchanged with our AI-powered coaching assistant.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Body Scan Photos & Reports: Images you upload for pose and body composition analysis, along with analytical outputs generated by our systems (with your explicit consent).',
              style: bodyStyle,
            ),
            const SizedBox(height: 12),
            Text('b. Data Collected Automatically:', style: headingStyle),
            const SizedBox(height: 6),
            Text(
              '• Usage Metrics: Features accessed, session duration, time stamps, and navigation patterns.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Log Data: IP addresses, device type and model, operating system version, browser type for web access, and crash reports.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Technical Data: Unique device identifiers (e.g., advertising ID, installation ID), screen resolution, network information, sensor data (e.g., accelerometer during workouts).',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Tracking Technologies: Cookies, web beacons, SDKs, and similar technologies that track usage patterns and preferences.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 2. Purpose of Processing
            Text('2. Purpose of Processing', style: titleStyle),
            const SizedBox(height: 12),
            Text(
              'We use your personal data for the following purposes:',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Text(
              '• Service Delivery & Personalization: To create and maintain your account, deliver tailored workout plans, personalized coaching tips, and dynamic body scan reports.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Product Improvement & Research: To conduct data analytics, A/B testing, and research aimed at enhancing features, user interface, and the overall user journey.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Customer Support & Communication: To respond to your questions, troubleshoot technical issues, send service-related notifications, and provide updates on new features.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Marketing & Promotions: With your opt-in consent, to send newsletters, promotional emails, and other marketing communications about our Services and third-party offers we believe you may find valuable.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Legal, Compliance & Security: To comply with applicable laws and regulations, enforce our Terms of Service, fight spam and abuse, safeguard our systems, and detect fraudulent or malicious activity.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 3. Legal Bases for Processing
            Text(
              '3. Legal Bases for Processing (for EU, EEA, UK, or Swiss Users)',
              style: titleStyle,
            ),
            const SizedBox(height: 12),
            Text(
              'If you are located in the European Economic Area, United Kingdom, or Switzerland, we rely on the following legal bases under data protection laws:',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Text(
              '• Contractual Necessity: Processing necessary to fulfill our contractual obligations (e.g., account management, delivery of Services).',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Legal Obligation: Processing required to comply with legal requirements (e.g., financial recordkeeping, responding to lawful requests by public authorities).',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Consent: For processing sensitive data such as health-related information, body scan images, and marketing communications where required by law.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Legitimate Interests: For purposes such as improving our Services, protecting against fraud, ensuring network and information security, and conducting internal analytics, provided your rights do not override those interests.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 4. Additional U.S. State Disclosures
            Text('4. Additional U.S. State Disclosures', style: titleStyle),
            const SizedBox(height: 12),
            Text(
              'Residents of certain U.S. states (e.g., California, Virginia) have specific rights regarding their personal data. These rights may include:',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Text(
              '• Right to Know: The right to request categories of personal data collected and the purpose for collection.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Right to Access: The right to access the specific pieces of personal data we hold about you.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Right to Delete: The right to request deletion of personal data we collected from you, subject to certain exceptions.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Right to Opt-Out: The right to opt-out of the sale or sharing of personal data (we do not sell personal data for monetary value).',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Right to Non-Discrimination: The right not to be discriminated against for exercising these rights.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 5. Personal Data Retention
            Text('5. Personal Data Retention', style: titleStyle),
            const SizedBox(height: 12),
            Text(
              'We retain personal data only as long as necessary to fulfill the purposes outlined in this Privacy Policy, including to satisfy legal, accounting, or reporting requirements. Specifically:',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Text(
              '• Account Data: Retained while your account is active and for up to 3 years after account deletion or inactivity, unless a longer retention period is required by law.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Transaction Records: Retained for at least 7 years to comply with financial recordkeeping requirements.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Health & Fitness Data: Retained for the duration of your account plus an additional period of up to one year to support trending and historical reporting, unless you request deletion.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Marketing & Consent Records: Retained until you withdraw consent or unsubscribe, plus an additional 3 years to demonstrate consent compliance.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 6. Privacy Rights
            Text('6. Privacy Rights', style: titleStyle),
            const SizedBox(height: 12),
            Text(
              'Depending on your jurisdiction, you may have the right to:',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Text(
              '• Access: Request a copy of your personal data in a portable format.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Rectification: Request correction of inaccurate or incomplete data.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Erasure: Request deletion of your personal data, subject to legal obligations.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Restriction: Request the restriction of processing of your personal data.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Objection: Object to processing based on legitimate interests or direct marketing.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Withdrawal of Consent: Withdraw previously given consent at any time without affecting prior processing.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Lodge a Complaint: With your local data protection authority if you believe your rights have been violated.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 7. Security Measures
            Text('7. Security Measures', style: titleStyle),
            const SizedBox(height: 12),
            Text(
              'We implement a range of technical and organizational measures to protect your personal data against unauthorized access, loss, misuse or alteration, including:',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Text(
              '• Encryption: TLS for data in transit and AES-256 for data at rest.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Access Controls: Role-based access permissions and multi-factor authentication for employees.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Monitoring & Audits: Regular security assessments, vulnerability scans, and penetration tests.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Data Minimization: Limiting collection and retention to only what is necessary.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 8. Children
            Text('8. Children', style: titleStyle),
            const SizedBox(height: 12),
            Text(
              'Our Services are intended for users aged 16 and older. We do not knowingly collect personal data from children under 16. If we become aware that we have inadvertently collected data of a child under 16, we will take steps to delete such information as soon as possible. If you believe we might have any data from a child under 16, please contact us.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 9. Sharing of Your Personal Data
            Text('9. Sharing of Your Personal Data', style: titleStyle),
            const SizedBox(height: 12),
            Text(
              'We may share your personal data with certain third parties under the following circumstances:',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Text(
              '• Service Providers: Companies providing hosting, analytics, payment processing, customer support, and other services on our behalf.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Affiliates & Acquirers: Corporate affiliates, or third parties involved in a merger or acquisition.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Legal & Compliance: Courts, law enforcement agencies, or other government bodies when required by law or to protect our rights.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• User Consent: With your explicit consent for purposes not described in this policy.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 10. Cookies, Software Development Kits, and Other Tracking Technologies
            Text(
              '10. Cookies, Software Development Kits, and Other Tracking Technologies',
              style: titleStyle,
            ),
            const SizedBox(height: 12),
            Text(
              'We use various tracking technologies to enhance functionality, security, and user experience, including:',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Text(
              '• Cookies: Small data files stored on your device to remember preferences and sessions.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• SDKs & APIs: Third-party libraries for analytics, crash reporting, and advertising (e.g., Firebase, Google Analytics, Facebook SDK).',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Mobile Identifiers: Advertising IDs and installation UUIDs for attribution and ad targeting.',
              style: bodyStyle,
            ),
            const SizedBox(height: 4),
            Text(
              '• Pixel Tags & Web Beacons: Invisible images used to track email opens and website visits.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 11. Your Choices About Our Communications
            Text(
              '11. Your Choices About Our Communications',
              style: titleStyle,
            ),
            const SizedBox(height: 12),
            Text(
              'You may choose how we communicate with you by:',
              style: bodyStyle,
            ),
            const SizedBox(height: 8),
            Text(
              '• Email Preferences: Unsubscribe from marketing emails via the link in each email or by contacting ',
            ),
            RichText(
              text: TextSpan(
                style: bodyStyle,
                children: [
                  const TextSpan(text: ''),
                  TextSpan(
                    text: 'support@EMCSquare.coach',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchUrl('mailto:support@EMCSquare.coach'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '• In-App Notifications: Opt-out or customize notification settings in the App’s Settings menu.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 12. Changes to Our Privacy Policy
            Text('12. Changes to Our Privacy Policy', style: titleStyle),
            const SizedBox(height: 12),
            Text(
              'We may update this Privacy Policy from time to time in response to business and regulatory changes. We will post the revised policy on this page with an updated “Effective Date”. Continued use of the Services after any changes indicates your acceptance of the new terms.',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),

            // 13. Contact Us
            Text('13. Contact Us', style: titleStyle),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: bodyStyle,
                children: [
                  const TextSpan(
                    text:
                        'If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us at ',
                  ),
                  TextSpan(
                    text: 'support@EMCSquare.coach',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _launchUrl('mailto:support@EMCSquare.coach'),
                  ),
                  const TextSpan(
                    text:
                        '. We strive to respond to all inquiries within 30 days.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
