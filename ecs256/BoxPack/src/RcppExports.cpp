// This file was generated by Rcpp::compileAttributes
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// pack_boxes
List pack_boxes(int n, NumericVector p);
RcppExport SEXP BoxPack_pack_boxes(SEXP nSEXP, SEXP pSEXP) {
BEGIN_RCPP
    Rcpp::RObject __result;
    Rcpp::RNGScope __rngScope;
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type p(pSEXP);
    __result = Rcpp::wrap(pack_boxes(n, p));
    return __result;
END_RCPP
}
