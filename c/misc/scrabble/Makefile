# Generated automatically from Makefile.in by configure.
# PROFILE=-pg
MYMALLOC=-DMYMALLOC
CC=gcc
CFLAGS=-g -O2  -DDICTIONARY=\"/usr/share/dict/words\" -DSTDC_HEADERS=1 -DHAVE_STRDUP=1  $(PROFILE)
LDFLAGS=
BOOTSTRAPOBJ=scoring_bootstrap.o dict_bootstrap.o 
OBJ=dictionary.o scores.o scoring.o dict.o search.o
LIB=-L. -lscrabble
RANLIB=ranlib
AR=/usr/bin/ar

all: search

search: libscrabble.a search_main.o
	$(CC) $(PROFILE) $(CFLAGS) -o $@ search_main.o $(LDFLAGS) $(LIB)

dict: dict_main.o libscrabble.a
	$(CC) $(PROFILE) $(CFLAGS) -o $@ dict_main.o $(LDFLAGS) $(LIB)

scoring: scoring_main.o libscrabble.a
	$(CC) $(PROFILE) $(CFLAGS) -o $@ scoring_main.o $(LDFLAGS) $(LIB)

libscrabble.a: $(OBJ)
	$(AR) rc $@ $(OBJ)
	$(RANLIB) $@

# Bootstrap scrabble lib
libbscrabble.a: $(BOOTSTRAPOBJ)
	$(AR) rc $@ $(BOOTSTRAPOBJ)
	$(RANLIB) $@

dict_main.o: dict.c
	$(CC) $(CFLAGS) $(PROFILE) -DDICT_MAIN -c -o $@ dict.c

search_main.o: search.c
	$(CC) $(CFLAGS) $(PROFILE) -DSEARCH_MAIN -c -o $@ search.c

scoring_main.o: scoring.c
	$(CC) $(CFLAGS) $(PROFILE) -DSCORING_MAIN -c -o $@ scoring.c

scoring_bootstrap.o: scoring.c
	$(CC) $(CFLAGS) $(PROFILE) -DBOOTSTRAP -c -o $@ scoring.c

dict_bootstrap.o: dict.c
	$(CC) $(CFLAGS) $(PROFILE) -DBOOTSTRAP -c -o $@ dict.c

dict.c: dict.h

scores.c: buildit
	./buildit

dictionary.h: buildit
	./buildit

dictionary.c: buildit
	./buildit

buildit: buildit.o libbscrabble.a
	$(CC) $(CFLAGS) -o $@ buildit.o libbscrabble.a

buildit.o:
	$(CC) $(CFLAGS) $(PROFILE) -DBOOTSTRAP -c -o $@ buildit.c

mymalloc/mymalloc.o: mymalloc/mymalloc.c mymalloc/mymalloc.h
	cd mymalloc && $(CC) $(MYMALLOC) -o mymalloc.o -c mymalloc.c

clean:
	rm -f libscrabble.a dict_main.o search_main.o scoring_main.o \
		$(OBJ) dict search scoring scores.c buildit buildit.o \
		scoring_bootstrap.o dict_bootstrap.o dictionary.c libbscrabble.a \
		dictionary.h

distclean: clean
	rm -f Makefile config.cache config.log config.status
