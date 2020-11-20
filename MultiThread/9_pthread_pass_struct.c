#include "apue.h"

struct student {
  int age;
  char name[10];
  char subject[10];
};

void *thread_fun(void *stu)
{
  printf("In the constuction we have age : %d, name : %s, and subject %s.\n", ((struct  student *)stu)->age,((struct student *)stu)->name, ((struct student *)stu)->subject);
  return (void *)0;
}
  
int main( )
{
  pthread_t tid;
  int err;
  void * val;
  
  struct student stu;
  stu.age = 20;
  memcpy(stu.name, "xiang", 10);
  memcpy(stu.subject, "phyics", 10);

  err = pthread_create(&tid, NULL, thread_fun, (void *)&stu);
  if (err != 0) {
    printf("the new thread is failed to create\n");
    return  0;
  }
  pthread_exit(val);
  return 0;
}




