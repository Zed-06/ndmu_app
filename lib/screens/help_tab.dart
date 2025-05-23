import 'package:flutter/material.dart';
import '../services/openai_service.dart';

class HelpTab extends StatefulWidget {
  const HelpTab({Key? key}) : super(key: key);

  @override
  State<HelpTab> createState() => _HelpTabState();
}

class _HelpTabState extends State<HelpTab> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final OpenAIService _openAIService = OpenAIService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _messages.add({'role': 'assistant', 'content': 'Hi! I’m your NDMU AI assistant. How can I help you today?'});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() { _messages.add({'role':'user','content':text}); _controller.clear(); _isLoading=true; });
    final reply = await _openAIService.sendMessage(text);
    setState(() { _messages.add({'role':'assistant','content':reply}); _isLoading=false; });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length,
            itemBuilder: (context,index) {
              final msg=_messages[index];
              final isUser=msg['role']=='user';
              return Align(
                alignment:isUser?Alignment.centerRight:Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical:4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: isUser?Colors.green[100]:Colors.grey[200],borderRadius:BorderRadius.circular(12)),
                  child: Text(msg['content']!,style: const TextStyle(fontSize:14)),
                ),
              );
            },
          ),
        ),
        if(_isLoading) const Padding(padding:EdgeInsets.all(8.0),child:CircularProgressIndicator()),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children:[
              Expanded(child:TextField(controller:_controller,decoration:const InputDecoration(hintText:'Ask your question here...',border:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(12)))))),
              const SizedBox(width:8),
              IconButton(icon:const Icon(Icons.send,color:Colors.green),onPressed:_isLoading?null:_sendMessage)
            ]
          ),
        )
      ],
    );
  }
}