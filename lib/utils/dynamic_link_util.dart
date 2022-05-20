import 'dart:developer' as developer;
import 'package:expense_tracker/app/ui/screens/modals/add_transaction_modal.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLinkUtil {
  static PendingDynamicLinkData? _dynamicLinkData;

  static Future handleDynamicLinks(BuildContext context) async {
    // Get any initial links
    _dynamicLinkData = await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(context, _dynamicLinkData);

    // Background / Foreground State
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _dynamicLinkData = dynamicLinkData;
      _handleDeepLink(context, _dynamicLinkData);
    }).onError((Object e, StackTrace stackTrace) => throw e);
  }

  static void _handleDeepLink(
      BuildContext context, PendingDynamicLinkData? dynamicLinkData) {
    final Uri? deepLink = dynamicLinkData?.link;

    if (deepLink != null) {
      developer.log(deepLink.toString());
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) =>
            AddTransactionModal(name: deepLink.queryParameters['name']),
      );
    }
  }

  static PendingDynamicLinkData? getDynamicLinkData() {
    return _dynamicLinkData;
  }
}
