int n1Stage = 5;
int n2Stage = 50;
int n3Stage = 70;
int n4Stage = 90;

sleepCycle(setTime) {
  DateTime all = DateTime.now();
  int currHour = 21;
  int currMinute = 43;

  double setHours = 0;
  int setMinutes = 0;
  int subTime = 0;
  print(currHour);
  if (currHour > 19 || currHour < 7) {
    if (setTime == 1) {
      int calculatedMins = 0;
      currHour <= 24 && currHour >= 19
          ? calculatedMins = ((24 - currHour) * 60) - currMinute + 240
          : calculatedMins = 240 - currMinute - (currHour * 60);
      double div = double.parse((calculatedMins / 90).toStringAsFixed(1));
      double divDub = div - int.parse(div.toStringAsFixed(0));
      int convertSleepCycleIntoMins =
          int.parse((divDub * 90).toStringAsFixed(0));
      List lists = sleepStages(
          convertSleepCycleIntoMins, setHours, setMinutes, calculatedMins);
      print(lists);
      return lists;
    } else if (setTime == 2) {
      int calculatedMins = 0;
      currHour <= 24 && currHour >= 19
          ? calculatedMins = ((24 - currHour) * 60) - currMinute + 240
          : calculatedMins = 240 - currMinute - (currHour * 60);
      double div = double.parse((calculatedMins / 90).toStringAsFixed(1));
      double divDub = div - int.parse(div.toStringAsFixed(0));
      int convertSleepCycleIntoMins =
          int.parse((divDub * 90).toStringAsFixed(0));
      List lists = sleepStages(
          convertSleepCycleIntoMins, setHours, setMinutes, calculatedMins);
      print(lists);
      return lists;
    } else if (setTime == 3) {
      int calculatedMins = 0;
      currHour <= 24 && currHour >= 19
          ? calculatedMins = ((24 - currHour) * 60) - currMinute + 270
          : calculatedMins = 270 - currMinute - currHour * 60;
      double div = double.parse((calculatedMins / 90).toStringAsFixed(1));
      double divDub = double.parse(
          (div - int.parse((div.toString()).split('.')[0])).toStringAsFixed(1));
      int convertSleepCycleIntoMins =
          int.parse((divDub * 90).toStringAsFixed(0));
      List lists = sleepStages(
          convertSleepCycleIntoMins, setHours, setMinutes, calculatedMins);
      print(lists);
      return lists;
    } else if (setTime == 4) {
      int calculatedMins = 0;
      currHour <= 24 && currHour >= 19
          ? calculatedMins = ((24 - currHour) * 60) - currMinute + 300
          : calculatedMins = 300 - currMinute - currHour * 60;

      double div = double.parse((calculatedMins / 90).toStringAsFixed(1));
      double divDub = double.parse(
          (div - int.parse((div.toString()).split('.')[0])).toStringAsFixed(1));
      int convertSleepCycleIntoMins =
          int.parse((divDub * 90).toStringAsFixed(0));
      List lists = sleepStages(
          convertSleepCycleIntoMins, setHours, setMinutes, calculatedMins);

      return lists;
    } else if (setTime == 5) {
      int calculatedMins = 0;
      currHour <= 24 && currHour >= 19
          ? calculatedMins = ((24 - currHour) * 60) - currMinute + 330
          : calculatedMins = 330 - currMinute - (currHour * 60);
      double div = double.parse((calculatedMins / 90).toStringAsFixed(1));
      double divDub = double.parse(
          (div - int.parse((div.toString()).split('.')[0])).toStringAsFixed(1));
      int convertSleepCycleIntoMins =
          int.parse((divDub * 90).toStringAsFixed(0));
      List lists = sleepStages(
          convertSleepCycleIntoMins, setHours, setMinutes, calculatedMins);
      print(lists);
      return lists;
    } else if (setTime == 6) {
      int calculatedMins = 0;
      currHour <= 24 && currHour >= 19
          ? calculatedMins = ((24 - currHour) * 60) - currMinute + 360
          : calculatedMins = 360 - currMinute - (currHour * 60);

      double div = double.parse((calculatedMins / 90).toStringAsFixed(1));
      double divDub = double.parse(
          (div - int.parse((div.toString()).split('.')[0])).toStringAsFixed(1));
      int convertSleepCycleIntoMins =
          int.parse((divDub * 90).toStringAsFixed(0));
      List lists = sleepStages(
          convertSleepCycleIntoMins, setHours, setMinutes, calculatedMins);
      print(lists);
      return lists;
    } else if (setTime == 7) {
      int calculatedMins = 0;
      currHour <= 24 && currHour >= 19
          ? calculatedMins = ((24 - currHour) * 60) - currMinute + 390
          : calculatedMins = 390 - currMinute - currHour * 60;
      print('calculatedMins: $calculatedMins');
      double div = double.parse((calculatedMins / 90).toStringAsFixed(1));
      double divDub = double.parse(
          (div - int.parse((div.toString()).split('.')[0])).toStringAsFixed(1));
      int convertSleepCycleIntoMins =
          int.parse((divDub * 90).toStringAsFixed(0));
      List lists = sleepStages(
          convertSleepCycleIntoMins, setHours, setMinutes, calculatedMins);
      print(lists);
      return lists;
    }
  } else {
    List listempty = [];
    print('its not going to work');
    return listempty;
  }
}

sleepCycleMinutes(
    calculatedMins, setHours, String stage, int convertSleepCycleIntoMins) {
  int setMinutes = 0;

  double convertHoursIntoMins = double.parse(
      (setHours - int.parse((setHours.toString()).split('.')[0]))
          .toStringAsFixed(1));
  print('$convertHoursIntoMins $convertHoursIntoMins');
  if (stage == 'n1Stage') {
    setMinutes = int.parse((convertHoursIntoMins * 60).toStringAsFixed(0));
  } else if (stage == 'n2Stage') {
    setMinutes = int.parse((convertHoursIntoMins * 60 - 15).toStringAsFixed(0));
  } else if (stage == 'n3Stage') {
    setMinutes = int.parse((convertHoursIntoMins * 60 - 25).toStringAsFixed(0));
  } else if (stage == 'n4Stage') {
    convertHoursIntoMins > 80 && convertSleepCycleIntoMins < 90
        ? setMinutes =
            int.parse((convertHoursIntoMins * 60 + 15).toStringAsFixed(0))
        : setMinutes =
            int.parse((convertHoursIntoMins * 60 + 20).toStringAsFixed(0));
  }

  return setMinutes;
}

sleepStages(int convertSleepCycleIntoMins, double setHours, int setMinutes,
    int calculatedMins) {
  if (convertSleepCycleIntoMins <= n1Stage) {
    print('n1Stage');
    setHours = ((calculatedMins / 60));

    setMinutes = sleepCycleMinutes(
        calculatedMins, setHours, "n1Stage", convertSleepCycleIntoMins);
    int setHoursInt = int.parse((setHours.toString()).split('.')[0]);
    if (setMinutes < 0) {
      setHoursInt = setHoursInt - 1;
      setMinutes = 60 + setMinutes;
    } else if (setMinutes > 59) {
      setHoursInt = setHoursInt + 1;
      setMinutes = setMinutes - 60;
    }
    List listSetHours = [setHoursInt, setMinutes];
    return listSetHours;
  } else if (convertSleepCycleIntoMins > n1Stage &&
      convertSleepCycleIntoMins <= n2Stage) {
    print('n2Stage');
    setHours = (calculatedMins / 60);
    setMinutes = sleepCycleMinutes(
        calculatedMins, setHours, "n2Stage", convertSleepCycleIntoMins);
    int setHoursInt = int.parse((setHours.toString()).split('.')[0]);
    if (setMinutes < 0) {
      setHoursInt = setHoursInt - 1;
      setMinutes = 60 + setMinutes;
    } else if (setMinutes > 59) {
      setHoursInt = setHoursInt + 1;
      setMinutes = setMinutes - 60;
    }

    List listSetHours = [setHoursInt, setMinutes];
    return listSetHours;
  } else if (convertSleepCycleIntoMins > n2Stage &&
      convertSleepCycleIntoMins <= n3Stage) {
    print('n3Stage');
    setHours = (calculatedMins / 60);
    setMinutes = sleepCycleMinutes(
        calculatedMins, setHours, "n3Stage", convertSleepCycleIntoMins);

    int setHoursInt = int.parse((setHours.toString()).split('.')[0]);
    if (setMinutes < 0) {
      setHoursInt = setHoursInt - 1;
      setMinutes = 60 + setMinutes;
    } else if (setMinutes > 59) {
      setHoursInt = setHoursInt + 1;
      setMinutes = setMinutes - 60;
    }

    List listSetHours = [setHoursInt, setMinutes];
    return listSetHours;
  } else if (convertSleepCycleIntoMins > n3Stage &&
      convertSleepCycleIntoMins <= n4Stage) {
    print('n4Stage');
    setHours = (calculatedMins / 60);
    setMinutes = sleepCycleMinutes(
        calculatedMins, setHours, "n4Stage", convertSleepCycleIntoMins);

    int setHoursInt = int.parse((setHours.toString()).split('.')[0]);
    if (setMinutes < 0) {
      setHoursInt = setHoursInt - 1;
      setMinutes = 60 + setMinutes;
    } else if (setMinutes > 59) {
      setHoursInt = setHoursInt + 1;
      setMinutes = setMinutes - 60;
    }

    List listSetHours = [setHoursInt, setMinutes];
    return listSetHours;
  } else {
    int setHoursInt = int.parse((setHours.toString()).split('.')[0]);
    if (setMinutes < 0) {
      setHoursInt = setHoursInt - 1;
      setMinutes = 60 + setMinutes;
    } else if (setMinutes > 59) {
      setHoursInt = setHoursInt + 1;
      setMinutes = setMinutes - 60;
    }

    List listSetHours = [setHoursInt, setMinutes];
    return listSetHours;
  }
}
