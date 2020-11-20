create : create.o
	gcc -o  create -pthread create.o && ./create

create.o : create.c
	gcc -c create.c
clean:
	rm -f mcreate create.o
