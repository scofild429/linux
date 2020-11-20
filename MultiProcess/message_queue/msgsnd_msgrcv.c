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
  int receivelen;
  struct messqueue sendbuffer, receiverbuffer;
  sendbuffer.type = 100;
  receiverbuffer.type = 100;

  //create the massage queue
  msgid= msgget(IPC_PRIVATE, 0777);
  if (msgid < 0) {
    printf("creat massage queue failed .\n");
    return -1;
  }
  printf("create massage queue success  with msgid %d.\n",  msgid);

  //input your massage
  printf("please input your massage you want to send to massage queue \n");
  scanf("%s", sendbuffer.message);

  //wirte the massage(which is now in your struct messqueue) into massage queue msgid
  msgsnd(msgid, (void *)&sendbuffer, strlen(sendbuffer.message), 0);

  //clear receiverbuffer.massage
  memset(receiverbuffer.message, 0, messagelen);
  //read massage to receiverbuffer from massage queue msgid
  receivelen = msgrcv(msgid, (void *)&receiverbuffer, messagelen, 100, 0);

  printf("the receiverbuffer massage have %s .\n", receiverbuffer.message);
  printf("the long is %d .\n", receivelen);

  
  msgctl(msgid, IPC_RMID, NULL);

  system("ipcs -q");
  return 0;
}
