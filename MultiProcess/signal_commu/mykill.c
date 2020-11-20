#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"

int main(int argc, char *argv[])
{
  int sig;
  int pid;

  if (argc < 3 ) {
    printf("please give at last two agreements, one for sig and one for pid \n");
    return -1;
  }

  sig = atoi(argv[1]); // for c , atoi transfer string to integer
  pid = atoi(argv[2]);
  
  printf("for the kill programm , sig is %d, and pid is %d .\n", sig, pid);

  kill(pid, sig);
  return 0;
}


