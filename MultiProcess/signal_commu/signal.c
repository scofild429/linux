#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"

void interupt(int signum){
  int i = 0;
  for (i = 0; i < 10; ++i) {
    printf("this interupt is caused by command %d \n", signum);
    sleep(1);
  }
  return;
}


int main(int argc, char *argv[])
{
  int i = 0;
  signal(14, interupt);
  /* signal(14, SIG_IGN); */
  /* signal(14, SIG_DFL); */
  
  
  printf("before use alarm to kill itself \n"); // without \n will not be printed
  alarm(10);
  printf("after use alarm to kill itself \n");
  do
    {
      printf("the process live for %d seconds .\n", i);
      i++;
      sleep(1);
    } while (i < 20);
    
  return 0;
}
