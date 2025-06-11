import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:td_flutter_unit/pages/learn/state/diskmanager/disk_manager.dart';
import 'package:td_flutter_unit/pages/learn/state/diskmanager/widget/disk_view.dart';

class DiskManagerPage extends StatefulWidget {
  const DiskManagerPage({super.key});

  @override
  State<DiskManagerPage> createState() => _DiskManagerPageState();
}

class _DiskManagerPageState extends State<DiskManagerPage> {
  String useMsg = '磁盘使用记录:\n';
  String smsMsg = '消息通知记录:\n';

  final TextEditingController _useSize = TextEditingController();
  late DiskManager _diskManager;

  @override
  void initState() {
    _diskManager = DiskManager(1024, handleDiskMessage: _handleDiskMessage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('磁盘管理模拟'),
            Expanded(
              child: CupertinoTextField(
                controller: _useSize,
                placeholder: '磁盘使用量',
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _useDisk,
            icon: Icon(Icons.not_started_rounded),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            DiskView(
              id: '磁盘 001',
              usage: _diskManager.usage,
              total: _diskManager.total,
              onReset: _onReset,
            ),
            Expanded(
              child: MessagePanel(message: useMsg),
            ),
            Expanded(
              child: MessagePanel(message: smsMsg),
            ),
          ],
        ),
      ),
    );
  }

  _useDisk() {
    int? useSize = int.tryParse(_useSize.text);
    if (useSize != null) {
      _diskManager.use(useSize);
      setState(() {});
    }
  }

  void _handleDiskMessage(NotifyStatus status, String message) {
    switch (status) {
      case NotifyStatus.log:
        useMsg += "$message\n";
        break;
      case NotifyStatus.threshold:
      case NotifyStatus.full:
        smsMsg += "$message\n";
        break;
    }
  }

  void _onReset() {
    useMsg = '磁盘使用记录:\n';
    smsMsg = '消息通知记录:\n';
    _diskManager.reset();
    setState(() {});
  }
}

class MessagePanel extends StatelessWidget {
  const MessagePanel({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(message, style: const TextStyle(fontSize: 12)),
    );
  }
}
