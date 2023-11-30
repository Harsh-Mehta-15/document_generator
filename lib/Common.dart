String greeting() {
  var hour = DateTime.now().hour;
  print(DateTime.now());
  if (hour < 12) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}