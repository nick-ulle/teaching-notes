#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
void hello_world() {
  Rprintf("Hello world!\n");
}

// [[Rcpp::export]]
NumericVector row_max(NumericMatrix matrix) {
  // Without Rcpp we would write:
  // SEXP row_max(SEXP mat)

  int last_row = matrix.nrow();
  NumericVector result(last_row);

  for (int i = 0; i < last_row; i++) {
    result[i] = max( matrix(i, _) );
  }

  hello_world();
  return result;
}
