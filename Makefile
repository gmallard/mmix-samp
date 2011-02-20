
dirs = 	hello \
	subroutines/subcalls \
  abend \
  tscan1 \
  tscan2 \
  tscan3 \
  tscan4 \
  loctest \
  exampmw \
  fread1 \
  tscan4a \
  subroutines/subcallspg \
  subroutines/subcallspj \
  interact1 \
  subroutines/subcalls2 \
  subroutines/subcallsjt \

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


