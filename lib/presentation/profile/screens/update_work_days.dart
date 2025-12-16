import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:go_router/go_router.dart';
import 'package:jibli_admin_food/app/locator.dart';
import 'package:jibli_admin_food/app/theme.dart';
import 'package:jibli_admin_food/core/filter.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_keys.dart';
import 'package:jibli_admin_food/data/local_data_source/local_data_source.dart';
import 'package:jibli_admin_food/domain/entity/fast_food_entity/fast_food_response.dart';
import 'package:jibli_admin_food/presentation/cubit/other_cubit.dart';
import 'package:jibli_admin_food/presentation/widgets/costume_button.dart';
import 'package:jibli_admin_food/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class UpdateWorkDays extends StatefulWidget {
  const UpdateWorkDays({super.key});

  @override
  State<UpdateWorkDays> createState() => _UpdateWorkDaysState();
}

class _UpdateWorkDaysState extends State<UpdateWorkDays> {
  final multiController = MultiSelectController<int>();
  final openingMorning = TextEditingController();
  final closingMorning = TextEditingController();
  final openingEvening = TextEditingController();
  final closingEvening = TextEditingController();
  final openingFriday = TextEditingController();
  final closingFriday = TextEditingController();

  @override
  void dispose() {
    multiController.dispose();
    openingMorning.dispose();
    openingEvening.dispose();
    openingFriday.dispose();
    closingMorning.dispose();
    closingEvening.dispose();
    closingFriday.dispose();
    super.dispose();
  }

  @override
  void initState() {
    multiController.setOptions([
      ValueItem(label: 'الأحد', value: 1),
      ValueItem(label: 'الأثنين', value: 2),
      ValueItem(label: 'الثلاثاء', value: 3),
      ValueItem(label: 'الأربعاء', value: 4),
      ValueItem(label: 'الخميس', value: 5),
      ValueItem(label: 'السبت', value: 7),
    ]);

    FastFoodEntity? user = sl<LocalDataSource>().getValue(LocalDataKeys.user);
    if (user == null) return;
    if (user.markets == null) return;
    if (user.markets?.first.workHours == null) return;

    final List<WorkDaysEntity> workDays = [];
    final List<ValueItem<int>> selectedDays = [];
    List items = jsonDecode(user.markets!.first.workHours!);
    print(items);
    workDays.addAll(items.map((e) => WorkDaysEntity.fromJson(e)));
    workDays.first.openingDays?.forEach((el) {
      multiController.options.forEach((element) {
        if (el == element.value) {
          selectedDays.add(element);
        }
      });
    });
    if (selectedDays.isEmpty) {
      multiController.setSelectedOptions([
        ValueItem(label: 'الأحد', value: 1),
        ValueItem(label: 'الأثنين', value: 2),
        ValueItem(label: 'الثلاثاء', value: 3),
        ValueItem(label: 'الأربعاء', value: 4),
        ValueItem(label: 'الخميس', value: 5),
        ValueItem(label: 'السبت', value: 7),
      ]);
    } else {
      multiController.setSelectedOptions(selectedDays);
    }
    if (workDays.length == 1) {
      if (num.parse(workDays.first.openingHour ?? "0") < 12) {
        openingMorning.text = "${workDays.first.openingHour ?? ""}"
            ":"
            "${workDays.first.openingMinute ?? ""}";
        closingMorning.text = "${workDays.first.closingHour ?? ""}"
            ":"
            "${workDays.first.closingMinute ?? ""}";
      }
      if (num.parse(workDays.first.openingHour ?? "0") >= 12) {
        openingEvening.text = "${workDays.first.openingHour ?? ""}"
            ":"
            "${workDays.first.openingMinute ?? ""}";
        closingEvening.text = "${workDays.first.closingHour ?? ""}"
            ":"
            "${workDays.first.closingMinute ?? ""}";
      }
    } else if (workDays.length == 2) {
      openingMorning.text = "${workDays.first.openingHour ?? ""}"
          ":"
          "${workDays.first.openingMinute ?? ""}";
      closingMorning.text = "${workDays.first.closingHour ?? ""}"
          ":"
          "${workDays.first.closingMinute ?? ""}";
      openingEvening.text = "${workDays[1].openingHour ?? ""}"
          ":"
          "${workDays[1].openingMinute ?? ""}";
      closingEvening.text = "${workDays[1].closingHour ?? ""}"
          ":"
          "${workDays[1].closingMinute ?? ""}";
    } else {
      openingMorning.text = "${workDays.first.openingHour ?? ""}"
          ":"
          "${workDays.first.openingMinute ?? ""}";
      closingMorning.text = "${workDays.first.closingHour ?? ""}"
          ":"
          "${workDays.first.closingMinute ?? ""}";
      openingEvening.text = "${workDays[1].openingHour ?? ""}"
          ":"
          "${workDays[1].openingMinute ?? ""}";
      closingEvening.text = "${workDays[1].closingHour ?? ""}"
          ":"
          "${workDays[1].closingMinute ?? ""}";
      openingFriday.text = "${workDays.last.openingHour ?? ""}"
          ":"
          "${workDays.last.openingMinute ?? ""}";
      closingFriday.text = "${workDays.last.closingHour ?? ""}"
          ":"
          "${workDays.last.closingMinute ?? ""}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    // List workDays = jsonDecode(user?.markets?.first.workHours ?? "");

    return BlocProvider(
      create: (context) => OtherCubit(sl()),
      child: BlocListener<OtherCubit, OtherState>(
        listener: (context, state) {
          state.whenOrNull(
            eroor: (error) => error.whenOrNull(
              networkError: (message) => smartToast(msg: message.tr()),
              other: (message) => smartToast(msg: message.tr()),
            ),
            success: (msg) {
              smartToast(msg: "تم تغيير توقيت العمل");
              context.pop();
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("مواقيت العمل"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MultiSelectDropDown<int>(
                  hint: "تجديد أيام الغمل",
                  hintColor: Colors.black,
                  controller: multiController,
                  onOptionSelected: (List<ValueItem> selectedOptions) {},
                  options: [],
                  selectionType: SelectionType.multi,
                  chipConfig: ChipConfig(
                      wrapType: WrapType.wrap,
                      backgroundColor: AppTheme.lightRed,
                      labelColor: AppTheme.secondaryColor,
                      deleteIconColor: AppTheme.secondaryColor,
                      padding: EdgeInsets.all(8)),
                  dropdownHeight: 40.h,
                  optionTextStyle: const TextStyle(fontSize: 16),
                  focusedBorderColor: AppTheme.lightRed,
                  selectedOptionBackgroundColor: AppTheme.lightRed,
                  borderColor: AppTheme.gray,
                  selectedOptionIcon: const Icon(
                    Icons.check_circle,
                    color: AppTheme.secondaryColor,
                  ),
                ),
                // ...workDays.map((e) => Text(e.toString())).toList()
                SizedBox(
                  height: 3.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("الفترة الصباحية"),
                          // Spacer(),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text("يفتح" " : "),
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                await buildShowTimePicker(context)
                                    .then((value) {
                                  if (value == null) return;

                                  openingMorning.text =
                                      "${value.hour}:${value.minute}";
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              readOnly: true,
                              controller: openingMorning,
                            ),
                          ),
                          SizedBox(
                            width: 3.h,
                          ),
                          Text("يغلق" " : "),
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                await buildShowTimePicker(context)
                                    .then((value) {
                                  if (value == null) return;

                                  closingMorning.text =
                                      "${value.hour}:${value.minute}";
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              controller: closingMorning,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Text("الفترة المسائية"),
                          // Spacer(),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text("يفتح" " : "),
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                await buildShowTimePicker(context)
                                    .then((value) {
                                  if (value == null) return;

                                  openingEvening.text =
                                      "${value.hour}:${value.minute}";
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              readOnly: true,
                              controller: openingEvening,
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          SizedBox(
                            width: 3.h,
                          ),
                          Text("يغلق" " : "),
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                await buildShowTimePicker(context)
                                    .then((value) {
                                  if (value == null) return;

                                  closingEvening.text =
                                      "${value.hour}:${value.minute}";
                                });
                              },
                              readOnly: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                              controller: closingEvening,
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "يوم الجمعة",
                            style: TextStyle(fontSize: 16.dp),
                          ),
                          Expanded(
                              child: Divider(
                            endIndent: 2.h,
                            indent: 2.h,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          Text("التوقيت"),
                          Spacer(),
                          Text("يفتح" " : "),
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                await buildShowTimePicker(context)
                                    .then((value) {
                                  if (value == null) return;

                                  openingFriday.text =
                                      "${value.hour}:${value.minute}";
                                });
                              },
                              readOnly: true,
                              controller: openingFriday,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 3.h,
                          ),
                          Text("يغلق" " : "),
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                await buildShowTimePicker(context)
                                    .then((value) {
                                  if (value == null) return;

                                  closingFriday.text =
                                      "${value.hour}:${value.minute}";
                                });
                              },
                              readOnly: true,
                              controller: closingFriday,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                    ],
                  ),
                ),

                BlocBuilder<OtherCubit, OtherState>(
                  builder: (context, state) {
                    return customButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (multiController.selectedOptions.isEmpty) {
                            smartToast(msg: "الرجاء تحديد الأيام");
                            return;
                          }
                          if (multiController.selectedOptions.isNotEmpty) {
                            List days = [];

                            multiController.selectedOptions.forEach((element) {
                              days.add(element.value);
                            });
                            List WorkdaysEdit = [
                              WorkDaysEntity(
                                openingMorning.text.split(':').first,
                                openingMorning.text.split(':').last,
                                closingMorning.text.split(':').first,
                                closingMorning.text.split(':').last,
                                days,
                              ),
                              WorkDaysEntity(
                                openingEvening.text.split(':').first,
                                openingEvening.text.split(':').last,
                                closingEvening.text.split(':').first,
                                closingEvening.text.split(':').last,
                                days,
                              ),
                              WorkDaysEntity(
                                openingFriday.text.split(':').first,
                                openingFriday.text.split(':').last,
                                closingFriday.text.split(':').first,
                                closingFriday.text.split(':').last,
                                [6],
                              )
                            ];

                            context.read<OtherCubit>().updateWorkdays(
                                filter:
                                    Filter(workHour: jsonEncode(WorkdaysEdit)));
                          }
                        }
                      },
                      height: 5.5.h,
                      width: double.infinity,
                      border: 78,
                      child: state.maybeWhen(
                          orElse: () => Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "تأكيد",
                                  style: TextStyle(
                                    color: AppTheme.secondaryColor,
                                    fontSize: 14.dp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          loading: (() => Padding(
                                padding:
                                    EdgeInsets.only(left: 42.w, right: 42.w),
                                child: LoadingAnimationWidget.progressiveDots(
                                    color: AppTheme.secondaryColor,
                                    size: 20.dp),
                              ))),
                      colorText: AppTheme.secondaryColor,
                      colorButton: AppTheme.lightRed,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<TimeOfDay?> buildShowTimePicker(BuildContext context) {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.dialOnly,
      initialTime: TimeOfDay.now(),
      context: context,
    );
  }
}
