import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatSupport extends StatefulWidget {
  const ChatSupport({super.key});

  @override
  State<ChatSupport> createState() => _ChatSupportState();
}

class _ChatSupportState extends State<ChatSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Color(0xff27BDBE), width: 1),
              ),
              child: Center(
                child: Image.asset("assets/likitha.png"), // Profile image
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              // Ensures the text doesn't overflow
              child: Text(
                "Liktha’s Diagnostics",
                maxLines: 1,
                style: TextStyle(
                  color: Color(0xff27BDBE),
                  overflow: TextOverflow.ellipsis,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.call, size: 24, color: Color(0xff000000)),
                onPressed: () {
                  // Call action
                },
              ),
              IconButton(
                icon: Icon(Icons.info_outline,
                    size: 24, color: Color(0xff000000)),
                onPressed: () {
                  // Info action
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                // Message from the other person (Right-aligned)
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.5, // Constrains width to half
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff373737),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Hello, Sir",
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                // Message from the user (Left-aligned)
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.5, // Constrains width to half
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff27BDBE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Lorem ipsum dolor sit amet.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                // More messages from the other person (Right-aligned)
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.5, // Constrains width to half
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff373737),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur.",
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                // More messages from the user (Left-aligned)
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.5, // Constrains width to half
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff27BDBE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                // Larger message from the other person (Right-aligned)
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.5, // Constrains width to half
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff373737),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur.\nLorem ipsum dolor sit amet consectetur.",
                        style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                // Final message from the user (Left-aligned)
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.5, // Constrains width to half
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff27BDBE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Lorem ipsum dolor sit amet consectetur.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Text input area at the bottom
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xff27BDBE)),
                  onPressed: () {
                    // Handle send message action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}