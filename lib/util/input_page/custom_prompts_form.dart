import 'package:flutter/material.dart';

class CustomPromptsForm extends StatefulWidget {
  final int minVal;
  final int maxVal;
  final List<Map<String, TextEditingController>> controller;
  const CustomPromptsForm({
    super.key,
    required this.minVal,
    required this.maxVal,
    required this.controller,
  });

  @override
  State<CustomPromptsForm> createState() => _CustomPromptsFormState();
}

class _CustomPromptsFormState extends State<CustomPromptsForm> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addRow() {
    setState(() {
      widget.controller.add({
        'left': TextEditingController(),
        'right': TextEditingController(),
      });
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _deleteRow(int index){
    setState(() {
      widget.controller.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        spacing: 17,
        children: [
          const Text(
            "Add Custom Prompts",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 200,
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              thickness: 6,
              radius: const Radius.circular(10),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  spacing: 12,
                  children: [
                    ...widget.controller.asMap().entries.map((entry) {
                      int index = entry.key;
                      var controllers = entry.value;

                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 214, 214, 214),
                          //border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            _deleteRow(index);
                          },
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  maxLength: widget.maxVal,
                                  controller: controllers['left'],
                                  decoration: InputDecoration(
                                    hintText: 'Left prompt',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: TextField(
                                  maxLength: widget.maxVal,
                                  controller: controllers['right'],
                                  decoration: InputDecoration(
                                    hintText: 'Right prompt',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),

          IconButton(onPressed: _addRow, icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
