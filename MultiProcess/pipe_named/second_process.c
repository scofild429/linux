#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "fcntl.h"

/* int main() */
/* { */
/*   int i; */
/*   int process_inter ; */
  
/*   int fd; */
/*   fd = open("./fifo",O_RDWR); */
/*   if (fd < 0) { */
/*     printf("open myfifo failed \n"); */
/*     return -1; */
/*   } */
/*   printf("open myfifo succuss in second \n"); */

/*   read(fd, &process_inter, 1); */
  
/*   while(process_inter == 0); */
  
/*   for (i = 0; i < 5; ++i) { */
/*     printf("this is the second process i = %d \n", i); */
/*     usleep(100); */
/*   } */
  
  
/*   write(fd, &process_inter,1); */
/*   read(fd, &process_inter, 1); */
  
/*   printf("Now the pipe is turn to %d\n", process_inter); */
/*   while (1);     */
/*   return 0; */
/* } */


int main(int argc, char *argv[])
{

  int fd;
  int inter = 0;
  int i;
    
  fd =   open("./fifo", O_RDONLY);
  if (fd < 0) {
    printf("open failed \n");
    return -1;
  }
  printf("starting \n");

  
  read(fd, &inter, 1);
  while (inter == 0);
  for (i = 0; i < 5; ++i) {
    printf("this is the first process i = %d \n", i);
    usleep(100);
  }
  while(1);
  return 0;
}


