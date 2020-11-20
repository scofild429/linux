#include <stdio.h>
#include "stdlib.h"
#include <unistd.h>
#include "pthread.h"
#include "semaphore.h"

//def semaphore
sem_t sem;

void *mythread(void *num){
  //p wait
  sem_wait(&sem);   //sleep
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
  sem_init(&sem , 0, 0); //sem = 0
  
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

  sem_post(&sem);
  while (1);
  return 0;
}


