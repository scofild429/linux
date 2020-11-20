#include <stdio.h>
#include "unistd.h"
#include "stdlib.h"
#include "string.h"


int main(int argc, char *argv[])
{
  int fd[2];
  int ret;
  int i = 0;
  char wirtebuf[] = "hello linux";
  char readbuf[128] = {0};
  
  ret = pipe(fd);
  if (ret < 0) {
    printf("creat pipe failed\n");
    return -1;
  }

  printf("write pipe is start\n");

  //hallo linux can only maximal be write as 5456 times, will be overfull and stopped
  while (i < 5456) {
    write(fd[1], wirtebuf, sizeof(wirtebuf));
    i++;
  }
  printf("write pipe is end\n");
    
  close(fd[1]);
  
  return 0;
}

