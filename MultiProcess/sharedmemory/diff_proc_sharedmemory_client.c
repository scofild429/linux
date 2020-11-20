#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"
#include "sys/shm.h"
#include "strings.h"
#include <sys/wait.h>

void  myfun(int signum){
  return;
}

struct mybuff {
  int pid;
  char buffer[124];
};

int main(int argc, char *argv[])
{
  int shmid;
  int key;
  struct mybuff *p;
  pid_t pid;

  // maximal i = 3 time communications
  int i = 0;
    
  //handel signal
  signal(SIGUSR1, myfun);

  // creat key for a.c
  key = ftok("./a.c",'a');
  if (key < 0 ) {
    printf("creat key for server is failed \n");
    return -1;
  }
  printf("creat key for server success !\n");
  
  //creat shmid
  shmid = shmget(key, 128, IPC_CREAT | 0777);
  if (shmid < 0) {
    printf("creat share memory failed .\n");
    return -1;
  }
  printf("create shared memory success  with shmid %d.\n",  shmid);


  // shmat shmid to p in parent process
  p  = (struct mybuff *) shmat(shmid, NULL, 0);
  if (p == NULL) {
    printf("shmat function failed in server process \n");
    return -2;
  }

  //222 get the server pid and send its own pid to sharedmemory 
  pid = p->pid;
  p->pid = getpid();
  //and send signal to server, client done for the pid
  kill(pid , SIGUSR2);
  

  do{
    pause();    // the frist time stop, wait for the frist message from server
    //read from shmat
    printf("read share memory to child process is %s .\n", p->buffer);
    kill(pid, SIGUSR2);
    i++;
  }while(i < 3);
    
  shmdt(p);
  printf("shmat memory are deleted  in child process\n");

  //  shmdt(p);
  shmctl(shmid , IPC_RMID, NULL);
  printf("at last shared memory is deleted \n");
  system("ipcs -m");
  
  return 0;
}

