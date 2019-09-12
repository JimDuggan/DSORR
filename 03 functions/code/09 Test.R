evens <- function (v){
  v[v %% 2 == 0]
}

rem_duplicates <- function(v){
  v[!duplicated(x)]
}

v <- 1:10
ans <- sapply(v, function(x){
  x^2+10
})

