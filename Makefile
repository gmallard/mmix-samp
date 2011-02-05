
dirs = 	hello \
	subcalls \
  abend \
  tscan1 \
  tscan2 \
  tscan3 \
  tscan4 \
  loctest \
  exampmw \
  fread1 \
  tscan4a \
  subcallspg \

.PHONY: $(dirs) clean

all: $(dirs)

$(dirs):
		$(MAKE) -C $@

clean:
	@for i in $(dirs); do \
	echo $$i; \
	cd $$i && $(MAKE) clean; \
	cd ..; \
	done


