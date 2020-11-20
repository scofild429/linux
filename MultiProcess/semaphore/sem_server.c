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


int main(int argc, char *argv[])
{
  int i;

  //creat key for server
  int key;
  key = ftok("./a.c", 'a');
  if (key < 0) {
    printf("create key for server failed \n");
    return -1;
  }
  printf("create key for server success \n");
  
  //create sem with 3 semaphores
  semid = semget(key, 3, IPC_CREAT |  0777);
  if (semid < 0) {
    printf("create semaphore of sem failed \n");
    return -1;
  }
  printf("create sem success with %d\n", semid);
  system("ipcs -m");

  //init sem
  //  mysemum.val = 0;
  //  semctl(semid , 0, SETVAL, mysemum);
  
  mysembuf.sem_num = 0;
  mysembuf.sem_flg = 0;
    
  for (i = 0; i < 10; ++i) {   //print at frist
    printf("In main thread there is %d\n", i);
    usleep(100);
  }

  sleep(1);
  // V postion
  mysembuf.sem_op = 1;
  semop(semid , &mysembuf, 1);

  //  system("ipcs -m");
  
  while (1);
  return 0;
}


