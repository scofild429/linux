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
  struct messqueue sendbuffer;
  sendbuffer.type = 100;

  key = ftok("./a.c", 'a');
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


  do {
    memset(sendbuffer.message, 0, messagelen);
    //input your massage
    printf("please input your massage you want to send to massage queue \n");
    scanf("%s", sendbuffer.message);

    //wirte the massage(which is now in your struct messqueue) into massage queue msgid
    msgsnd(msgid, (void *)&sendbuffer, strlen(sendbuffer.message), 0);
    conut++;
  }while (conut < 3);
  
  msgctl(msgid, IPC_RMID, NULL);

  system("ipcs -q");
  return 0;
}
