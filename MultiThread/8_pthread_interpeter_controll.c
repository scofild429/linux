#include <stdio.h>
#include "stdlib.h"
#include <unistd.h>
#include "pthread.h"

int interpeter = 0;

void *mythread(void *num){
  while(interpeter == 0);
  int i = 0;
  for (i = 0; i < 10; ++i) {
    printf("In my thread there is %d\n", i);
    usleep(100);
  }
  return (void *)0;
}

int main(int argc, char *argv[])
{
  pthread_t tid;
  int err;
  err = pthread_create(&tid, NULL, mythread, NULL);
  if (err < 0) {
    printf("create my thread failed\n");
    return -1;
  }
  int i = 0;
  for (i = 0; i < 10; ++i) {
    printf("In main thread there is %d\n", i);
    usleep(100);
  }
  interpeter = 1;
  sleep(10);
  return 0;
}


