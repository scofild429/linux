#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

// 在服务端，是用bind 和listen函数，
// 有socket函数生成的serv_sock套接字，
// 还有利用函数accept 和serv_sock生成的clnt_sock套接字。
// 注意： 在相互通信时，利用clnt_sock可以读也可以写。

// 而在客户端，是用connect函数，
// 只有利用socket函数生成的sock套接字，
// 同时可以读可以写

// 在字符串读写时，读出时不知其大小，用整个长度，写入时可用strlen()函数



int main(){

  int sock = socket(AF_INET, SOCK_STREAM, 0);
  struct sockaddr_in serv_addr;
  memset(&serv_addr, 0, sizeof(serv_addr)); 
  serv_addr.sin_family = AF_INET; 
  serv_addr.sin_addr.s_addr = inet_addr("127.0.0.1"); 
  serv_addr.sin_port = htons(1234); 
  connect(sock, (struct sockaddr*)&serv_addr, sizeof(serv_addr));

  // 只有服务器发给用户一条信息
  // char buffer[40];
  // memset(buffer, 0, 40);
  // read(sock, buffer, sizeof(buffer)-1);
  // printf("Message form server: %s\n", buffer);
  // close(sock);

  // 一次由用户发给服务器再回传
  // char buffer[] = "nihao";
  // write(sock, buffer, strlen(buffer));
  // char buffer1[40];
  // read(sock, buffer1, sizeof(buffer1));
  // printf("Message form server: %s\n", buffer1);
  // close(sock);

  // //五次发送回传
  // char bufsend[40];
  // char bufrecv[40];
  // memset(bufrecv, 0, 40);
  // memset(bufsend, 0, 40);
  // int i = 0;
  // while (i < 5) {
  //   int sock1 = socket(AF_INET, SOCK_STREAM, 0);
  //   connect(sock1, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
  //   printf("input your massages!\n");
  //   scanf("%s",bufsend);
  //   write(sock1, bufsend, strlen(bufsend));
  //   read(sock1, bufrecv, 40);
  //   printf("%s\n",bufrecv);
  //   memset(bufrecv, 0, 40);
  //   memset(bufsend, 0, 40);
  //   close(sock1);
  //   i++;
  // }
    

  //传送文件
  //110.org 不一定要存在
  FILE *fp = fopen("110.org", "wb+"); 
  if(fp == NULL){
    printf("Cannot open file, press any key to exit!\n");
    system("pause");
    exit(0);
  }
  char bufsend[40];
  memset(bufsend, 0, 40);
  int nConut;
  while ( (nConut = read(sock, bufsend, 40)) > 0 ) {
    fwrite(bufsend, nConut, 1, fp);
  }
  fclose(fp);
  close(sock);

  return 0;
}
