// lib/screens/terms_of_use_screen.dart

import 'package:flutter/material.dart';

/// A full Terms of Use screen matching the app’s design with in-page navigation.
class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({Key? key}) : super(key: key);

  @override
  _TermsConditionsScreenState createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  final ScrollController _scrollController = ScrollController();

  // Section keys
  final GlobalKey section1Key = GlobalKey();
  final GlobalKey section2Key = GlobalKey();
  final GlobalKey section3Key = GlobalKey();
  final GlobalKey section4Key = GlobalKey();
  final GlobalKey section5Key = GlobalKey();
  final GlobalKey section6Key = GlobalKey();
  final GlobalKey section7Key = GlobalKey();
  final GlobalKey section8Key = GlobalKey();
  final GlobalKey section9Key = GlobalKey();
  final GlobalKey section10Key = GlobalKey();
  final GlobalKey section11Key = GlobalKey();
  final GlobalKey section12Key = GlobalKey();
  final GlobalKey section13Key = GlobalKey();
  final GlobalKey section14Key = GlobalKey();
  final GlobalKey section15Key = GlobalKey();
  final GlobalKey section16Key = GlobalKey();
  final GlobalKey section17Key = GlobalKey();
  final GlobalKey section18Key = GlobalKey();
  final GlobalKey section19Key = GlobalKey();
  final GlobalKey section20Key = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildTOCItem(int index, String title, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () => _scrollToSection(key),
        child: Text(
          '$index. $title',
          style: const TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _section(GlobalKey key, String heading, List<Widget> content) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...content,
        ],
      ),
    );
  }

  Text _body(String text) => Text(text, style: const TextStyle(fontSize: 16));

  static const List<String> _tocTitles = [
    'Registration and Eligibility',
    'Important Disclaimers',
    'Your Use of our Services',
    'Subscriptions',
    'License',
    'Indemnification',
    'Use at Your Own Risk',
    'Warranty Disclaimer',
    'Limitation of Liability',
    'Export and Economic Sanctions Control',
    'Third-Party Services and Links',
    'Your Feedback',
    'Changes to the Services',
    'Changes to the Terms',
    'Termination',
    'Severability',
    'Copyright Claims',
    'Dispute Resolution by Binding Arbitration',
    'Miscellaneous',
    'Contact Details',
  ];

  List<GlobalKey> get _sectionKeys => [
    section1Key,
    section2Key,
    section3Key,
    section4Key,
    section5Key,
    section6Key,
    section7Key,
    section8Key,
    section9Key,
    section10Key,
    section11Key,
    section12Key,
    section13Key,
    section14Key,
    section15Key,
    section16Key,
    section17Key,
    section18Key,
    section19Key,
    section20Key,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Terms of Use',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Effective date: March 25, 2025',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Text(
                'Table of Contents',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              for (var i = 0; i < _tocTitles.length; i++)
                _buildTOCItem(i + 1, _tocTitles[i], _sectionKeys[i]),
              const SizedBox(height: 24),

              // Section 1
              _section(section1Key, '1. Registration and Eligibility', [
                _body(
                  'Minimum Age: You must be at least 18 years old to use and access the App...',
                ),
                const SizedBox(height: 8),
                _body(
                  'Registration: You must provide accurate and complete information...',
                ),
              ]),

              // Section 2
              _section(section2Key, '2. Important Disclaimers', [
                _body(
                  'a. General disclaimer: Exercise and health vary from person to person...',
                ),
                const SizedBox(height: 8),
                _body(
                  'b. Exercise disclaimer: Workouts provided are for educational purposes...',
                ),
                const SizedBox(height: 8),
                _body(
                  'c. Information disclaimer: Information provided is for educational purposes...',
                ),
                const SizedBox(height: 8),
                _body(
                  'd. Medical disclaimer: By using our Services, you affirm your physician...',
                ),
              ]),

              // Section 3
              _section(section3Key, '3. Your Use of our Services', [
                _body(
                  'Privacy: Please refer to our Privacy Policy for how we collect...',
                ),
                const SizedBox(height: 8),
                _body('Prohibited Conduct:'),
                const SizedBox(height: 4),
                for (var item in [
                  'Resell, rent, lease, sublicense, distribute, or otherwise transfer rights...',
                  'Engage in harassing, threatening, intimidating conduct...',
                  'Use Services in a way that impairs others’ use...',
                  'Modify, reverse engineer, decompile, or disassemble...',
                  'Copy, adapt, create derivative works without authorization...',
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• '),
                        Expanded(child: _body(item)),
                      ],
                    ),
                  ),
              ]),

              // Section 4
              _section(section4Key, '4. Subscriptions', [
                _body(
                  'Free or paid trial: We may offer a trial subscription...',
                ),
                const SizedBox(height: 8),
                _body('Auto-renewal: The subscription renews automatically...'),
                const SizedBox(height: 8),
                _body(
                  'Payment method: Payment will be charged to your billing method...',
                ),
                const SizedBox(height: 8),
                _body(
                  'Cancellation: Your subscription can be canceled via the platform used...',
                ),
                const SizedBox(height: 8),
                _body(
                  'Refunds: Please refer to our Refund Policy for details.',
                ),
              ]),

              // Section 5
              _section(section5Key, '5. License', [
                _body(
                  'We grant you a personal, worldwide, revocable, non-transferable...',
                ),
                const SizedBox(height: 8),
                _body(
                  'All rights, title and interest in the Services are owned by the Company...',
                ),
              ]),

              // Section 6
              _section(section6Key, '6. Indemnification', [
                _body(
                  'You agree to defend, indemnify, and hold harmless the Company...',
                ),
              ]),

              // Section 7
              _section(section7Key, '7. Use at Your Own Risk', [
                _body('Your use of the Services is at your sole risk...'),
              ]),

              // Section 8
              _section(section8Key, '8. Warranty Disclaimer', [
                _body(
                  'The Services are provided “as is” and “as available”...',
                ),
              ]),

              // Section 9
              _section(section9Key, '9. Limitation of Liability', [
                _body(
                  'In no event shall the Company be liable for any indirect...',
                ),
              ]),

              // Section 10
              _section(
                section10Key,
                '10. Export and Economic Sanctions Control',
                [
                  _body(
                    'You agree to comply with all export laws and regulations...',
                  ),
                ],
              ),

              // Section 11
              _section(section11Key, '11. Third-Party Services and Links', [
                _body(
                  'Our Services may include links to third-party websites...',
                ),
              ]),

              // Section 12
              _section(section12Key, '12. Your Feedback', [
                _body(
                  'We welcome your feedback. Communications you send to us...',
                ),
              ]),

              // Section 13
              _section(section13Key, '13. Changes to the Services', [
                _body('We may modify the Terms from time to time...'),
              ]),

              // Section 14
              _section(section14Key, '14. Changes to the Terms', [
                _body(
                  'We may update the Terms; updates will be posted here...',
                ),
              ]),

              // Section 15
              _section(section15Key, '15. Termination', [
                _body(
                  'We may terminate your access at any time without notice...',
                ),
              ]),

              // Section 16
              _section(section16Key, '16. Severability', [
                _body('If any provision of the Terms is unenforceable...'),
              ]),

              // Section 17
              _section(section17Key, '17. Copyright Claims', [
                _body('If you believe materials infringe your copyright...'),
              ]),

              // Section 18
              _section(
                section18Key,
                '18. Dispute Resolution by Binding Arbitration',
                [
                  _body(
                    'Disputes will be resolved by binding arbitration under JAMS...',
                  ),
                ],
              ),

              // Section 19
              _section(section19Key, '19. Miscellaneous', [
                _body('Entire Agreement, No Waiver, Third-Party Rights,...'),
              ]),

              // Section 20
              _section(section20Key, '20. Contact Details', [
                _body(
                  'For questions, feedback, or claims, contact us at support@EMCSquare.coach',
                ),
                const SizedBox(height: 4),
                _body(
                  'EMCSquare Coach, Inc.\n100 S. Dixie Hwy, Suite 3170\nWest Palm Beach, FL 33401',
                ),
              ]),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
