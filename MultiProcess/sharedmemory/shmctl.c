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
  int key;
  char *p;
  
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

  p  = (char *) shmat(shmid, NULL, 0);

  if (p == NULL) {
    printf("shmat function failed \n");
    return -3;
  }

  //write  in shmat
  //  fgets(p, 128, stdin);
  //careful : fgets strings will add a \n to the end of strings
  //so no more \n needed here.

  scanf("%s", p); // \n problem is not exist for scanf

  //read from shmat
  printf("the frist time read share memory is %s .\n", p);
  printf("the second time read share memory is %s.\n", p);

  //show the shared memory
  system("ipcs -m");

  //delete the shamt memory in user space
  shmdt(p);

  //delete the shmid memory in shell space
  shmctl(shmid, IPC_RMID, NULL);

  //show the shared memory again
  system("ipcs -m");
  
  return 0;
}

