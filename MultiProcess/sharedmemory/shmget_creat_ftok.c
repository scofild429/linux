#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"
#include "sys/shm.h"

int main(int argc, char *argv[])
{
  int shmid;
  int key;

  //creat key for shmid
  key = ftok("./a.c",'a');
  if (key < 0) {
    printf("creat key failed \n");
    return -1;
  }
  printf("create key success with %d  .\n", key);

  //creat shmid
  shmid = shmget(key, 128, IPC_CREAT | 0777);
  if (shmid < 0) {
    printf("creat share memory failed .\n");
    return -2;
  }
  printf("create shared memory success  with shmid %d.\n",  shmid);


  system("ipcs -m");
  
  return 0;
}

