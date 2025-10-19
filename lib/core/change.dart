class Change {
  static int twoDollarCoins = 0;
  static int oneDollarCoins = 0;
  static int fiftyCentsCoins = 0;
  static int quarterCoins = 0;
  static int dimeCoins = 0;
  static double pendingAmount = 0;


  static void computeChange(double amount) {
    print(amount);
    while(amount >= 2){
      amount -= 2;
      twoDollarCoins++;
    }

    while(amount >= 1){
      amount -= 1;
      oneDollarCoins++;
    }

    while(amount >= 0.5){
      amount -= 0.5;
      fiftyCentsCoins++;
    }

    while(amount >= 0.25){
      amount -= 0.25;
      quarterCoins++;
    }

    while(amount >= 0.1){
      amount -= 0.1;
      dimeCoins++;
    }
    pendingAmount = amount;
  }

  static void resetChange() {
    twoDollarCoins = 0;
    oneDollarCoins = 0;
    fiftyCentsCoins = 0;
    quarterCoins = 0;
    dimeCoins = 0;
    pendingAmount = 0;
  }
}