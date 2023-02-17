import 'package:cached_network_image/cached_network_image.dart';
//import 'package:mockito_delivery_app/src/helpers/dependency_injections.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/user.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../data/repositories/preferences_repository.dart';
import '../../../../data/repositories/websocket_repository.dart';
import '../../../../helpers/get.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/dialogs.dart';
import '../../../../utils/font_styles.dart';
import '../../../../utils/date_format.dart';
import '../../../global_controllers/notifications_controller.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  void _signOut(BuildContext context) async {
    final isOk = await Dialogs.confirm(context, title: "ACTION REQUIRED");
    if (isOk) {
      Get.i.remove<User>();
      await Get.i.find<AuthenticationRepository>().signOut();
      await Get.i
          .find<PreferencesRepository>()
          .setOnboardAndWelcomeReady(false);
      // ignore: use_build_context_synchronously
      context.read<NotificationsController>().clear();
      Get.i.remove<WebsocketRepository>();
      //DependencyInjections.dispose();
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, Routes.login, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Get.i.find<User>();
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xffefebe9),
      child: Center(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Align(
              child: ClipOval(
                child: CachedNetworkImage(
                  width: 22 * 5,
                  height: 22 * 5,
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://i.pinimg.com/564x/4b/71/f8/4b71f8137985eaa992d17a315997791e.jpg",
                  // "https://www.nj.com/resizer/h8MrN0-Nw5dB5FOmMVGMmfVKFJo=/450x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/SJGKVE5UNVESVCW7BBOHKQCZVE.jpg",
                ),
              ),
            ),
            CupertinoFormSection.insetGrouped(
              backgroundColor: const Color(0xffefebe9),
              header: Text(
                "User information",
                style: MyFontStyles.subtitleColor,
              ),
              margin: const EdgeInsets.all(10).copyWith(top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              children: [
                CupertinoFormRow(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  prefix: Text(
                    "ID: ",
                    style: MyFontStyles.subSubtitle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  child: Text(user.id),
                ),
                CupertinoFormRow(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  prefix: Text(
                    "Name: ",
                    style: MyFontStyles.subSubtitle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text(
                      "Usuario X"), //${user.name} ${user.lastName}"),
                ),
                CupertinoFormRow(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  prefix: Text(
                    "Email: ",
                    style: MyFontStyles.subSubtitle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text("user@gmail.com"), //user.email),
                ),
                CupertinoFormRow(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  prefix: Text(
                    "Birthday: ",
                    style: MyFontStyles.subSubtitle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  child: Text(
                    user.birthday.format,
                  ),
                ),
              ],
            ),
            CupertinoFormSection.insetGrouped(
              backgroundColor: const Color(0xffefebe9),
              header: Text(
                "Payment methods",
                style: MyFontStyles.subtitleColor,
              ),
              margin: const EdgeInsets.all(10).copyWith(top: 5),
              children: [
                CupertinoFormRow(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15)
                          .copyWith(right: 5),
                  prefix: Text(
                    "Credit cards",
                    style: MyFontStyles.subSubtitle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  child: CupertinoButton(
                    onPressed: () {},
                    minSize: 20,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Show 〉",
                      style: MyFontStyles.subSubtitle,
                    ),
                  ),
                ),
                CupertinoFormRow(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15)
                          .copyWith(right: 5),
                  prefix: Text(
                    "Paypal",
                    style: MyFontStyles.subSubtitle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  child: CupertinoButton(
                    onPressed: () {},
                    minSize: 20,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "test@paypal.com 〉",
                      style: MyFontStyles.subSubtitle,
                    ),
                  ),
                ),
              ],
            ),
            CupertinoFormSection.insetGrouped(
              backgroundColor: const Color(0xffefebe9),
              header: Text(
                "My Account",
                style: MyFontStyles.subtitleColor,
              ),
              margin: const EdgeInsets.all(10).copyWith(top: 5),
              children: [
                CupertinoFormRow(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  prefix: Text(
                    "Remove or hide",
                    style: MyFontStyles.subSubtitle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  child: CupertinoButton(
                    onPressed: () {},
                    minSize: 20,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Set confirguration",
                      style: MyFontStyles.subSubtitle,
                    ),
                  ),
                ),
                CupertinoFormRow(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  prefix: Text(
                    "Session",
                    style: MyFontStyles.subSubtitle.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  child: CupertinoButton(
                    onPressed: () => _signOut(context),
                    minSize: 20,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Sign Out",
                      style: MyFontStyles.subSubtitle.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
