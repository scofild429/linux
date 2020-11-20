#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"
#include "sys/msg.h"

int main(int argc, char *argv[])
{
  int msgid;

  msgid= msgget(IPC_PRIVATE, 0777);
  if (msgid < 0) {
    printf("creat massage queue failed .\n");
    return -1;
  }

  printf("create massage queue success  with msgid %d.\n",  msgid);

  system("ipcs -q");
  return 0;
}
