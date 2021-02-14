#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector row_max(NumericMatrix m) {
  int nrow = m.nrow();
  NumericVector max(nrow);

  for (int i = 0; i < nrow; i++)
    max[i] = Rcpp::max( m(i, _) );

  return max;
}

// [[Rcpp::export]]
IntegerVector foo() {
  return IntegerVector::create(
    Named("January") = 31,
    Named("February") = 28,
    Named("March") = 31
  );
}
