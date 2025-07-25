// lib/services/gemini_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

/// Service to call Gemini using flutter_gemini package
class GeminiService {
  /// Ensure Gemini.init(apiKey: apiKey) is called in main()
  Future<String> callGenerativeAI(String userInput) async {
    final gemini = Gemini.instance;

    // System prompt to enforce tone, script, and style
    const String systemPrompt =
        'You are a frank and informal fitness coach. Reply in the same language and script as the user input. Be conversational and a bit more verbose—avoid bullet lists.';

    // User message with workout or greeting logic
    final String userPrompt =
        "User input: '$userInput'\n"
        "If this is a workout request, respond with a friendly, detailed workout plan in two to three sentences."
        "If user asking for a dietary plan, provide a brief, friendly suggestion."
        " If this is not a workout request (e.g., a greeting), reply with a warm, informal greeting and ask what workout goal I can help with.";

    // Create content list with the user prompt
    final messages = [
      Content(parts: [Part.text(userPrompt)], role: 'user'),
    ];

    try {
      final response = await gemini.chat(
        messages,
        modelName: 'gemini-2.5-flash',
        systemPrompt: systemPrompt,
        generationConfig: GenerationConfig(
          temperature: 0.8,
          maxOutputTokens: 200, 
        ),
        
      );
      print("GEMINI CALLED=============>");
      final output = response?.output?.trim() ?? '';
      debugPrint('[GeminiService] Response: $output');
      return output;
      // return "LLM is in building stage, sorry for the inconvenience. "
      //     "We are working on it and will be available soon. "
      //     "In the meantime, you can use the app without LLM features.";
    } catch (e) {
      debugPrint('[GeminiService] Error: $e');
      return 'Error: $e';
    }
  }
}
