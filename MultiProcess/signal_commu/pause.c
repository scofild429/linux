#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"

int main(int argc, char *argv[])
{
  int i = 0;
  printf("before use pause to kill itself \n"); // without \n will not be printed
  pause();
  printf("after use pause to kill itself \n");
  do
    {
      printf("the process live for %d seconds .\n", i);
      i++;
      sleep(1);
    } while (i < 20);
    
  return 0;
}
