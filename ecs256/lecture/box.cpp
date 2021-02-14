#include <Rcpp.h>
using namespace Rcpp;


// Items arrive with weight in {1, ..., w}
// Boxes are packed up to weight w; if an item
// makes the box exceed weight w, start a new box.

// Simulate box weight at each time.

// n number of steps to simulate
// p probabilities for item weights
// [[Rcpp::export]]
List box_pack(int n, NumericVector p) {
  Function r_sample("sample");
  int w = p.length();

  // All syntax is C++, but arguments are the same
  // as in R.
  IntegerVector item = r_sample(w, n, true, p);

  IntegerVector weight(n);
  weight[0] = item[0];

  IntegerVector first(n);
  first[0] = 1;
  int n_boxes = 1;

  for (int i = 1; i < n; i++) {
    int new_weight = weight[i - 1] + item[i];

    if (new_weight > w) {
      // New box
      weight[i] = item[i];
      // add 1 to use 1-based indexing
      first[n_boxes++] = i + 1;
    } else {
      // Same box
      weight[i] =  new_weight;
    }
  }

  // The create method creates a new list in
  // place.
  return List::create(
    _["item"] = item,
    Named("weight") = weight,
    _["first"] = first[seq(0, n_boxes - 1)]
  );
}




