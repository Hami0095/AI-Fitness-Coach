// lib/features/coach/presentation/coach_page.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '/../services/gemini_service.dart';

/// Model for chat messages
class ChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({required this.content, required this.isUser})
    : timestamp = DateTime.now();
}

/// Controller for chat logic and Gemini integration
class ChatController extends ChangeNotifier {
  final List<ChatMessage> messages = [];
  final TextEditingController textController = TextEditingController();
  final GeminiService _service = GeminiService();
  bool isLoading = false;

  final List<String> suggestions = [
    'How many days should I workout?',
    'What are effective warmups?',
    'Suggest a post-workout snack',
  ];

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    messages.add(ChatMessage(content: trimmed, isUser: true));
    notifyListeners();
    textController.clear();

    isLoading = true;
    notifyListeners();

    String reply;
    try {
      reply = await _service.callGenerativeAI(trimmed);
    } catch (_) {
      reply = 'Something went wrong. Please check your internet and try again.';
    }

    messages.add(ChatMessage(content: reply, isUser: false));
    isLoading = false;
    notifyListeners();
  }

  void chooseSuggestion(String suggestion) {
    textController.text = suggestion;
    sendMessage(suggestion);
  }
}

final chatControllerProvider = ChangeNotifierProvider((_) => ChatController());

class CoachPage extends ConsumerStatefulWidget {
  const CoachPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CoachPage> createState() => _CoachPageState();
}

class _CoachPageState extends ConsumerState<CoachPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(chatControllerProvider).addListener(_scrollToBottom);
  }

  @override
  void dispose() {
    ref.read(chatControllerProvider).removeListener(_scrollToBottom);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday, ${DateFormat('d MMMM').format(date)}';
    }
    return DateFormat('EEEE, d MMMM').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(chatControllerProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 244, 243, 244),
              Color.fromARGB(255, 193, 209, 207),
              Color.fromARGB(255, 0, 125, 115),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ─── Header: just avatar + close ─────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(136, 166, 165, 165),
                        shape: BoxShape.circle,
                      ),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {                        
                          
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // ─── Chat messages ─────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    final isUser = msg.isUser;
                    final showDate =
                        index == 0 ||
                        controller.messages[index - 1].timestamp.day !=
                            msg.timestamp.day;

                    return Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        // DATE SECTION ───────────────────────────────
                        if (showDate)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                _formatDateHeader(msg.timestamp),
                                style: GoogleFonts.poppins(
                                  color: const Color.fromARGB(179, 82, 57, 86),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                        // ─── For each assistant message, show "EMCSquare coach" label ──
                        if (!isUser)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    'assets/images/coach_dp.png',
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'EMCSquare coach',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromARGB(255, 0, 69, 63),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // ─── The actual chat bubble ─────────────────────────────
                        Row(
                          mainAxisAlignment: isUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isUser) const SizedBox(width: 32),
                            Flexible(
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isUser
                                      ? const Color.fromARGB(255, 0, 33, 31)
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(16),
                                    topRight: const Radius.circular(16),
                                    bottomLeft: Radius.circular(
                                      isUser ? 16 : 0,
                                    ),
                                    bottomRight: Radius.circular(
                                      isUser ? 0 : 16,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  msg.content,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: isUser ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),

              // ─── Suggestions ───────────────────────────────────────────
              SizedBox(
                height: 40,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.suggestions.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) => ActionChip(
                    label: Text(
                      controller.suggestions[i],
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    backgroundColor: const Color.fromARGB(
                      85,
                      255,
                      255,
                      255,
                    ).withOpacity(0.5),
                    onPressed: () =>
                        controller.chooseSuggestion(controller.suggestions[i]),
                  ),
                ),
              ),
              const Divider(color: Colors.white54, height: 1),

              // ─── Input area ─────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: TextField(
                          controller: controller.textController,
                          style: GoogleFonts.poppins(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: GoogleFonts.poppins(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller.textController,
                      builder: (context, value, _) {
                        final text = value.text.trim();
                        final isLoading = controller.isLoading;
                        final hasText = text.isNotEmpty;

                        IconData icon;
                        Color bg, iconColor;
                        if (isLoading) {
                          icon = Icons.pause;
                          bg = Colors.black;
                          iconColor = Colors.white;
                        } else if (hasText) {
                          icon = Icons.arrow_upward;
                          bg = Colors.black;
                          iconColor = Colors.white;
                        } else {
                          icon = Icons.arrow_upward;
                          bg = Colors.white;
                          iconColor = Colors.black;
                        }

                        return GestureDetector(
                          onTap: (!hasText || isLoading)
                              ? null
                              : () => controller.sendMessage(text),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: bg,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(icon, color: iconColor),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
