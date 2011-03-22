
dirs = 	hello \
	subroutines/subcalls \
  abend \
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


