import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_application_1/models/message_model.dart';
import 'package:flutter_application_1/widgets/empty_view.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController controller = TextEditingController();
  final List<ChatMessage> messages = [];
  bool isLoading = false;

  late stt.SpeechToText speech;
  bool isListening = false;

  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }

  Future<void> sendMessages() async {
    final text = controller.text;
    setState(() {
      messages.add(ChatMessage(text: text.toString(), isUser: true));
    });
    controller.clear();
    try {
      final response = await Gemini.instance.prompt(parts: [Part.text(text)]);
      final reply = response?.output ?? "Sorry, I have no response.";
      setState(() {
        messages.add(ChatMessage(text: reply.toString(), isUser: false));
      });
    } catch (e) {
      setState(() {
        messages.add(ChatMessage(text: "Error:$e", isUser: false));
      });
    }
  }

  // 🎤 Start or stop listening
  void toggleListening() async {
    if (!isListening) {
      bool available = await speech.initialize(
        onStatus: (val) {
          if (val == "done") {
            setState(() {
              isListening = false;
            });
          }
        },
        onError: (val) {
          setState(() {
            isListening = false;
          });
        },
      );
      if (available) {
        setState(() => isListening = true);
        speech.listen(
          onResult: (val) {
            setState(() {
              controller.text = val.recognizedWords;
            });
          },
        );
      }
    } else {
      setState(() => isListening = false);
      speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            children: [
              Image.asset('assets/images/RRB.png', width: 30),
              SizedBox(width: 8),
              Text('GP Bot', style: TextStyle(color: Colors.white)),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  messages.clear();
                });
              },
              icon: const Icon(Icons.restart_alt, color: Colors.white),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              messages.isEmpty
                  ? emptyview()
                  : Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return Align(
                            alignment: message.isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: message.isUser
                                    ? Colors.grey
                                    : Colors.black,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(
                                    message.isUser ? 20 : 0,
                                  ),
                                  bottomRight: Radius.circular(
                                    message.isUser ? 0 : 20,
                                  ),
                                ),
                              ),
                              child: Text(
                                messages[index].text,
                                style: TextStyle(
                                  color: message.isUser
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

              // const SizedBox(height: 50),
              // Image.asset('assets/images/hi_bot.png', height: 220),
              // const SizedBox(height: 20),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade200,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //      Icon(Icons.star, color: Colors.black87),
              //       SizedBox(width: 5),
              //       Text(
              //         'Hi,you can ask me anything!',
              //         style: TextStyle(color: Colors.black87),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.all(12.0),
              //   decoration: BoxDecoration(
              //     color: Colors.black,
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(20),
              //       topRight: Radius.circular(20),
              //       bottomLeft: Radius.circular(20),
              //       bottomRight: Radius.circular(0),
              //     ),
              //   ),
              //   child: Text(
              //     'hello how are you?',
              //     style: TextStyle(fontSize: 20, color: Colors.white),
              //   ),
              // ),
              // SizedBox(height: 10),
              // Container(
              //   padding: const EdgeInsets.all(12.0),
              //   decoration: BoxDecoration(
              //     color: Colors.grey,
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(20),
              //       topRight: Radius.circular(20),
              //       bottomLeft: Radius.circular(0),
              //       bottomRight: Radius.circular(20),
              //     ),
              //   ),
              //   child: Text(
              //     'I am fine',
              //     style: TextStyle(fontSize: 20, color: Colors.black),
              //   ),
              // ),

              // Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),

                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadiusDirectional.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(
                                255,
                                35,
                                236,
                                9,
                              ).withOpacity(0.9),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: size.width * 0.6,

                                child: TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    hintText: "Ask me anything......",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: toggleListening,
                              child: Icon(
                                isListening ? Icons.mic : Icons.mic_none,
                                color: isListening ? Colors.red : Colors.black,
                              ),
                            ),
                            //SizedBox(width: size.width * 0.08),
                            // const SizedBox(width: 20),

                            // CircleAvatar(
                            //   backgroundColor: Colors.black,
                            //   child: IconButton(
                            //     onPressed: sendMessages,
                            //     icon: Icon(Icons.send, color: Colors.white),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),

                    CircleAvatar(
                      backgroundColor: Colors.black,
                      child: IconButton(
                        onPressed: sendMessages,
                        icon: Icon(Icons.send, color: Colors.white),
                      ),
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
