import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:td_flutter_unit/pages/base/base_page.dart';
import 'package:td_flutter_unit/pages/book_anim/widget/book_controller.dart';
import 'package:td_flutter_unit/pages/book_anim/widget/mindset_book.dart';
import 'package:td_flutter_unit/utils/ui_util.dart';

class BookAnimPage extends ConsumerStatefulWidget {
  const BookAnimPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookAnimPageState();
}

class _BookAnimPageState extends ConsumerState<BookAnimPage> {

  final bookController = BookController();

  @override
  Widget build(BuildContext context) {
    return BasePage(child: Center(
      child: MindsetBook(
        size: Size(context.screenWidth * 0.9, context.screenHeight * 0.7),
        pageCount: 5,
       currentPage: _buildPage,
        nextPage: _buildPage,
         controller: bookController, 
         onLongPress: (c){}
         ),
    ));
  }

  Widget _buildPage(int index) {
    return Container(
      color: Colors.primaries[index % Colors.primaries.length],
      child: Center(
        child: Text(
          'Page $index',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}