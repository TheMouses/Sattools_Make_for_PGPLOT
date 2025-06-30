#Compiling flags,
CFLAGS = -O3 -Wno-unused-result

#Linking flags,
LFLAGS = -lm -lcpgplot -lpgplot -lX11 -lwcs -lgsl -lgslcblas -lpng

#Compilers,
CC = gcc
F77 = gfortran

all:
	mkdir -p ../bin
	make faketle residuals satfit satmap satorbit tleinfo pass launchtle skymap allnight

faketle: faketle.o sgdp4.o satutl.o deep.o ferror.o
	$(CC) -o ../bin/faketle faketle.o sgdp4.o satutl.o deep.o ferror.o -lm

skymap: skymap.o sgdp4.o satutl.o deep.o ferror.o
	$(F77) -o ../bin/skymap skymap.o sgdp4.o satutl.o deep.o ferror.o $(LFLAGS)

tleinfo: tleinfo.o sgdp4.o satutl.o deep.o ferror.o
	$(CC) -o ../bin/tleinfo tleinfo.o sgdp4.o satutl.o deep.o ferror.o -lm

satorbit: satorbit.o sgdp4.o satutl.o deep.o ferror.o
	$(F77) -o ../bin/satorbit satorbit.o sgdp4.o satutl.o deep.o ferror.o $(LFLAGS)

satmap: satmap.o sgdp4.o satutl.o deep.o ferror.o
	$(F77) -o ../bin/satmap satmap.o sgdp4.o satutl.o deep.o ferror.o $(LFLAGS)

residuals: residuals.o sgdp4.o satutl.o deep.o ferror.o
	$(CC) -o ../bin/residuals residuals.o sgdp4.o satutl.o deep.o ferror.o -lm -lwcs

satfit: satfit.o sgdp4.o satutl.o deep.o ferror.o versafit.o dsmin.o simplex.o
	$(F77) -o ../bin/satfit satfit.o sgdp4.o satutl.o deep.o ferror.o versafit.o dsmin.o simplex.o $(LFLAGS)

pass: pass.o sgdp4.o satutl.o deep.o ferror.o
	$(CC) -o ../bin/pass pass.o sgdp4.o satutl.o deep.o ferror.o -lm

launchtle: launchtle.o sgdp4.o satutl.o deep.o ferror.o
	$(CC) -o ../bin/launchtle launchtle.o sgdp4.o satutl.o deep.o ferror.o -lm

allnight: allnight.o
	$(CC) -o ../bin/allnight allnight.o -lm

clean:
	rm -f .o
	rm -f~
	rm -f ../bin/*
