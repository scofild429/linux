#include <stdio.h>
#include "unistd.h"
#include "stdio.h"
#include "sys/types.h"
#include "stdlib.h"

int main(int argc, char *argv[])
{
  pid_t pid;
  char process_inter = 0;
  // add pipe to commu
  int fd[2];
  int ret;
  ret = pipe(fd);
  if (ret < 0) {
    printf("creat pipe failed\n");
    return -1;
  }
  printf("creat pipe success \n");
  
  pid = fork(); // pipe 的文件描述符也会被复制，指向同一管道，所以能相互通信

  if (pid == 0) {  // child process
    read(fd[0], &process_inter,1); // if pipe empth, sleep
    while (process_inter == 0);
    int i = 0;
    for (i = 0; i < 5; ++i) {
      printf("this is child process and i = %d\n", i);
      usleep(100);
    }
  }

  if (pid > 0) { // parent process
    int i = 0;
    for (i = 0; i < 5; ++i) {
      printf("this is parent process and i = %d\n",i );
      usleep(100);
    }
    process_inter = 1;
    sleep(3);
    write(fd[1], &process_inter, 1);
  }

  close(fd[1]);
  while (1);
  
  return 0;
}
