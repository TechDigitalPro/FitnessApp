import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import 'color_utils.dart';
import 'size_utils.dart';
import 'string_utils.dart';
import 'widget_utils.dart';


KeyboardActionsConfig buildConfigKeyboard(BuildContext context, FocusNode nodeKeyboard) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: nodeKeyboard, toolbarButtons: [
          (node) {
            return Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: RoundButton(
                  onPressed: () => node.unfocus(),
                  isStroked: false,
                  textContent: StringUtils.txtDone,
                  textColor: ColorUtils.appColorWhite,
                  textSize: SizeUtils.textSizeLargeMedium,
                  backgroundColor: ColorUtils.appColorPrimary,
                  padding: const EdgeInsets.all(0),
                ));
          }
        ]),
      ],
    );
  }