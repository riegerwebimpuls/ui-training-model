import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/playgrounds/cupertino/cupertino_button_playground.dart';
import 'package:ui_training_model/playgrounds/cupertino/cupertino_switch_playground.dart';
import 'package:ui_training_model/playgrounds/feedback/snackbar_dialog_playground.dart';
import 'package:ui_training_model/playgrounds/input/button_playground.dart';
import 'package:ui_training_model/playgrounds/input/chip_playground.dart';
import 'package:ui_training_model/playgrounds/input/selection_controls_playground.dart';
import 'package:ui_training_model/playgrounds/input/text_field_playground.dart';
import 'package:ui_training_model/playgrounds/layout/container_playground.dart';
import 'package:ui_training_model/playgrounds/layout/flex_playground.dart';
import 'package:ui_training_model/playgrounds/layout/padding_playground.dart';
import 'package:ui_training_model/playgrounds/layout/sized_box_playground.dart';
import 'package:ui_training_model/playgrounds/layout/stack_playground.dart';
import 'package:ui_training_model/playgrounds/lists/data_table_playground.dart';
import 'package:ui_training_model/playgrounds/lists/list_tile_playground.dart';
import 'package:ui_training_model/playgrounds/lists/list_view_playground.dart';
import 'package:ui_training_model/playgrounds/navigation/app_bar_playground.dart';
import 'package:ui_training_model/playgrounds/navigation/bottom_nav_playground.dart';
import 'package:ui_training_model/playgrounds/navigation/navigation_rail_playground.dart';
import 'package:ui_training_model/playgrounds/navigation/sliver_app_bar_playground.dart';
import 'package:ui_training_model/playgrounds/navigation/tab_bar_playground.dart';
import 'package:ui_training_model/playgrounds/text/icon_playground.dart';
import 'package:ui_training_model/playgrounds/text/text_playground.dart';
import 'package:ui_training_model/playgrounds/viral/bottom_sheet_playground.dart';
import 'package:ui_training_model/playgrounds/viral/card_stack_playground.dart';
import 'package:ui_training_model/playgrounds/viral/page_view_carousel.dart';
import 'package:ui_training_model/playgrounds/viral/stories_ring_playground.dart';

/// Zentrale Registry aller Trainingsmodule.
class WidgetRegistry {
  WidgetRegistry._();

  static final List<WidgetModule> modules = [
    // Layout
    WidgetModule(
      id: 'container',
      title: 'Container / DecoratedBox',
      description: 'Größe, Farbe, Padding, Radius, Elevation.',
      category: WidgetCategory.layout,
      tags: const ['container', 'decoration', 'borderRadius', 'padding'],
      builder: (_) => const ContainerPlayground(),
    ),
    WidgetModule(
      id: 'padding-margin',
      title: 'Padding / Margin',
      description: 'Innen- vs. Außenabstand visuell vergleichen.',
      category: WidgetCategory.layout,
      tags: const ['padding', 'margin', 'EdgeInsets'],
      builder: (_) => const PaddingPlayground(),
    ),
    WidgetModule(
      id: 'flex',
      title: 'Row / Column / Expanded',
      description: 'Flex-Layout und Expanded-Faktoren.',
      category: WidgetCategory.layout,
      tags: const ['Row', 'Column', 'Expanded', 'mainAxisAlignment'],
      builder: (_) => const FlexPlayground(),
    ),
    WidgetModule(
      id: 'stack',
      title: 'Stack / Positioned',
      description: 'Überlagerung und absolute Positionierung.',
      category: WidgetCategory.layout,
      tags: const ['Stack', 'Positioned', 'alignment', 'clipBehavior'],
      builder: (_) => const StackPlayground(),
    ),
    WidgetModule(
      id: 'sized-box',
      title: 'SizedBox',
      description: 'Feste Breiten- und Höhenbox.',
      category: WidgetCategory.layout,
      tags: const ['SizedBox', 'width', 'height'],
      builder: (_) => const SizedBoxPlayground(),
    ),

    // Text & Icons
    WidgetModule(
      id: 'text',
      title: 'Text / TextStyle',
      description: 'Typografie: Größe, Gewicht, Farbe, Abstand.',
      category: WidgetCategory.textIcons,
      tags: const ['Text', 'TextStyle', 'fontSize', 'fontWeight'],
      builder: (_) => const TextPlayground(),
    ),
    WidgetModule(
      id: 'icon',
      title: 'Icon',
      description: 'Material Icons mit size, color, fill.',
      category: WidgetCategory.textIcons,
      tags: const ['Icon', 'Icons', 'size', 'fill'],
      builder: (_) => const IconPlayground(),
    ),

    // Input
    WidgetModule(
      id: 'buttons',
      title: 'Buttons',
      description: 'Elevated, Filled, Outlined, Text, IconButton.',
      category: WidgetCategory.input,
      tags: const [
        'ElevatedButton',
        'FilledButton',
        'OutlinedButton',
        'TextButton',
        'IconButton',
      ],
      builder: (_) => const ButtonPlayground(),
    ),
    WidgetModule(
      id: 'text-field',
      title: 'TextField / InputDecoration',
      description: 'Eingabe mit Label, Hint, Helper, obscure.',
      category: WidgetCategory.input,
      tags: const ['TextField', 'InputDecoration', 'obscureText'],
      builder: (_) => const TextFieldPlayground(),
    ),
    WidgetModule(
      id: 'selection',
      title: 'Switch / Checkbox / Slider / Dropdown',
      description: 'Auswahl-Controls und Live-Werte.',
      category: WidgetCategory.input,
      tags: const ['Switch', 'Checkbox', 'Slider', 'DropdownButton'],
      builder: (_) => const SelectionControlsPlayground(),
    ),
    WidgetModule(
      id: 'chip',
      title: 'Chip / FilterChip',
      description: 'Tags, Filter und entfernbare Eingabe-Chips.',
      category: WidgetCategory.input,
      tags: const ['Chip', 'FilterChip', 'ChoiceChip', 'InputChip'],
      builder: (_) => const ChipPlayground(),
    ),

    // Listen
    WidgetModule(
      id: 'list-tile',
      title: 'ListTile',
      description: 'Listenzeile mit Leading/Trailing.',
      category: WidgetCategory.lists,
      tags: const ['ListTile', 'dense', 'selected'],
      builder: (_) => const ListTilePlayground(),
    ),
    WidgetModule(
      id: 'list-view',
      title: 'ListView',
      description: 'Scrollbare Liste (Mini-Simulation).',
      category: WidgetCategory.lists,
      tags: const ['ListView', 'itemExtent', 'scrollDirection'],
      builder: (_) => const ListViewPlayground(),
    ),
    WidgetModule(
      id: 'data-table',
      title: 'DataTable',
      description: 'Tabellarische Daten mit Sortierung und Checkbox-Auswahl.',
      category: WidgetCategory.lists,
      tags: const ['DataTable', 'sortColumnIndex', 'showCheckboxColumn'],
      builder: (_) => const DataTablePlayground(),
    ),

    // Navigation
    WidgetModule(
      id: 'app-bar',
      title: 'AppBar',
      description: 'Titelleiste mit Actions und Elevation.',
      category: WidgetCategory.navigation,
      tags: const ['AppBar', 'centerTitle', 'actions'],
      builder: (_) => const AppBarPlayground(),
    ),
    WidgetModule(
      id: 'bottom-nav',
      title: 'BottomNavigationBar',
      description: 'Untere Navigation mit Index.',
      category: WidgetCategory.navigation,
      tags: const ['BottomNavigationBar', 'currentIndex'],
      builder: (_) => const BottomNavPlayground(),
    ),
    WidgetModule(
      id: 'tab-bar',
      title: 'TabBar + TabBarView',
      description: 'Tabs mit zugehörigem Inhalt.',
      category: WidgetCategory.navigation,
      tags: const ['TabBar', 'TabBarView', 'isScrollable'],
      builder: (_) => const TabBarPlayground(),
    ),
    WidgetModule(
      id: 'navigation-rail',
      title: 'NavigationRail',
      description: 'Seitliche Navigation für breite Layouts.',
      category: WidgetCategory.navigation,
      tags: const ['NavigationRail', 'extended', 'labelType'],
      builder: (_) => const NavigationRailPlayground(),
    ),
    WidgetModule(
      id: 'sliver-app-bar',
      title: 'SliverAppBar',
      description: 'Kollabierende AppBar in CustomScrollView.',
      category: WidgetCategory.navigation,
      tags: const ['SliverAppBar', 'CustomScrollView', 'FlexibleSpaceBar'],
      builder: (_) => const SliverAppBarPlayground(),
    ),

    // Feedback
    WidgetModule(
      id: 'feedback',
      title: 'SnackBar / Dialog / Progress',
      description: 'SnackBar, AlertDialog, CircularProgressIndicator.',
      category: WidgetCategory.feedback,
      tags: const [
        'SnackBar',
        'AlertDialog',
        'CircularProgressIndicator',
      ],
      builder: (_) => const FeedbackPlayground(),
    ),

    // Viral
    WidgetModule(
      id: 'card-stack',
      title: 'Card-Stack Swiper',
      description:
          'Gestapelte Karten mit Swipe – borderRadius, positionFactor, scaleFactor.',
      category: WidgetCategory.viral,
      tags: const [
        'card stack',
        'borderRadius',
        'positionFactor',
        'scaleFactor',
        'swipe',
      ],
      builder: (_) => const CardStackPlayground(),
    ),
    WidgetModule(
      id: 'page-view',
      title: 'PageView Carousel',
      description: 'Carousel mit viewportFraction und Snapping.',
      category: WidgetCategory.viral,
      tags: const ['PageView', 'viewportFraction', 'carousel'],
      builder: (_) => const PageViewCarouselPlayground(),
    ),
    WidgetModule(
      id: 'bottom-sheet',
      title: 'Modal Bottom Sheet',
      description: 'showModalBottomSheet mit Drag-Handle.',
      category: WidgetCategory.viral,
      tags: const ['showModalBottomSheet', 'enableDrag', 'showDragHandle'],
      builder: (_) => const BottomSheetPlayground(),
    ),
    WidgetModule(
      id: 'stories-ring',
      title: 'Story-Ringe',
      description: 'Avatar mit Progress-Ring (Stories-Muster).',
      category: WidgetCategory.viral,
      tags: const ['stories', 'avatar', 'CircularProgressIndicator'],
      builder: (_) => const StoriesRingPlayground(),
    ),

    // Cupertino
    WidgetModule(
      id: 'cupertino-button',
      title: 'CupertinoButton',
      description: 'iOS-Button vs. Material.',
      category: WidgetCategory.cupertino,
      tags: const ['CupertinoButton', 'pressedOpacity'],
      builder: (_) => const CupertinoButtonPlayground(),
    ),
    WidgetModule(
      id: 'cupertino-switch',
      title: 'CupertinoSwitch',
      description: 'iOS-Switch neben Material Switch.',
      category: WidgetCategory.cupertino,
      tags: const ['CupertinoSwitch', 'activeTrackColor'],
      builder: (_) => const CupertinoSwitchPlayground(),
    ),
  ];

  static WidgetModule? byId(String id) {
    for (final m in modules) {
      if (m.id == id) return m;
    }
    return null;
  }

  static List<WidgetModule> search({
    String query = '',
    WidgetCategory? category,
  }) {
    final q = query.trim().toLowerCase();
    return modules.where((m) {
      if (category != null && m.category != category) return false;
      if (q.isEmpty) return true;
      final hay = [
        m.title,
        m.description,
        m.id,
        ...m.tags,
        m.category.labelDe,
      ].join(' ').toLowerCase();
      return hay.contains(q);
    }).toList();
  }
}
