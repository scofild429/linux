#include <stdio.h>
#include "unistd.h"
#include "stdlib.h"

int main(int argc, char *argv[])
{
  int fd[2];
  int ret;

  ret = pipe(fd);

  //failed return -1
  if (ret < 0) {
    printf("creat pipe failed\n");
    return -1;
  }

  printf("creat pipe success , and fd[0] = %d , and fd[1] = %d !\n", fd[0], fd[1]);
  
  return 0;
}

