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
  int conut =0;
  struct messqueue receiverbuffer;
  
  //create key for server
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

  //read
  do {
    //clear receiverbuffer.massage
    memset(receiverbuffer.message, 0, messagelen);
    //wirte the massage(which is now in your struct messqueue) into massage queue msgid
    msgrcv(msgid, (void *)&receiverbuffer, messagelen, 100, 0);
    printf("the receiver massage is %s \n", receiverbuffer.message);
    conut++;
  }while (conut < 3);

 msgctl(msgid, IPC_RMID, NULL);
 system("ipcs -q");
 return  0;
}
