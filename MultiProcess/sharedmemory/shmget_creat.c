#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"
#include "sys/shm.h"

int main(int argc, char *argv[])
{
  int shmid;

  shmid = shmget(IPC_PRIVATE, 128, 0777);
  if (shmid < 0) {
    printf("creat share memory failed .\n");
    return -1;
  }

  printf("create shared memory success  with shmid %d.\n",  shmid);

  system("ipcs -m");
  return 0;
}

