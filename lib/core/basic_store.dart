class BasicStore {
  // Lista de los totales de cada cliente
  List<double> customerTotals = [];

  void addCustomerTotal(double total) {
    customerTotals.add(total);
  }

  double getGrandTotal() {
    return customerTotals.fold(0.0, (sum, total) => sum + total);
  }

  int getCustomerCount() {
    return customerTotals.length;
  }

  void reset() {
    customerTotals.clear();
  }
}
