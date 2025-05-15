import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/modules/modules.dart';
import 'package:td_flutter_unit/pages/home_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Unit",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 28),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.watch(counterProvider.notifier).increment(),
        child: Icon(Icons.add),
        elevation: 8,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.1,
            ),
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return _buildDemoCard(menuItems[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDemoCard(MenuItem item) {
    return Builder(
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).cardColor,
                  Theme.of(context).cardColor.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Card(
              elevation: 8,
              shadowColor: Theme.of(context).primaryColor.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _onTapItem(item, context, ref),
                splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon,
                        size: 44,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 12),
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _onTapItem(MenuItem item, BuildContext context, WidgetRef ref) {
    ref.watch(curMenuItemProvider.notifier).setItem(item);
    context.push(item.route.url);
  }
}
