import 'package:flutter/material.dart';

/// A custom icon button widget that can be used in the app.
class AppIconButton extends StatelessWidget {
  /// Creates an [AppIconButton] widget.
  ///
  /// The [icon] parameter specifies the icon to be displayed.
  /// The [onTap] parameter specifies the callback function to be called when the button is tapped.
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  /// The icon to be displayed in the button.
  final IconData icon;

  /// The callback function to be called when the button is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colorScheme.onBackground.withOpacity(0.05),
          ),
        ),
        child: Icon(
          icon,
          size: 24,
        ),
      ),
    );
  }
}
