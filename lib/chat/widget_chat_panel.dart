import 'package:flutter/material.dart';
import 'package:ui_training_model/chat/offline_chat_engine.dart';
import 'package:ui_training_model/chat/optional_llm_client.dart';

/// Kollabierbares Chat-Panel (Drawer/Bottom-Sheet) für ein Playground.
class WidgetChatFab extends StatelessWidget {
  const WidgetChatFab({super.key, required this.chatContext});

  final PlaygroundChatContext chatContext;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'widget-chat-${chatContext.moduleId}',
      onPressed: () => _openChat(context),
      icon: const Icon(Icons.chat_bubble_outline),
      label: const Text('Widget-Chat'),
    );
  }

  Future<void> _openChat(BuildContext context) async {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    if (wide) {
      await showGeneralDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Chat schließen',
        barrierColor: Colors.black54,
        pageBuilder: (ctx, anim, secondary) {
          return Align(
            alignment: Alignment.centerRight,
            child: Material(
              elevation: 8,
              child: SizedBox(
                width: 380,
                height: MediaQuery.sizeOf(ctx).height,
                child: WidgetChatPanel(chatContext: chatContext),
              ),
            ),
          );
        },
      );
    } else {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (ctx) => SizedBox(
          height: MediaQuery.sizeOf(ctx).height * 0.62,
          child: WidgetChatPanel(chatContext: chatContext),
        ),
      );
    }
  }
}

class WidgetChatPanel extends StatefulWidget {
  const WidgetChatPanel({super.key, required this.chatContext});

  final PlaygroundChatContext chatContext;

  @override
  State<WidgetChatPanel> createState() => _WidgetChatPanelState();
}

class _WidgetChatPanelState extends State<WidgetChatPanel> {
  final _engine = const OfflineChatEngine();
  final _llm = OptionalLlmConfig.fromEnvironment();
  final _input = TextEditingController();
  final _scroll = ScrollController();
  late final List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    final ctx = widget.chatContext;
    _messages = [
      ChatMessage(
        fromUser: false,
        text: 'Hallo! Ich kenne „${ctx.widgetName}“ und seine Properties '
            'offline. ${_llm.statusMessageDe()}\n\n'
            'Frag z. B. „Überblick“, „Eigenschaften“ oder nach einem '
            '`codeName`.',
      ),
    ];
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send([String? preset]) {
    final text = (preset ?? _input.text).trim();
    if (text.isEmpty) return;
    final answer = _engine.reply(text, widget.chatContext);
    setState(() {
      _messages.add(ChatMessage(fromUser: true, text: text));
      _messages.add(ChatMessage(fromUser: false, text: answer));
      _input.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ctx = widget.chatContext;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Widget-Chat',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${ctx.widgetName} · ${ctx.moduleId}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Schließen',
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              for (final chip in [
                'Überblick',
                'Einsatz',
                'Eigenschaften',
                if (ctx.bindings.isNotEmpty) ctx.bindings.first.codeName,
                'Hilfe',
              ])
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(chip),
                    onPressed: () => _send(chip),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scroll,
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            itemCount: _messages.length,
            itemBuilder: (context, i) {
              final m = _messages[i];
              return Align(
                alignment:
                    m.fromUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.85,
                  ),
                  decoration: BoxDecoration(
                    color: m.fromUser
                        ? scheme.primaryContainer
                        : scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SelectableText(m.text),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: EdgeInsets.fromLTRB(
            12,
            8,
            12,
            8 + MediaQuery.paddingOf(context).bottom,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _input,
                  textInputAction: TextInputAction.send,
                  decoration: const InputDecoration(
                    hintText: 'Frage zu diesem Widget…',
                    isDense: true,
                  ),
                  onSubmitted: (_) => _send(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _send,
                icon: const Icon(Icons.send),
                tooltip: 'Senden',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
