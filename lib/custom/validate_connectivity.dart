

import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:threeclick/custom/toast_message.dart';

import '../view_models/common/connectivity_provider.dart';
import 'loading.dart';

validateConnectivity(
    {required  context,required dynamic provider, bool? isLoader = false}) {
  fToast = FToast();
  fToast.init(context);
  var checkInternet = Provider.of<CheckInternet>(context, listen: false);
  checkInternet.checkConnectivity().then((value) {
    if (value) {
      isLoader == true
          ? loading(context, () {
              provider();
            })
          : provider();
    } else {
      showToast("No internet connection.");
    }
  });
}
