#include <stdio.h>
#include "unistd.h"
#include "stdlib.h"
#include "string.h"


int main(int argc, char *argv[])
{
  int fd[2];
  int ret;
  char wirtebuf[] = "hello linux";
  char readbuf[128] = {0};
  
  ret = pipe(fd);

  if (ret < 0) {
    printf("creat pipe failed\n");
    return -1;
  }

  printf("creat pipe success , and fd[0] = %d , and fd[1] = %d !\n", fd[0], fd[1]);

  write(fd[1], wirtebuf, sizeof(wirtebuf));

  //read the frist time, the contxet will be delete.
  read(fd[0], readbuf, sizeof(wirtebuf));
  printf("readbuf is %s \n", readbuf);

  // read seconde time . will be stopped
  memset(readbuf, 0,128);
  read(fd[0], readbuf, sizeof(wirtebuf));
  printf("the seconde time , readbuf is %s \n", readbuf);

  
  close(fd[0]);
  close(fd[1]);

  
  return 0;
}

