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

void myfun2(int signum){
  printf("this is to recover the resource of child process with %d .\n", signum);
  wait(NULL);
  return;
}


int main(int argc, char *argv[])
{
  int shmid;
  int key;
  char *p;
  pid_t pid;

  //creat shmid
  shmid = shmget(IPC_PRIVATE, 128, IPC_CREAT | 0777);
  if (shmid < 0) {
    printf("creat share memory failed .\n");
    return -1;
  }
  printf("create shared memory success  with shmid %d.\n",  shmid);

  pid = fork();
  if (pid > 0) {
    // max mal i = 3
    int i = 0;
    
    //handel signal
    signal(SIGUSR2, myfun);
    signal(SIGCHLD, myfun2);

    // shmat shmid to p in parent process
    p  = (char *) shmat(shmid, NULL, 0);
    if (p == NULL) {
      printf("shmat function failed in parent process \n");
      return -2;
    }

    do {
      printf("please enter your message in parent process \n");
      scanf("%s", p); // \n problem is not exist for scanf
      kill(pid , SIGUSR1);
      pause();
      i++;
    }while(i < 3);

    shmdt(p);
    printf("shmat memory are deleted  in process process\n");
  }
  
  if (pid == 0) {
    
    // max mal i = 3;
    int i = 0;
    
    //handel signal
    signal(SIGUSR1, myfun);

    // shmat shmid to p in child process
    p  = (char *) shmat(shmid, NULL, 0);
    if (p == NULL) {
      printf("shmat function failed in child process \n");
      return -3;
    }

    do{
      pause();
      //read from shmat
      printf("read share memory to child process is %s .\n", p);
      kill(getppid(), SIGUSR2);
      i++;
    }while(i < 3);
    
    shmdt(p);
    printf("shmat memory are deleted  in child process\n");
    
    exit(0);
  }

  //  shmdt(p);
  shmctl(shmid , IPC_RMID, NULL);
  printf("at last shared memory is deleted \n");
  system("ipcs -m");
  
  return 0;
}

