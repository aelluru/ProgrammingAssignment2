## This script calculates inverse of a matrix. If inverse is already calculated then
## it returns from cache

# This function creates a special "vector" object that can cache its inverse, and returns list of 
# following functions
# set - sets the value of the matrix
# get - gets the value of the matris
# setinverse - sets the inverse of the matrix
# getinverse - gets the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinverse <- function(mean) m <<- mean
  getinverse <- function() m
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


# This function caluclates inverse matrix of special "vector" object from above makeCacheMatrix
# function. It first checks if inverse matrix is already calculated, if so, it returns the 
# value from cache and skips comuptation

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getinverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}
