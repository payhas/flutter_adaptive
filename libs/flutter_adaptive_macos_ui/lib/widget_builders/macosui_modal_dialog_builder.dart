import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:flutter_adaptive_core/flutter_adaptive_core.dart';

class MacosUIModalDialogBuilder<T>
    extends AdaptiveFunctionBuilder<AdaptiveModalDialog<T>, T> {
  @override
  Future<T?> build(BuildContext context, AdaptiveModalDialog component) {
    return ((component.width != null && component.width! > 0) ||
            (component.height != null && component.height! > 0))
        ? showMacosSheet<T>(
            context: context,
            builder: (_) => showCustomSheet(
              context: context,
              title: component.title,
              content: component.content,
              primaryButton: component.primaryButton,
              secondaryButton: component.secondaryButton,
              width: component.width,
              height: component.height,
            ),
          )
        : showMacosAlertDialog<T>(
            context: context,
            builder: (context) {
              return macosuiDialog(
                context: context,
                title: component.title,
                content: component.content,
                primaryButton: component.primaryButton,
                secondaryButton: component.secondaryButton,
                width: component.width,
                height: component.height,
              );
            },
            barrierDismissible: component.barrierDismissible,
            useRootNavigator: component.useRootNavigator,
            routeSettings: component.routeSettings,
            barrierLabel: component.barrierLabel,
          );
  }
}

Widget macosuiDialog({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
  double? width,
  double? height,
}) {
  return (secondaryButton != null)
      ? MacosAlertDialog(
          appIcon: const FlutterLogo(),
          title: title,
          message: content,
          primaryButton: PushButton(
            controlSize: ControlSize.large,
            onPressed: primaryButton.onPressed,
            child: primaryButton.child,
          ),
          secondaryButton: PushButton(
            controlSize: ControlSize.large,
            secondary: true,
            onPressed: secondaryButton.onPressed,
            child: secondaryButton.child,
          ),
        )
      : MacosAlertDialog(
          appIcon: const FlutterLogo(),
          title: title,
          message: content,
          primaryButton: PushButton(
            controlSize: ControlSize.large,
            onPressed: primaryButton.onPressed,
            child: primaryButton.child,
          ),
        );
}

Widget showCustomSheet({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required AdaptiveModalDialogAction primaryButton,
  AdaptiveModalDialogAction? secondaryButton,
  double? width,
  double? height,
}) {
  return _MacosUICustomDialog(
    width: width ?? 260,
    height: height ?? 100,
    appIcon: const FlutterLogo(),
    title: const Text('Custom Dialog'),
    content: content,
    primaryButton: PushButton(
      controlSize: ControlSize.large,
      onPressed: primaryButton.onPressed,
      child: primaryButton.child,
    ),
    secondaryButton: (secondaryButton == null)
        ? null
        : PushButton(
            controlSize: ControlSize.large,
            secondary: true,
            onPressed: secondaryButton.onPressed,
            child: secondaryButton.child,
          ),
  );
}

class _MacosUICustomDialog extends StatelessWidget {
  const _MacosUICustomDialog({
    super.key,
    required this.width,
    required this.height,
    required this.appIcon,
    required this.title,
    required this.content,
    required this.primaryButton,
    this.secondaryButton,
  });

  final double width;
  final double height;
  final Widget appIcon;
  final Widget title;
  final Widget content;
  final PushButton primaryButton;
  final PushButton? secondaryButton;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    double horizontalPaddging =
        width > this.width ? (width - this.width) / 2 : 0;
    double verticalPadding =
        height > this.height ? (height - this.height) / 2 : 0;

    return MacosSheet(
      insetPadding: EdgeInsets.symmetric(
        horizontal: horizontalPaddging,
        vertical: verticalPadding,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: this.width,
          height: this.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 64,
                  maxWidth: 64,
                ),
                child: appIcon,
              ),
              const SizedBox(height: 16),
              DefaultTextStyle(
                style: MacosTheme.of(context).typography.headline,
                textAlign: TextAlign.center,
                child: title,
              ),
              const SizedBox(height: 10),
              Expanded(child: content),
              const SizedBox(height: 16),
              if (secondaryButton == null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 0,
                        maxWidth: 100,
                      ),
                      child: Expanded(child: primaryButton),
                    ),
                  ],
                ),
              ] else ...[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (secondaryButton != null) ...[
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 0,
                              maxWidth: 100,
                            ),
                            child: Expanded(
                              child: secondaryButton!,
                            ),
                          ),
                        ],
                        const SizedBox(width: 8.0),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 0,
                            maxWidth: 100,
                          ),
                          child: Expanded(
                            child: primaryButton,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
