enum Gender { male, female }

enum StateOrder {
  all('all'),
  accepted('accepted'),
  New('new'),
  delivered('delivered'),
  rejected('rejected');

  const StateOrder(this.name);

  final String name;
}

enum ReasonCancel {
  scheduleChange('scheduleChange'),
  weatherConditions('weatherConditions'),
  unexpectedWork('unexpectedWork'),
  childcareIssue('childcareIssue'),
  other('others'),
  travelDelays('travelDelays');

  const ReasonCancel(this.name);

  final String name;
}

enum BookingFor {
  self('self'),
  mySon('my Son'),
  myWife('my Wife'),
  myBrother('my Brother'),
  mySister("my Sister"),
  myMother("my Mother"),
  myDad("my Dad"),
  myHusband("my Husband"),
  other('other');

  const BookingFor(this.name);

  final String name;
}
