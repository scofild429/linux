#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"
#include "sys/sem.h"
#include "sys/msg.h"
#include "sys/shm.h"
#include "string.h"


int main(int argc, char *argv[])
{
  int semid;
  semid = semget(IPC_PRIVATE,3 ,  0777);
  if (semid < 0) {
    printf("creat semaphore failed \n");
    return -1;
  }
  printf("create semaphore success with %d .\n",  semid);

  system("ipcs -s");

  //delete semaphore
  semctl(semid, 0, IPC_RMID, NULL);
  system("ipcs -s");

  return 0;
}
