#include <Rcpp.h>
using namespace Rcpp;

// Let's write a simulation routine for the box packing chain from the last
// homework.

//' Simulate box-packing.
//'
//' @param n number of steps to simulate
//' @param p vector of probabilities for item weights 1, ..., w
//' @useDynLib BoxPack
//' @export
// [[Rcpp::export]]
List pack_boxes(int n, NumericVector p) {
  Function sample = Environment("package:base")["sample"];

  // Sample item weights.
  int w_max = p.size();
  IntegerVector item = sample(w_max, n, true, p);

  IntegerVector weight(n);
  weight[0] = item[0];

  IntegerVector first(n);
  first[0] = 1;
  int n_boxes = 1;

  for (int i = 1; i < n; i++) {
    int new_weight = weight[i - 1] + item[i];
    if (new_weight <= w_max) {
      weight[i] = new_weight;
    } else {
      // Start a new box.
      weight[i] = item[i];
      first[n_boxes++] = i + 1;
    }
  }

  return List::create(
    _["item"] = item,
    _["weight"] = weight,
    _["first"] = first[seq(0, n_boxes - 1)]
  );
}

