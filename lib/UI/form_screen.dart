import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:invoice/UI/pdf_page.dart';
import 'package:invoice/constants.dart';
import 'dart:io';
import '../widgets/text_form_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:image_picker/image_picker.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  List<Image?> images = [null, null]; //上傳身分證影本照片
  List<String?> imagePaths = [null, null];

  TextEditingController guarantorNameController =
      TextEditingController(); //要保人姓名
  TextEditingController guarantorBirthDateController =
      TextEditingController(); //要保人生日
  TextEditingController guarantorIDController =
      TextEditingController(); //要保人身分證字號
  TextEditingController guarantorResidenceController =
      TextEditingController(); //要保人居住地址
  TextEditingController protectMobileController =
      TextEditingController(); //要保人手機
  TextEditingController insuredSponsoredController =
      TextEditingController(); //被保人是否同為要保人
  TextEditingController insuredPersonNameController =
      TextEditingController(); //被保人姓名
  TextEditingController insuranceBirthDateController =
      TextEditingController(); //被保人生日
  TextEditingController insuredIDController =
      TextEditingController(); // 被保人身分證字號
  TextEditingController insuredPersonResidentController =
      TextEditingController(); // 被保人居住地址
  TextEditingController insuredMobileController =
      TextEditingController(); // 被保人手機
  TextEditingController carLicenceController =
      TextEditingController(); // 車牌號碼（必填）

  TextEditingController policyStyleController = TextEditingController(); // 保單樣式
  TextEditingController salesManController = TextEditingController(); // 業務員
  TextEditingController quotationContentController =
      TextEditingController(); // 報價內容

  bool insuranceCompulsory = false; //強制險
  bool tpdInsurance = false; //第三人責任險
  bool excessInsurance = false; //超額險
  bool passengerInsurance = false; //乘客險
  bool compulsoryInsuranceAdditional = false; //強制險附加駕傷
  bool additionalInsuranceTpd = false; //第三人附加駕傷
  bool automobileInsurance = false; //車體險
  bool roadSideAssurance = false; //道路救援
  bool condolenceMoneyInsurance = false; //慰問金保險
  bool criminalProceedings = false; //刑事訴訟
  bool noDepreciation = false; //免折舊
  bool noRecovery = false; //免追償
  bool others = false; //其他

  // 駕駛人傷害險名冊 Driver's Injury Insurance List

  List<Map> injuryList = [
    {
      'name': TextEditingController(),
      'idCardFontSize': TextEditingController(),
      'dob': TextEditingController(),
      'relation': TextEditingController(),
    },
    {
      'name': TextEditingController(),
      'idCardFontSize': TextEditingController(),
      'dob': TextEditingController(),
      'relation': TextEditingController(),
    },
    {
      'name': TextEditingController(),
      'idCardFontSize': TextEditingController(),
      'dob': TextEditingController(),
      'relation': TextEditingController(),
    },
    {
      'name': TextEditingController(),
      'idCardFontSize': TextEditingController(),
      'dob': TextEditingController(),
      'relation': TextEditingController(),
    },
    {
      'name': TextEditingController(),
      'idCardFontSize': TextEditingController(),
      'dob': TextEditingController(),
      'relation': TextEditingController(),
    },
    {
      'name': TextEditingController(),
      'idCardFontSize': TextEditingController(),
      'dob': TextEditingController(),
      'relation': TextEditingController(),
    }
  ];

  void pickFile(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    if (kIsWeb) {
      images[index] = Image.network(image.path, fit: BoxFit.cover);
      imagePaths[index] = image.path;
    } else {
      images[index] = Image.file(File(image.path), fit: BoxFit.cover);
      imagePaths[index] = image.path;
    }
    setState(() {});
  }
  GlobalKey<FormState> _formKey = GlobalKey();

  void printPDF() {

    Map dataMap = {
      'images': [
        imagePaths.first,
        imagePaths[1]
      ],
      'textFields': {
        'guarantorName': {
          'data': guarantorNameController.text,
          'label': '要保人姓名'
        },
        'guarantorBirthDate': {
          'data': guarantorBirthDateController.text,
          'label': '要保人生日'
        },
        'guarantorID': {
          'data': guarantorIDController.text,
          'label': '要保人身分證字號'
        },
        'guarantorResidence': {
          'data': guarantorResidenceController.text,
          'label': '要保人居住地址'
        },
        'protectMobile': {
          'data': protectMobileController.text,
          'label': '要保人手機'
        },
        'insuredSponsored': {
          'data': insuredSponsoredController.text,
          'label': '被保人是否同為要保人'
        },
        'insuredPersonName': {
          'data': insuredPersonNameController.text,
          'label': '被保人姓名'
        },
        'insuranceBirthDate': {
          'data': insuranceBirthDateController.text,
          'label': '被保人生日'
        },
        'insuredID': {
          'data': insuredIDController.text,
          'label': '被保人身分證字號'
        },
        'insuredPersonResident': {
          'data': insuredPersonResidentController.text,
          'label': '被保人居住地址'
        },
        'insuredMobile': {
          'data': insuredMobileController.text,
          'label': '被保人手機'
        },
        'carLicence': {
          'data': carLicenceController.text,
          'label': '車牌號碼'
        },
        'policyStyle': {
          'data': policyStyleController.text,
          'label': '保單樣式'
        },
        'salesManController': {
          'data': salesManController.text,
          'label': '業務員'
        },
        'quotationContentController': {
          'data': salesManController.text,
          'label': '報價內容'
        },
      },
      'checkBox': {
        '強制險': insuranceCompulsory,
        '第三人責任險': tpdInsurance,
        '超額險': excessInsurance,
        '乘客險': passengerInsurance,
        '強制險附加駕傷': compulsoryInsuranceAdditional,
        '第三人附加駕傷': additionalInsuranceTpd,
        '車體險': automobileInsurance,
        '道路救援': roadSideAssurance,
        '慰問金保險': condolenceMoneyInsurance,
        '刑事訴訟': criminalProceedings,
        '免折舊': noDepreciation,
        '免追償': noRecovery,
        '其他': others,
      },
      'injuryList': injuryList
    };

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GeneratePDF(data: dataMap)));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(width > 400 ? 40 : 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kIsWeb ? Image.network('assets/assets/logo.png', width: 250) : Image.asset('assets/logo.png', width: 200),
                SizedBox(height: 20),
                Text('基本資料可上傳行照/身分證或駕照，僅填寫手機號碼即可。）', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Constants.errorColor
                ),),
                SizedBox(height: 20),
                getImageWidget(width),
                getFormRow(width, '要保人姓名', guarantorNameController),
                getFormRow(width, '要保人生日', guarantorBirthDateController),
                getFormRow(width, '要保人身分證字號', guarantorIDController),
                getFormRow(width, '要保人居住地址', guarantorResidenceController),
                getFormRow(width, '要保人手機', protectMobileController),
                getFormRow(width, '被保人是否同為要保人', insuredSponsoredController),
                getFormRow(width, '被保人姓名', insuredPersonNameController),
                getFormRow(width, '被保人生日', insuranceBirthDateController),
                getFormRow(width, '被保人身分證字號', insuredIDController),
                getFormRow(width, '被保人居住地址', insuredPersonResidentController),
                getFormRow(width, '被保人手機', insuredMobileController),
                getFormRow(width, '車牌號碼', carLicenceController, validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return 'This is a required field';
                  }
                  return null;
                }), // Required

                getFormRow(width, '保單樣式', policyStyleController),
                getFormRow(width, '業務員', salesManController),
                getFormRow(width, '報價內容', quotationContentController),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getCheckbox(width, "強制險", insuranceCompulsory, (bool? val) {
                      setState(() {
                        insuranceCompulsory = val ?? false;
                      });
                    }),
                    getCheckbox(width, "第三人責任險", tpdInsurance, (bool? val) {
                      setState(() {
                        tpdInsurance = val ?? false;
                      });
                    })
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getCheckbox(width, "超額險", excessInsurance, (bool? val) {
                      setState(() {
                        excessInsurance = val ?? false;
                      });
                    }),
                    getCheckbox(width, "乘客險", passengerInsurance, (bool? val) {
                      setState(() {
                        passengerInsurance = val ?? false;
                      });
                    })
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getCheckbox(width, "強制險附加駕傷", compulsoryInsuranceAdditional,
                        (bool? val) {
                      setState(() {
                        compulsoryInsuranceAdditional = val ?? false;
                      });
                    }),
                    getCheckbox(width, "第三人附加駕傷", additionalInsuranceTpd,
                        (bool? val) {
                      setState(() {
                        additionalInsuranceTpd = val ?? false;
                      });
                    })
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getCheckbox(width, "車體險", automobileInsurance, (bool? val) {
                      setState(() {
                        automobileInsurance = val ?? false;
                      });
                    }),
                    getCheckbox(width, "道路救援", roadSideAssurance, (bool? val) {
                      setState(() {
                        roadSideAssurance = val ?? false;
                      });
                    })
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getCheckbox(width, "慰問金保險", condolenceMoneyInsurance,
                        (bool? val) {
                      setState(() {
                        condolenceMoneyInsurance = val ?? false;
                      });
                    }),
                    getCheckbox(width, "刑事訴訟", criminalProceedings, (bool? val) {
                      setState(() {
                        criminalProceedings = val ?? false;
                      });
                    })
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getCheckbox(width, "免折舊", noDepreciation, (bool? val) {
                      setState(() {
                        noDepreciation = val ?? false;
                      });
                    }),
                    getCheckbox(width, "免追償", noRecovery, (bool? val) {
                      setState(() {
                        noRecovery = val ?? false;
                      });
                    })
                  ],
                ),
                SizedBox(height: 12),
                getCheckbox(width, "其他", others, (bool? val) {
                  setState(() {
                    others = val ?? false;
                  });
                }),
                SizedBox(height: 30),
                Text('\t駕駛人傷害險名冊',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 18),
                ...List.generate(injuryList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(18),
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SizedBox(
                            width: width / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\t姓名',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 12),
                                TextWidget(
                                    controller: injuryList[index]['name'],
                                    labelText: '姓名'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\t身分證字號',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 12),
                                TextWidget(
                                    controller: injuryList[index]
                                        ['idCardFontSize'],
                                    labelText: '身分證字號'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\t出生年月日',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 12),
                                TextWidget(
                                    controller: injuryList[index]['dob'],
                                    labelText: '出生年月日'),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\t關係',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 12),
                                TextWidget(
                                    controller: injuryList[index]['relation'],
                                    labelText: '關係'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(height: 18),
                Center(
                  child: ElevatedButton(onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      printPDF();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Constants.errorColor,
                        content: Text('Please fill required fields!'),
                      ));
                    }
                  }, child: Text('Submit', style: TextStyle(
                    fontSize: 18
                  ),)),
                ),
                SizedBox(height: 18),

              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget getCheckbox(
      double width, String label, bool value, Function(bool?) onChanged) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 200),
      child: CheckboxListTile(
          title: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          value: value,
          onChanged: onChanged),
    );
  }

  Widget getImageWidget(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "上傳身分證影本照片",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                pickFile(0);
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300)),
                child: images[0] ??
                    const Center(
                      child: Icon(Icons.add, size: 30),
                    ),
              ),
            ),
            SizedBox(width: width > 400 ? 40 : 12),
            InkWell(
              onTap: () {
                pickFile(1);
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300)),
                child: images[1] ??
                    const Center(
                      child: Icon(Icons.add, size: 30),
                    ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget getFormRow(
      double width, String label, TextEditingController controller, {FormFieldValidator<String>? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Device.screenType == ScreenType.mobile ? 120 : 160,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: width > 400 ? 40 : 12),
          TextWidget(controller: controller, labelText: label, validator: validator),
        ],
      ),
    );
  }
}
