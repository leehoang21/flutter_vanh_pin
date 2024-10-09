import 'package:flutter/material.dart';

import '../../../chatview.dart';

class ReplySuggestionsConfig {
  final SuggestionItemConfig? itemConfig;
  final SuggestionListConfig? listConfig;
  final ValueSetter<SuggestionItemData>? onTap;
  final bool autoDismissOnSelection;

  const ReplySuggestionsConfig({
    this.listConfig,
    this.itemConfig,
    this.onTap,
    this.autoDismissOnSelection = true,
  });
}
