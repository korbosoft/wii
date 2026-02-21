PROGS = zeventig tachtig negentig tpl2ppm
PROGS += dol2elf tmd-dump zelda-cksum twintig
COMMON = tools.o bn.o ec.o my_getopt.o
ZESTIG = zestig
ZESTIGL = ecc.o sha1.o fs_hmac.o
DEFINES = -DLARGE_FILES -D_FILE_OFFSET_BITS=64
LIBS = -lcrypto

CC = x86_64-w64-mingw32-gcc
CFLAGS = -Wall -W -Os
LDFLAGS =


OBJS = $(patsubst %,%.o,$(PROGS) $(ZESTIG)) $(COMMON) $(ZESTIGL)

all: $(PROGS) $(ZESTIG)

$(PROGS): %: %.o $(COMMON) Makefile
	$(CC) $(CFLAGS) $(LDFLAGS) $< $(COMMON) $(LIBS) -o $@

$(ZESTIG): %: %.o $(COMMON) $(ZESTIGL) Makefile
	$(CC) $(CFLAGS) $(LDFLAGS) $< $(COMMON) $(ZESTIGL) $(LIBS) -o $@

$(OBJS): %.o: %.c tools.h Makefile
	$(CC) $(CFLAGS) $(DEFINES) -c $< -o $@

clean:
	-rm -rf $(OBJS) $(PROGS) dist

dist:
	mkdir dist
	cp /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libcrypto-3-x64.dll dist/
	cp /usr/x86_64-w64-mingw32/sys-root/mingw/bin/zlib1.dll dist/
