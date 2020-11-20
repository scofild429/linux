#include <stdio.h>
#include "stdlib.h"
#include <unistd.h>
#include "pthread.h"
#include "sys/ipc.h"
#include "sys/sem.h"

union semun
{
  int val;
  struct semid_ds *buf;
  unsigned short *array;
  struct seminfo *_buf;
};

struct sembuf mysembuf;

int semid;
union semun mysemum;

void *mythread(void *num){
  //p wait
  mysembuf.sem_op = -1;
  semop(semid , &mysembuf, 1);
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
  
  //create sem with 3 semaphores
  semid = semget(IPC_PRIVATE, 3, 0777);
  if (semid < 0) {
    printf("create semaphore of sem failed \n");
    return -1;
  }
  printf("create sem success with %d\n", semid);
  system("ipcs -m");

  //init sem
  mysemum.val = 0;
  semctl(semid , 0, SETVAL, mysemum);
  mysembuf.sem_num = 0;
  mysembuf.sem_flg = 0;

  //new thread
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

  //
  mysembuf.sem_op = 1;
  semop(semid , &mysembuf, 1);

  system("ipcs -m");
  
  while (1);
  return 0;
}


