import 'package:flutter/material.dart';

class NewMemoryTextPage extends StatelessWidget {
  final void Function(String description) onChangeDescription;
  
  const NewMemoryTextPage({super.key, required this.onChangeDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: onChangeDescription,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    labelText: "How do you feel?",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: const TextStyle(fontSize: 16),
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
