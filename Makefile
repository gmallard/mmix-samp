
dirs = 	hello \
	subroutines/subcalls \
  abend \
  dumpregs \
  dumpwork \
  tablescan/tscan1 \
  tablescan/tscan2 \
  tablescan/tscan3 \
  tablescan/tscan4 \
  loctest \
  exampmw \
  fread1 \
  tablescan/tscan4a \
  subroutines/subcallspg \
  subroutines/subcallspj \
  interact1 \
  subroutines/subcalls2 \
  subroutines/subcallsjt \
  subroutines/subpj89 \
  sample \
  memutils \
  memutils_inc \
  morex \
  muxdemo \
  shmemory \
  shspregs \
  xadduex \
  xadduex2 \

.PHONY: $(dirs) clean

all: $(dirs)

$(dirs):
		$(MAKE) -C $@

clean:
	@for i in $(dirs); do \
	echo $$i; \
	curd=`pwd`; \
	cd $$i && $(MAKE) clean; \
	cd $$curd; \
	done


