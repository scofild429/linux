#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"
#include "sys/msg.h"
#include "string.h"

#define messagelen 124


struct messqueue
{
  long type;
  char message[messagelen];
  char ID[4];
};


int main(int argc, char *argv[])
{
  int msgid;
  int key;
  int receivelen;
  int conut = 0;
  pid_t pid;
  struct messqueue sendbuffer, receiverbuffer;


  key = ftok("./b.c", 'a');
  if (key < 0) {
    printf("create key for server failed \n");
    return -1;
  }
  
  //create the massage queue
  msgid= msgget(key, IPC_CREAT | 0777);
  if (msgid < 0) {
    printf("creat massage queue failed .\n");
    return -1;
  }
  printf("create massage queue success  with msgid %d.\n",  msgid);

  pid = fork();

  if (pid > 0) {   //server father process write tpye 100
    sendbuffer.type = 100;

    while(1) {
      memset(sendbuffer.message, 0, messagelen);
      //input your massage
      printf("please input your massage you want to send to massage queue \n");
      scanf("%s", sendbuffer.message);

      //wirte the massage(which is now in your struct messqueue) into massage queue msgid
      msgsnd(msgid, (void *)&sendbuffer, strlen(sendbuffer.message), 0);
      conut++;
    }
  }

  if (pid == 0) {    //server child process read tpye 200
    while (1) {
      memset(receiverbuffer.message, 0, messagelen);
      msgrcv(msgid, (void *)&receiverbuffer, messagelen, 200, 0);
      printf("the receive massage of massage queue in server is %s \n", receiverbuffer.message);
    }
    
  }
  
  msgctl(msgid, IPC_RMID, NULL);

  system("ipcs -q");
  return 0;
}
