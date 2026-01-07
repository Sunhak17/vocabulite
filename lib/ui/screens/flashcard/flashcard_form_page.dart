import 'package:flutter/material.dart';
import '../../../models/flashcard_list.dart';

class FlashcardFormPage extends StatefulWidget {
  final FlashcardList? flashcardList;

  const FlashcardFormPage({super.key, this.flashcardList});

  @override
  State<FlashcardFormPage> createState() => _FlashcardFormPageState();
}

class _FlashcardFormPageState extends State<FlashcardFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.flashcardList != null;
    _nameController = TextEditingController(
      text: widget.flashcardList?.name ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveFlashcardList() {
    if (_formKey.currentState!.validate()) {
      final listName = _nameController.text.trim();

      Navigator.pop(context, {
        'name': listName,
        'action': _isEditing ? 'update' : 'create',
        'listId': widget.flashcardList?.id,
      });
    }
  }

  void _deleteFlashcardList() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete List'),
        content: const Text(
          'Are you sure you want to delete this flashcard list?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context, {
                'action': 'delete',
                'listId': widget.flashcardList?.id,
              });
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit List' : 'New Flashcard List'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        actions: _isEditing
            ? [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: _deleteFlashcardList,
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'List Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'e.g., Travel Vocabulary, Business English',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF1976D2),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a list name';
                        }
                        return null;
                      },
                      autofocus: !_isEditing,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveFlashcardList,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _isEditing ? 'Update List' : 'Create List',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
