import 'age_model.dart';
import 'duration_model.dart';
import 'package:age_calculator/age_calculator.dart';

class  MyAgeCalculator{

MyAge MycalculateAge(DateTime birthday,DateTime futureDate){

  DateDuration duration;
  duration = AgeCalculator.age(birthday, today: futureDate);
  print('Your age is $duration');

  // // Find out the difference between two dates
  //   age = AgeCalculator.dateDifference(
  //   fromDate: birthday,
  //   toDate: futureDate,
  // ) as AgeCalculator ;
  //   print(' your age is :${age}');

   MyAge userAge=MyAge();
   userAge.years=duration.years;
   userAge.months=duration.months;
   userAge.days=duration.days;

  return userAge;
}

MyDuration calculateNextBirDayDuration(DateTime birthday,DateTime futureDate)
{
  DateDuration duration;
  // Find out when your next birthday will be on any given date
  duration = AgeCalculator.timeToNextBirthday(birthday,
      fromDate: futureDate);
  print('You next birthday will be in $duration');

  MyDuration userDuration=MyDuration();
  userDuration.months=duration.months;
  userDuration.days=duration.days;

  return userDuration;
}
}