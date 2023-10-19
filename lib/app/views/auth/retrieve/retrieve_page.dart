// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:asocapp/app/apirest/api_models/api_models.dart';
import 'package:asocapp/app/controllers/auth/retrieve/retrieve_controller.dart';
import 'package:asocapp/app/models/models.dart';
import 'package:asocapp/app/resources/resources.dart';
import 'package:asocapp/app/utils/utils.dart';
import 'package:asocapp/app/views/auth/login/login_page.dart';
import 'package:asocapp/app/views/auth/register/register_page.dart';
import 'package:asocapp/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RetrievePage extends StatefulWidget {
  const RetrievePage({
    Key? key,
    this.model,
  }) : super(key: key);

  final UserConnected? model;

  @override
  State<RetrievePage> createState() => _RetrievePageState();
}

class _RetrievePageState extends State<RetrievePage> {
  RetrieveController retrieveController = Get.put<RetrieveController>(RetrieveController());
  BuildContext? _context;

  final Logger logger = Logger();

  @override
  void dispose() {
    // Helper.eglLogger('i', 'dispose ${StackTrace.current} $runtimeType');
    Helper.eglLogger('i', 'dispose $runtimeType');
    super.dispose();
  }

  @override
  void initState() {
    Helper.eglLogger('i', '$runtimeType');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
          title: Text('tUserRetrieve'.tr),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: retrieveController.formKey,
            child: _formUI(context),
          ),
        ),
      ),
    );
  }

  Widget _formUI(BuildContext context) {
    _context = context;

    return SingleChildScrollView(
      child: Obx(
        () => Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              20.ph,
              EglInputLabelText(
                label: 'lChooseRetrieve'.tr,
                fontSize: 12,
              ),
              10.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          dense: false,
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text("mWithQuestion".tr, style: TextStyle(fontSize: 12)),
                          ),
                          contentPadding: EdgeInsets.zero,
                          // title: Text("Con pregunta", style: TextStyle(fontSize: 12)),
                          value: false,
                          groupValue: retrieveController.selectedOption,
                          selected: retrieveController.selectedOption == false,
                          onChanged: (value) {
                            retrieveController.selectedOption = false;
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          dense: true,
                          // visualDensity: const VisualDensity(
                          //   horizontal: VisualDensity.minimumDensity,
                          //   vertical: VisualDensity.minimumDensity,
                          // ),
                          // contentPadding: EdgeInsets.zero,
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text("mWithEmail".tr, style: TextStyle(fontSize: 12)),
                          ),
                          value: true,
                          groupValue: retrieveController.selectedOption,
                          selected: retrieveController.selectedOption == true,
                          onChanged: (value) {
                            retrieveController.selectedOption = true;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              retrieveController.selectedOption == true ? 30.ph : 10.ph,
              Visibility(
                visible: retrieveController.selectedOption == true,
                child: EglInputEmailField(
                  focusNode: retrieveController.emailFocusNode,
                  nextFocusNode: retrieveController.userNameFocusNode,
                  currentValue: '',
                  iconLabel: Icons.email_outlined,
                  // ronudIconBorder: true,
                  labelText: 'Email',
                  hintText: 'Email del usuario',
                  onChanged: (value) {
                    // logger.i('value: $value');
                    retrieveController.emailTextController.text = value;
                    retrieveController.showAlterEmail = false;
                  },
                  onValidator: (value) {
                    return value!.isEmpty ? 'Introduzca su email' : null;
                  },
                ),
              ),
              20.ph,
              Visibility(
                visible: retrieveController.selectedOption == false,
                child: Column(
                  children: [
                    EglInputTextField(
                      focusNode: retrieveController.userNameFocusNode,
                      nextFocusNode: retrieveController.asociationsFocusNode,
                      currentValue: '',
                      iconLabel: Icons.person_pin,
                      // ronudIconBorder: true,
                      labelText: 'lUserName'.tr,
                      hintText: 'hUserName'.tr,
                      onChanged: (value) {
                        retrieveController.userNameTextController.text = value;
                        retrieveController.showClave = false;
                        //   logger.i('value: $value');
                      },
                      onValidator: (value) {
                        return value!.isEmpty ? 'mInputUser'.tr : null;
                      },
                    ),
                    12.ph,
                    //   _asociationsDropDown(context),
                    EglAsociationsDropdown(
                      labelText: 'lAsociation'.tr,
                      hintText: 'hSelectAsociation'.tr,
                      focusNode: retrieveController.asociationsFocusNode,
                      nextFocusNode: null,
                      future: Future.value(retrieveController.asociationsList), //.refreshAsociationsList(),
                      currentValue: retrieveController.userConnected!.idAsociationUser == 0
                          ? ''
                          : retrieveController.userConnected!.idAsociationUser.toString(),
                      onChanged: (onChangedVal) {
                        retrieveController.idAsociationTextController.text = onChangedVal;
                        retrieveController.showClave = false;
                        logger.i('Asociation id: $onChangedVal');
                      },
                      onValidate: (onValidateVal) {
                        if (onValidateVal == null) {
                          return 'mPleaseSelectAsociation'.tr;
                        }

                        return null;
                      },
                    ),
                    20.ph,
                    Visibility(
                      visible: retrieveController.showClave,
                      child: Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  text: TextSpan(
                                      text: '${retrieveController.questionList.question}?',
                                      style: AppTheme.subtitle1.copyWith(
                                        fontSize: 15,
                                        height: 1.2,
                                      ),
                                      children: const []),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //   EglLableInputText(label: "Palabra clave", fontSize: 14),
                        10.ph,
                        EglInputPasswordField(
                          focusNode: retrieveController.answerFocusNode,
                          nextFocusNode: null,
                          currentValue: '',
                          iconLabel: Icons.key,
                          ronudIconBorder: true,
                          labelText: 'lAnswerKey'.tr,
                          onChanged: (value) {
                            retrieveController.answerTextController.text = value;
                            logger.i('value: $value');
                          },
                          onValidator: (value) {
                            return value!.isEmpty ? 'mAnswerKey'.tr : null;
                          },
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              40.ph,
              EglRoundButton(
                title: retrieveController.selectedOption
                    ? 'mRetrievePassword'.tr
                    : retrieveController.showClave
                        ? 'mRetrieveUser'.tr
                        : 'mRetrieveQuestion'.tr,
                loading: retrieveController.loading.value,
                onPress: () async {
                  logger.d('tap');
                  if (retrieveController.selectedOption == true) {
                    if (retrieveController.formKey.currentState!.validate()) {
                      HttpResult<UserResetResponse>? httpResult = await retrieveController.reset(
                        context,
                        retrieveController.emailTextController.text,
                      );
                      if (httpResult!.statusCode == 200) {
                        Helper.showPopMessage(
                          _context!,
                          'mRetrievePassword1'.tr,
                          'mRetrievePassword2'.tr,
                          title2: '',
                          message2: '',
                          styleMessage: const TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
                          edgeInsetsPop: const EdgeInsets.fromLTRB(10, 150, 10, 20),
                          textButton: 'bAccept'.tr,
                          avatarUser: '',
                          styleAvatarUser: StyleAvatarUser().copyWith(),
                          edgeInsetsButton: const EdgeInsets.fromLTRB(32.0, 6.0, 32.0, 16.0),
                          fontSizeButton: 40.0,
                          onPressed: () {
                            Get.offAll(() => LoginPage());
                            // Navigator.of(context).pop();
                          },
                        );
                      } else if (httpResult.statusCode > 400) {
                        logger.i('userapp: ${httpResult.error!.data.toString()}');
                        Helper.toastMessage('mUserNotFound'.tr);
                      } else {
                        Helper.toastMessage(' ${httpResult.error!.data}');
                      }
                    }
                  } else if (retrieveController.showClave) {
                    if (retrieveController.formKey.currentState!.validate() && int.parse(retrieveController.idAsociationTextController.text) != 0) {
                      HttpResult<UserPassResponse>? httpResult = await retrieveController.validateKey(
                        context,
                        retrieveController.userNameTextController.text,
                        int.parse(retrieveController.idAsociationTextController.text),
                        retrieveController.questionList.question,
                        retrieveController.answerTextController.text,
                      );

                      if (httpResult!.statusCode == 200) {
                        logger.i('userapp: ${httpResult.data.toString()}');
                        // _showSingleChoicePassDialog(userPassResponse.result.passwordUser);
                        Helper.showPopMessage(
                          _context!,
                          'mNewPassword'.tr,
                          httpResult.data!.result.passwordUser,
                          styleTitle: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                          styleMessage: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          title2: '',
                          styleTitle2: const TextStyle(fontSize: 0, fontWeight: FontWeight.normal),
                          message2: 'mNewPassword2'.tr,
                          styleMessage2: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                          // styleMessage2: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textButton: 'bCopy'.tr,
                          avatarUser: httpResult.data!.result.avatarUser,
                          styleAvatarUser: StyleAvatarUser().copyWith(),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: httpResult.data!.result.passwordUser)).then((result) {
                              Get.offAll(() => LoginPage());
                              // Navigator.of(context).pop();
                            });
                          },
                        );

                        return;
                      } else if (httpResult.statusCode > 400) {
                        logger.i('userapp: ${httpResult.error!.data.toString()}');
                        Helper.toastMessage('mUserNotFound'.tr);
                      } else {
                        Helper.toastMessage(' ${httpResult.error!.data}');
                      }
                    }
                  } else {
                    if (retrieveController.formKey.currentState!.validate() && int.parse(retrieveController.idAsociationTextController.text) != 0) {
                      // myProvider.dataUser.username = userNameTextController.text;
                      // userModel.username = userNameTextController.text;
                      retrieveController.questionList = await retrieveController.retrieveQuestion(
                          context, retrieveController.userNameTextController.text, int.parse(retrieveController.idAsociationTextController.text));
                      if (retrieveController.questionList.status == 'ok') {
                        retrieveController.showClave = retrieveController.questionList.showClave;
                        if (retrieveController.questionList.questions.isEmpty) {
                          // _showMessageDialog(context);
                          logger.i('Encontrado una única pregunta');
                        } else if (retrieveController.questionList.questions.isNotEmpty) {
                          logger.i('Encontradas varias preguntas');
                          // _showMultChoiceDialog(retrieveController.questionList.questions);
                          // ignore: use_build_context_synchronously
                          Helper.showMultChoiceDialog(
                            retrieveController.questionList.questions,
                            'tQuestions'.tr,
                            context: context,
                            onChanged: (value) {
                              retrieveController.questionList.question = value;
                              retrieveController.showClave = true;
                              Get.back();
                            },
                          );
                        } else {
                          Helper.toastMessage('${'mUserQuestionNotFound'.tr}: ${retrieveController.questionList}.status');
                        }
                      } else {
                        Helper.toastMessage('${'mUserQuestionDataNotFound'.tr}: ${retrieveController.questionList}.status');
                      }
                      // answerTextController.text = '';
                      retrieveController.answerTextController.text = '';
                      FocusScope.of(_context!).requestFocus(retrieveController.answerFocusNode);
                    }
                  }
                },
              ),
              10.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAll(() => RegisterPage());
                    },
                    child: Text.rich(
                      TextSpan(text: "${'mNotAccount'.tr}?  ", style: AppTheme.subtitle1.copyWith(fontSize: 15), children: [
                        TextSpan(
                          text: "mRegister".tr,
                          style: AppTheme.headline2.copyWith(fontSize: 15, decoration: TextDecoration.underline),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAll(() => const LoginPage());
                    },
                    child: Text.rich(
                      TextSpan(text: "${'mHaveAccount'.tr}?  ", style: AppTheme.subtitle1.copyWith(fontSize: 15), children: [
                        TextSpan(
                          text: "tLogin".tr,
                          style: AppTheme.headline2.copyWith(fontSize: 15, decoration: TextDecoration.underline),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
