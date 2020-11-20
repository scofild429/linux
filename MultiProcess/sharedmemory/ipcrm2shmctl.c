#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"
#include "sys/shm.h"
#include "strings.h"


int main(int argc, char *argv[])
{
  int shmid;
  if (argc < 3) {
    printf("please input correct agreements \n");
    return -1;
  }

  if (strcasecmp(argv[1], "-m") == 0) 
    printf("delete shared memory \n");
  else
    return -2;

  shmid = atoi(argv[2]);
  printf("shared memory delete %d .\n", shmid);

  //delete shared memory in shell space with shmctl
  shmctl(shmid , IPC_RMID, NULL);

  system("ipcs -m");
  return 0;
}
