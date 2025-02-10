import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'string_utils.dart';

class ShareUtils {

  static void shareStr(BuildContext context, String shareStr) {
    try {
      Share.share(shareStr, subject: StringUtils.txtShare);
    } catch (e) {
      debugPrint(e.toString());
    }
  }  
}
