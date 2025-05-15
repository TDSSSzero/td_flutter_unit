// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activityHash() => r'67ad1788f65e9ea4dbc1b192277fa65fbbad6ea8';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
///
/// Copied from [activity].
@ProviderFor(activity)
final activityProvider = AutoDisposeFutureProvider<String>.internal(
  activity,
  name: r'activityProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$activityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActivityRef = AutoDisposeFutureProviderRef<String>;
String _$curMenuItemHash() => r'e89ac6b63f4f22f3072d853d947be6f0cda58d98';

/// See also [CurMenuItem].
@ProviderFor(CurMenuItem)
final curMenuItemProvider =
    AutoDisposeNotifierProvider<CurMenuItem, MenuItem>.internal(
      CurMenuItem.new,
      name: r'curMenuItemProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$curMenuItemHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurMenuItem = AutoDisposeNotifier<MenuItem>;
String _$counterHash() => r'dae67e44133cfcea2b08ab5eace07d8554509bb8';

/// See also [Counter].
@ProviderFor(Counter)
final counterProvider = AutoDisposeNotifierProvider<Counter, int>.internal(
  Counter.new,
  name: r'counterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$counterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Counter = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
