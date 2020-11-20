#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"

int main(int argc, char *argv[])
{
  printf("before use raise to kill itself \n"); // without \n will not be printed
  raise(9);
  printf("after use raise to kill itself \n");
  return 0;
  }
