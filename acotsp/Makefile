# Makefile for ACOTSP
VERSION=1.03

CC = gcc
OPTIM_FLAGS = -O3
WARN_FLAGS = -Wall -std=c99 -pedantic -Wno-unused-result
# PROF_FLAGS = -pg -fprofile-arcs -ftest-coverage
# DEBUG_FLAGS = -g
PAR_FLAGS = -fopenmp
CFLAGS = $(WARN_FLAGS) $(OPTIM_FLAGS) $(PROF_FLAGS) $(DEBUG_FLAGS)

LDLIBS = -lm

# To change the default timer implementation, uncomment the line below
# or call 'make TIMER=unix'
#TIMER = dos
TIMER = unix

all: clean acotsp omp_acotsp old_acotsp

clean:
	@$(RM) ./out/* acotsp omp_acotsp

acotsp: ./out/acotsp.o ./out/TSP.o ./out/ants.o ./out/InOut.o ./out/utilities.o ./out/ls.o ./out/parse.o ./out/$(TIMER)_timer.o
	$(CC) $(CFLAGS) -Wno-unknown-pragmas -o acotsp $^ $(LDLIBS)

./out/acotsp.o: ./src/acotsp.c
	$(CC) $(CFLAGS) -c -Wno-unknown-pragmas -o $@ $<

./out/$(TIMER)_timer.o: ./src/$(TIMER)_timer.c ./src/timer.h
	$(CC) $(CFLAGS) -c -Wno-unknown-pragmas -o $@ $<

./out/%.o: ./src/%.c ./src/%.h
	$(CC) $(CFLAGS) -c -Wno-unknown-pragmas -o $@ $<

# OpenMP section - only certain files need special compilation
omp_acotsp: ./out/omp_acotsp.o ./out/TSP.o ./out/omp_ants.o ./out/InOut.o ./out/utilities.o ./out/ls.o ./out/parse.o ./out/$(TIMER)_timer.o
	$(CC) $(CFLAGS) $(PAR_FLAGS) -o omp_acotsp $^ $(LDLIBS)

./out/omp_acotsp.o: ./src/acotsp.c
	$(CC) $(CFLAGS) $(PAR_FLAGS) -c -o $@ $<

./out/omp_ants.o: ./src/ants.c ./src/ants.h
	$(CC) $(CFLAGS) $(PAR_FLAGS) -c -o $@ $<

# Old OpenMP section
old_acotsp: ./out/omp_acotsp.o ./out/TSP.o ./out/old_ants.o ./out/InOut.o ./out/utilities.o ./out/ls.o ./out/parse.o ./out/$(TIMER)_timer.o
	$(CC) $(CFLAGS) $(PAR_FLAGS) -o old_acotsp $^ $(LDLIBS)

./out/old_ants.o: ./src/ants_old.c ./src/ants.h
	$(CC) $(CFLAGS) $(PAR_FLAGS) -c -o $@ $<