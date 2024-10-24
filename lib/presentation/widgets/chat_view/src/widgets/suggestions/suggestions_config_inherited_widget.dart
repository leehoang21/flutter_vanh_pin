import 'package:flutter/material.dart';

import '../../../chatview.dart';

/// This widget for alternative of excessive amount of passing arguments
/// over widgets.
class SuggestionsConfigIW extends InheritedWidget {
  const SuggestionsConfigIW({
    super.key,
    required super.child,
    this.suggestionsConfig,
  });

  final ReplySuggestionsConfig? suggestionsConfig;

  static SuggestionsConfigIW? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SuggestionsConfigIW>();

  @override
  bool updateShouldNotify(covariant SuggestionsConfigIW oldWidget) => false;
}
