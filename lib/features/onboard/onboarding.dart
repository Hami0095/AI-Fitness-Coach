import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Riverpod provider for shared preferences-backed settings
final prefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  // Controllers for testimonial carousel
  final PageController _testimonialController = PageController();
  int _testimonialPage = 0;


  // User selections
  String? bodyType;
  List<String> injuries = [];
  bool wantCardio = false;
  String? weeklyActivity;
  String scheduleType = 'Smart schedule';
  String? workoutsPerWeek;
  TimeOfDay previewTime = const TimeOfDay(hour: 9, minute: 0);
  String? trainingTime;
  String? preferredTimeOfDay;
  String? durationChoice;

  @override
  void initState() {
    super.initState();
    print('OnboardingScreen initialized');
    _loadPreferences();
  }

  /// Load preferences and redirect if onboarding already done
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool('onboardingDone') ?? false;
    if (done) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // if (mounted) context.go('/main');
      });
      return;
    }
    setState(() {
      bodyType = prefs.getString('bodyType');
      injuries = prefs.getStringList('injuries') ?? [];
      wantCardio = prefs.getBool('wantCardio') ?? false;
      weeklyActivity = prefs.getString('weeklyActivity');
      scheduleType = prefs.getString('scheduleType') ?? 'Smart schedule';
      workoutsPerWeek = prefs.getString('workoutsPerWeek');
      final h = prefs.getInt('previewHour');
      if (h != null)
        previewTime = TimeOfDay(
          hour: h,
          minute: prefs.getInt('previewMinute') ?? 0,
        );
      trainingTime = prefs.getString('trainingTime');
      preferredTimeOfDay = prefs.getString('preferredTimeOfDay');
      durationChoice = prefs.getString('durationChoice');
    });
  }

  Future<void> _savePref(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) await prefs.setString(key, value);
    if (value is bool) await prefs.setBool(key, value);
    if (value is List<String>) await prefs.setStringList(key, value);
    if (value is int) await prefs.setInt(key, value);
  }

  List<Widget> get _pages => [
    _buildStaticIntro(
      'assets/images/gym_intro.png',
      'Your Personal Training Journey',
      'Kickstart transformation with AI-driven workouts tailored to you.',
    ),
    
    _buildBodyTypeGridPage(),


    _buildInjuryGridPage(),

    // _buildChoicePage(
    //   title: 'Are Any Areas Of Your Body Injured?',
    //   subtitle: 'Your plan will protect these areas.',
    //   options: ['None', 'Back', 'Knee', 'Shoulders'],
    //   multiSelect: true,
    //   onSelect: (value)=> {},
    //   selectedList: injuries,
    //   onSelectMulti: (list) => setState(() {
    //     injuries = list;
    //     _savePref('injuries', list);
    //   }),
    // ),

    _buildChoicePage(
      title: 'Should I add cardio to your plan?',
      assetImage: 'assets/images/cardio.png',
      options: ['Yes', 'Not Now'],
      selected: wantCardio ? 'Yes' : 'Not Now',
      onSelect: (v) => setState(() {
        wantCardio = v == 'Yes';
        _savePref('wantCardio', wantCardio);
      }),
    ),
    _buildChoicePage(
      title: 'Do You Do Any Of These Activities More Than Once A Week?',
      options: [
        'None',
        'Cardio',
        'Flexibility',
        'Martial arts',
        'Race training',
        'Sports',
        'Strength training',
        'Mixed modal training',
      ],
      selected: weeklyActivity,
      onSelect: (v) => setState(() {
        weeklyActivity = v;
        _savePref('weeklyActivity', v);
      }),
    ),
    _buildFrequencyPage(),
    _buildPreviewWorkoutPage(),
    _buildPreferredTimePage(),
    _buildAdjustmentPage(),
    _buildTestimonialsPage(),
    _buildPlanPreviewPage(),
    _buildSubscriptionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentIndex = i),
                children: _pages,
              ),
            ),
            _buildIndicator(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildNextButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() => Align(
    alignment: Alignment.topLeft,
    child: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        if (_currentIndex > 0) {
          _controller.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          context.go('/');
        }
      },
    ),
  );

  Widget _buildIndicator() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      _pages.length,
      (i) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: _currentIndex == i ? 24 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: _currentIndex == i ? Colors.greenAccent : Colors.grey.shade800,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
  );

  Widget _buildNextButton() {
    final isLast = _currentIndex == _pages.length - 1;
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          if (isLast) {
            await _savePref('onboardingDone', true);
            context.go('/main');
          } else {
            _controller.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.greenAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(
          isLast ? 'Continue' : 'Next',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStaticIntro(String asset, String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(asset, height: MediaQuery.of(context).size.height * 0.5),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


  Widget _buildBodyTypeGridPage() {
    const options = [
      'Skinny',
      'Average',
      'Muscular',
      'Slightly extra',
      'Extra',
    ];
    const images = {
      'Skinny': 'assets/images/skinny.png',
      'Average': 'assets/images/average.png',
      'Muscular': 'assets/images/muscular.png',
      'Slightly extra': 'assets/images/overweight.png',
      'Extra': 'assets/images/obese.png',
    };
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How Do You See Your Body?',
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              itemCount: options.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                final o = options[index];
                final selected = bodyType == o;
                return GestureDetector(
                  onTap: () => setState(() {
                    bodyType = o;
                    _savePref('bodyType', o);
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.greenAccent.withOpacity(0.2)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? Colors.greenAccent
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            images[o]!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          o,
                          style: TextStyle(
                            color: selected ? Colors.greenAccent : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildChoicePage({
    required String title,
    String? subtitle,
    String? assetImage,
    required List<String> options,
    String? selected,
    List<String>? selectedList,
    bool multiSelect = false,
    required void Function(String) onSelect,
    void Function(List<String>)? onSelectMulti,
    Map<String, String>? optionImages,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (assetImage != null)
            Center(child: Image.asset(assetImage, height: MediaQuery.of(context).size.height * 0.45)),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          if (subtitle != null)
            Text(subtitle, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 16),
          ...options.map((o) {
            final isSelected = multiSelect
                ? selectedList?.contains(o) == true
                : selected == o;
            return Card(
              color: isSelected ? Colors.black : Colors.white,
              child: ListTile(
                leading: optionImages != null && optionImages.containsKey(o)
                    ? Image.asset(optionImages[o]!, width: 48, height: 48)
                    : null,
                title: Text(
                  o,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () {
                  if (multiSelect &&
                      selectedList != null &&
                      onSelectMulti != null) {
                    final list = List<String>.from(selectedList);
                    list.contains(o) ? list.remove(o) : list.add(o);
                    onSelectMulti(list);
                  } else {
                    onSelect(o);
                  }
                },
              ),
            );
          }),
        ],
      ),
    );
  }


  Widget _buildInjuryGridPage() {
    const images = {
      'Back': 'assets/images/back.png',
      'Knee': 'assets/images/knee.png',
      'Shoulders': 'assets/images/shoulder.png',
    };
    bool isSelected(String o) => injuries.contains(o);

    Widget tile(String o) {
      final sel = isSelected(o);
      return GestureDetector(
        onTap: () {
          setState(() {
            if (sel)
              injuries.remove(o);
            else
              injuries.add(o);
            _savePref('injuries', injuries);
          });
        },
        child: Container(
          width: 140,
          decoration: BoxDecoration(
            color: sel ? Colors.greenAccent.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: sel ? Colors.greenAccent : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  images[o]!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                o,
                style: TextStyle(
                  color: sel ? Colors.greenAccent : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are Any Areas Of Your Body Injured?',
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              'Your plan will protect these areas.',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [tile('Shoulders'), tile('Knee')],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [tile('Back')],
          ),
        ],
      ),
    );
  }

  

  Widget _buildFrequencyPage() => _buildChoicePage(
    title: 'How often do you want to workout?',
    options: [for (var i = 1; i <= 6; i++) '$i workouts/week', 'Every day'],
    selected: workoutsPerWeek,
    onSelect: (v) => setState(() {
      workoutsPerWeek = v;
      _savePref('workoutsPerWeek', v);
    }),
  );

  Widget _buildPreviewWorkoutPage() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Do you want a preview of your workout?',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 12),
          ListTile(
            title: const Text('Time to receive preview', style: TextStyle(color: Colors.white),),
            trailing: Text('${previewTime.format(context)}', style: const TextStyle(color: Colors.white)),
            onTap: () async {
              final t = await showTimePicker(
                context: context,
                initialTime: previewTime,
              );
              if (t != null) {
                setState(() {
                  previewTime = t;
                  _savePref('previewHour', t.hour);
                  _savePref('previewMinute', t.minute);
                });
              }
            },
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => _savePref('notificationsEnabled', true),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text('Enable Notifications', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferredTimePage() => _buildChoicePage(
    title: 'When do you prefer to work out?',
    options: ['Morning', 'Afternoon', 'Evening', 'At Different Times'],
    selected: preferredTimeOfDay,
    onSelect: (v) => setState(() {
      preferredTimeOfDay = v;
      _savePref('preferredTimeOfDay', v);
    }),
  );

   Widget _buildAdjustmentPage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'assets/images/adjustment_background.jpg',
            fit: BoxFit.cover,
          ),
        ),
        // Overlay content
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Adjusting workout program to your fitness profile',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: LinearProgressIndicator(
                value: 0.78,
                backgroundColor: Colors.grey.shade800,
                valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Trusted by 98,425 users',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }


   Widget _buildTestimonialsPage() {
    final testimonials = [
      {
        'text': 'I love EMCSQUARE! It completely changed my fitness journey.',
        'author': 'Alex',
        'username': '@alex_fit',
        'avatar': 'assets/images/alex_profile.png',
      },
      {
        'text': 'Great workouts and AI insights keep me motivated every day.',
        'author': 'Jamie',
        'username': '@jamie_moves',
        'avatar': 'assets/images/jamie_profile.png',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset('assets/images/testimony.png', height: MediaQuery.of(context).size.height * 0.35,)),
          const Text(
            'What Our Users Say',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              height: 240,
              child: PageView.builder(
                controller: _testimonialController,
                itemCount: testimonials.length,
                onPageChanged: (idx) => setState(() => _testimonialPage = idx),
                itemBuilder: (context, idx) {
                  final t = testimonials[idx];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(t['avatar']!),
                            ),
                            title: Text(
                              t['author']!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              t['username']!,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              '"' + t['text']! + '"',
                              style: GoogleFonts.lato(
                                color: Colors.black87,
                                fontSize: 16,
                              ),                            
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              testimonials.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _testimonialPage == i ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _testimonialPage == i
                      ? Colors.greenAccent
                      : Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildPlanPreviewPage() {
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.all(16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           'Plan preview',
  //           style: TextStyle(color: Colors.white, fontSize: 24),
  //         ),
  //         const SizedBox(height: 16),
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.grey[200],
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           padding: const EdgeInsets.all(16),
  //           child: Column(
  //             children: List.generate(4, (week) {
  //               return Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 8),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       'Week ${week + 1}',
  //                       style: TextStyle(color: Colors.grey[600]),
  //                     ),
  //                     Row(
  //                       children: List.generate(
  //                         3,
  //                         (i) => Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 8),
  //                           child: Column(
  //                             children: const [
  //                               Icon(
  //                                 Icons.fitness_center,
  //                                 size: 40,
  //                                 color: Colors.grey,
  //                               ),
  //                               Text(
  //                                 'x12',
  //                                 style: TextStyle(color: Colors.black),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }),
  //           ),
  //         ),
  //         const SizedBox(height: 24),
  //         const Text(
  //           'Community Testimonials',
  //           style: TextStyle(color: Colors.black, fontSize: 24),
  //         ),
  //         SizedBox(
  //           height: 150,
  //           child: PageView(
  //             children: [
  //               Card(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(16),
  //                   child: const Text('"Incredible results!" - Sam'),
  //                 ),
  //               ),
  //               Card(
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(16),
  //                   child: const Text('"Highly recommend." - Lee'),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         SizedBox(
  //           width: double.infinity,
  //           child: ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(24),
  //               ),
  //             ),
  //             onPressed: () {},
  //             child: const Text('Get My Plan'),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  
  Widget _buildPlanPreviewPage() {
    // Accent color
    const accentGreen = Color(0xFF00E676);

    // Plan data placeholders
    final weeks = List.generate(4, (i) => 'Week ${i + 1}');

    // Testimonials
    final testimonials = [
      {
        'avatar': 'assets/images/user1.png',
        'quote': '“Incredible results in just 4 weeks!”',
        'author': '– Sam',
      },
      {
        'avatar': 'assets/images/user2.png',
        'quote': '“The AI plan was spot-on and easy to follow.”',
        'author': '– Alex',
      },
      {
        'avatar': 'assets/images/user3.png',
        'quote': '“Never felt stronger; this plan works!”',
        'author': '– Jordan',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const SizedBox(width: 8),
              const Text(
                'Plan Preview',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // AI Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: accentGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'AI Generated',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          // Plan Card
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: weeks.map((week) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          week,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Three exercise thumbs
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(3, (i) {
                            return Column(
                              children: [
                                // Replace with real GIF thumbnails
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset('assets/images/dumbbell.png', height: 24),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'x12',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 24),
          // Testimonials header
          const Text(
            'Success Stories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Testimonials list
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: testimonials.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final t = testimonials[i];
                return Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(t['avatar']!),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          t['quote']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          t['author']!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
          // Get My Plan button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: accentGreen,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Get My Plan',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionPage() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () => context.go('/main'),
            child: const Text('X', style: TextStyle(color: Colors.black)),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/subscription.png', height: MediaQuery.of(context).size.height * 0.35),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Get unlimited access to your personal plan!',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: Row(
                  children: [
                    _planOption('1 Month', 'Rs 5,300.00/month', false),
                    _planOption('12 Months', 'Rs 16,700.00/year', true),
                    _planOption('3 Months', 'Rs 8,300.00/3 months', false),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Try free for 7 days', style: TextStyle(color: Colors.white)),
                value: false,
                onChanged: (v) {},
              ),
              const Spacer(),
              
            ],
          ),
        ),
      ],
    );
  }

  Widget _planOption(String title, String subtitle, bool selected) => Container(
    padding: const EdgeInsets.all(12),
    width: MediaQuery.of(context).size.width * 0.3,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: selected ? Colors.greenAccent : Colors.grey[200],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.black)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: Colors.black54)),
      ],
    ),
  );
}
