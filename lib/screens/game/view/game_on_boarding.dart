import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/context.dart';
import '../../../common/resources/app_icon.dart';
import '../../../common/resources/app_image.dart';
import '../../../common/widgets/svg_button.dart';
import '../../../data/api_firebase/app_provider.dart';

class GameOnBoarding extends StatefulWidget {
  const GameOnBoarding({super.key});

  @override
  State<GameOnBoarding> createState() => _GameOnBoardingState();
}

class _GameOnBoardingState extends State<GameOnBoarding> {
  final PageController _controller = PageController();
  final CountDownController _countDownController = CountDownController();

  int? selected;
  bool isSuccess = false;
  bool isCorrect = false;
  bool ignorePointer = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<AppProvider>().getBasicQuiz();
      _countDownController.start();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color onColorButton({required String itemId, required int indexItem, required String quizId}) {
      if (isCorrect == false) {
        if (selected == indexItem) {
          return context.theme.colorScheme.secondaryContainer.withOpacity(0.5);
        } else {
          return context.theme.colorScheme.onPrimaryContainer;
        }
      } else {
        if (selected == indexItem) {
          if (itemId == quizId) {
            return context.theme.colorScheme.secondaryContainer;
          } else {
            return Colors.red;
          }
        } else {
          if (itemId == quizId) {
            return context.theme.colorScheme.secondaryContainer;
          }
          return context.theme.colorScheme.onPrimaryContainer;
        }
      }
    }

    return Consumer<AppProvider>(
      builder: (context, data, child) {
        final quizs = data.quizs;
        return Stack(
          children: [
            Image.asset(
              AppImages.topic2,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  QuizTime(controller: _countDownController),
                  SizedBox(
                    height: 530,
                    child: PageView.builder(
                      itemCount: quizs.length,
                      controller: _controller,
                      allowImplicitScrolling: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: context.theme.colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: context.theme.colorScheme.onPrimary)),
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                'QUESTION ${(index + 1)} - 20',
                                style: context.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.secondaryContainer),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(image: NetworkImage(quizs[index].quiz.image), fit: BoxFit.fill)),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                quizs[index].quiz.title,
                                style: context.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600, color: context.theme.colorScheme.primary, letterSpacing: 1.1),
                              ),
                              const SizedBox(height: 20),
                              IgnorePointer(
                                ignoring: ignorePointer,
                                child: SizedBox(
                                  child: ListView.builder(
                                    itemCount: quizs[index].quizItems.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, indexItem) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: GFButton(
                                          size: 50,
                                          text: quizs[index].quizItems[indexItem].title,
                                          textStyle: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.2,
                                            color: selected != indexItem
                                                ? context.theme.colorScheme.primary
                                                : context.theme.colorScheme.onPrimary,
                                          ),
                                          color: onColorButton(
                                            itemId: quizs[index].quizItems[indexItem].id,
                                            indexItem: indexItem,
                                            quizId: quizs[index].quiz.correct,
                                          ),
                                          blockButton: true,
                                          onPressed: () {
                                            _countDownController.pause();
                                            setState(() {
                                              selected = indexItem;
                                              ignorePointer = true;
                                            });

                                            Future.delayed(
                                              const Duration(seconds: 2),
                                              () {
                                                setState(() {
                                                  isCorrect = true;
                                                  if (_controller.page! < quizs.length - 1 &&
                                                      quizs[index].quizItems[indexItem].id == quizs[index].quiz.correct) {
                                                    isSuccess = true;
                                                  }
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.error,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: SvgButton(
                            AppIcons.iconRemove,
                            color: context.theme.colorScheme.onPrimary,
                            size: 35,
                            onTap: () {
                              context.navigator.pop();
                            },
                          ),
                        ),
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: isSuccess ? context.theme.colorScheme.secondaryContainer : Colors.transparent,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: SvgButton(
                            AppIcons.iconNext,
                            color: isSuccess ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.primary.withOpacity(0.5),
                            size: 35,
                            onTap: isSuccess == true
                                ? () {
                                    context.read<AppProvider>().setInitTimerCountDown();
                                    _controller.nextPage(
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                    _countDownController.reset();
                                    _countDownController.start();
                                    if (_controller.page! < quizs.length - 1) {
                                      setState(() {
                                        selected = 5;
                                        isSuccess = false;
                                        isCorrect = false;
                                        ignorePointer = false;
                                      });
                                    }
                                  }
                                : null,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class QuizTime extends StatelessWidget {
  const QuizTime({super.key, required this.controller});

  final CountDownController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 150,
        width: 80,
        child: CircularCountDownTimer(
          duration: 30,
          initialDuration: 0,
          controller: controller,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          ringColor: Colors.transparent,
          ringGradient: null,
          fillColor: context.theme.colorScheme.secondaryContainer,
          fillGradient: null,
          backgroundGradient: null,
          strokeWidth: 10.0,
          strokeCap: StrokeCap.round,
          textStyle: const TextStyle(fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 2),
          textFormat: CountdownTextFormat.S,
          isReverse: true,
          isReverseAnimation: false,
          isTimerTextShown: true,
          autoStart: false,
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            return Function.apply(defaultFormatterFunction, [duration]);
          },
        ),
      ),
    );
  }
}
