#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"
#include "sys/wait.h"

void myfun1(int signum){
  int i;
  for (i = 0; i < 5; ++i) {
    printf("this is the interupt of child process with %d seconds\n", i);
    sleep(1);
  }
  return;
}

void myfun2(int signum){
  printf("this is to recover the resource of child process with %d .\n", signum);
  wait(NULL);
  return;
}


int main(int argc, char *argv[])
{

  pid_t pid;
  int i;
  
  pid = fork();
  if (pid == 0) {
    sleep(10);
    kill(getppid(), 10);
    sleep(10);
    exit(0);
  }

  if (pid > 0) {
    signal(10, myfun1);
    signal(17, myfun2);
    for (i = 0; i < 20; ++i) {
      printf("this is parent process lives %d seconds .\n", i);
      sleep(1);
    }
    return 0;

  }

  
  
  
  return 0;
}
