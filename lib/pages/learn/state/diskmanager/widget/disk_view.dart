import 'package:flutter/material.dart';

class DiskView extends StatefulWidget {
  final String id;
  final int usage;
  final int total;
  final VoidCallback onReset;
  const DiskView({super.key,required this.id,required this.usage,required this.total,required this.onReset});

  @override
  State<DiskView> createState() => _DiskViewState();
}

class _DiskViewState extends State<DiskView> {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.data_thresholding_outlined,
                size: 42,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '磁盘 001',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '用量: ${widget.usage}/${widget.total}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            TextButton(
              onPressed: widget.onReset,
              child: const Text('格式化'),
            ),
            const SizedBox(
              width: 8,
            ),
            Stack(alignment: Alignment.center, children: [
              CircularProgressIndicator(
                value: widget.usage / widget.total,
                backgroundColor: Colors.green,
              ),
              Text(
                '${((widget.usage / widget.total) * 100).toStringAsFixed(1)}%',
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              )
            ])
          ],
        ),
      ),
    );
  }
}

