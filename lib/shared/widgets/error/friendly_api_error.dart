import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'error_mapper.dart';

class FriendlyApiError extends StatelessWidget {
  const FriendlyApiError({
    super.key,
    required this.message,
    required this.onRetry,
    this.title,
    this.statusCode,
    this.details,
    this.primaryActionLabel,
    this.secondaryAction,
    this.secondaryActionLabel,
    this.compact = false,
  });

  /// Factory: map any error/stacktrace into a FriendlyApiError using ErrorMapper
  factory FriendlyApiError.fromError({
    required Object error,
    StackTrace? stackTrace,
    required VoidCallback onRetry,
    String? route,
    bool compact = false,
  }) {
    final mapped = ErrorMapper.map(error, stackTrace);
    final details = <String, Object?>{
      if (route != null) 'route': route,
      'error': error.toString(),
      if (stackTrace != null) 'stack': stackTrace.toString(),
    };
    return FriendlyApiError(
      title: mapped.title,
      message: mapped.message,
      statusCode: mapped.statusCode,
      details: details,
      onRetry: onRetry,
      compact: compact,
    );
  }

  final String message;
  final String? title;
  final int? statusCode;
  final Map<String, Object?>? details;
  final VoidCallback onRetry;
  final String? primaryActionLabel;
  final VoidCallback? secondaryAction;
  final String? secondaryActionLabel;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icon = _iconFor(statusCode);
    final headline = title ?? _headlineFor(statusCode);
    final suggestions = _tipsFor(statusCode);

    final body = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: compact ? 36 : 64, color: theme.colorScheme.primary),
        const SizedBox(height: 12),
        Text(headline, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodyMedium?.color?.withOpacity(.9)),
          textAlign: TextAlign.center,
        ),
        if (suggestions.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: suggestions.map((s) => Chip(label: Text(s))).toList(),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(primaryActionLabel ?? 'Try again'),
            ),
            if (secondaryAction != null) ...[
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: secondaryAction,
                child: Text(secondaryActionLabel ?? 'Go back'),
              ),
            ]
          ],
        ),
        if (details != null && details!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _TechnicalDetails(details: details!),
        ],
      ],
    );

    if (compact) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Center(child: body),
      );
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: body,
        ),
      ),
    );
  }

  static IconData _iconFor(int? code) {
    if (code == 401) return Icons.lock_outline;
    if (code == 403) return Icons.block_outlined;
    if (code == 404) return Icons.search_off_outlined;
    if (code == 408) return Icons.schedule_outlined; // timeout
    if (code == 500) return Icons.cloud_off_outlined;
    return Icons.wifi_off; // network/unknown
  }

  static String _headlineFor(int? code) {
    switch (code) {
      case 401:
        return 'You need to sign in';
      case 403:
        return 'You don’t have permission';
      case 404:
        return 'Content not found';
      case 408:
        return 'Request timed out';
      case 500:
        return 'Server is having a bad day';
      default:
        return 'Can’t connect right now';
    }
  }

  static List<String> _tipsFor(int? code) {
    switch (code) {
      case 401:
        return const ['Open app settings', 'Try again'];
      case 403:
        return const ['Switch account', 'Contact support'];
      case 404:
        return const ['Check the link', 'Pull to refresh'];
      case 408:
        return const ['Check your internet', 'Try again'];
      case 500:
        return const ['Try again in a moment'];
      default:
        return const ['Check your internet', 'Pull to refresh'];
    }
  }
}

class _TechnicalDetails extends StatelessWidget {
  const _TechnicalDetails({required this.details});
  final Map<String, Object?> details;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text('Details for support', style: theme.textTheme.bodyMedium),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...details.entries.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('${e.key}: ${e.value}'),
              )),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () async {
                    final text = details.entries.map((e) => '${e.key}: ${e.value}').join('\n');
                    await Clipboard.setData(ClipboardData(text: text));
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied details')),
                      );
                    }
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}