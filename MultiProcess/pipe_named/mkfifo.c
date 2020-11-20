#include <stdio.h>
#include "stdio.h"
#include "unistd.h"
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char *argv[])
{
  int ret;
  ret = mknod("./fifo", 0777, 0);
  //  ret = mkfifo("./fifo", 0777);

  if (ret < 0) {
    printf("creat myfilo failed! \n");
    return -1;
  }

  printf("creat myfifo succuss !\n");
  
  return 0;
}

