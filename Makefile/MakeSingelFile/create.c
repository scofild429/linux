#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
void *mythread1(void)
{
  int i;
  for(i=0;i<5;i++)
    {
      printf("I am the first pthread!\n");
      sleep(2);
    }
}

void *mythread2(void)
{
  int i;
  for(i=0;i<5;i++)
    {
      printf("I am the second pthread!\n");
      sleep(2);
    }
}

int main()
{
  pthread_t id1, id2;
  int res;
  res=pthread_create(&id1, NULL,(void *)mythread1,NULL);
  if(res)
    {printf("Create pthread from pid 1!");
      return 1;
    }
  res=pthread_create(&id2, NULL,(void *)mythread2,NULL);
  if(res)
    {printf("Create pthread from pid 2!");
      return 1;
    }
  pthread_join(id1,NULL);
  pthread_join(id2,NULL);
  return 1;
}
