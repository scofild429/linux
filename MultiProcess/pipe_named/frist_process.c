#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "fcntl.h"
#include "stdlib.h"
#include "string.h"

/* int main() */
/* { */
/*   int i = 0; */
/*   char process_inter [5] = {0}; */
/*   int fd; */
/*   char process [5] = {0}; */
/*   int j; */
/*   int k; */
  
/*   fd = open("./fifo", O_RDWR); */
/*   if (fd < 0) { */
/*     printf("open myfifo failed \n"); */
/*     return -1; */
/*   } */
/*   printf("open myfifo succuss in first\n"); */
  
/*   for (i = 0; i < 5; ++i) { */
/*     printf("this is the first process i = %d \n", i); */
/*     usleep(100); */
/*   } */
/*   //  system("cat fifo"); */

    
/*   read(fd, &j, 1); */
/*   printf("process is %d .\n", j); */

/*   while (1); */
  
/*   printf("process_inter is %s .\n", process_inter); */
/*   scanf("%s", process_inter); */

/*   //  sleep(1);   */
/*   write(fd, &process_inter ,strlen(process_inter)); */
  
/*   read(fd, process, strlen(process_inter)); */
/*   printf("process is %s .\n", process); */
  
/*   close(fd); */

/*   while (1);     */
/*   return 0; */
/* } */

int main(int argc, char *argv[])
{
  int fd;
  char process_inter = 0;
  int i ;
  
  fd = open("./fifo", O_WRONLY);
  if (fd < 0 ) {
    printf("open failed \n");
    return -1;
  }
  printf("sarting  \n");


  for (i = 0; i < 5; ++i) {
    printf("this is the first process i = %d \n", i);
    usleep(100);
  }

  process_inter = 1;
  sleep(3);
  write(fd, &process_inter, 1);
  
  while (1);
  return 0;
}

