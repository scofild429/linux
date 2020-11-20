#include "apue.h"

int main( )
{
  pid_t pid;
  pthread_t tid;

  pid = getpid();
  tid = pthread_self();

  printf("pid is %d , and tid is %x\n", pid, (int)tid );
  return 0;
}

