class PerfectNumber {
  static bool isPerfect(int number){
    if (number <= 1) {
      return false;
    }
    int sum = 0;
    for ( int i = number -1; i >= 1 ; i --){
      if (number % i == 0){
        sum += i;
      }
    }
    return sum == number;
  }
}