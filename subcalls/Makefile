
# include ../make.common

MMIXAL = mmixal
SRC_SUFF = mms
OBJ_SUFF = mmo
LST_SUFF = map

ifndef TARG
TARG = subcalls
endif

here = $(shell pwd)
bottom = $(shell basename $(here))

all:
	make $(TARG)

$(TARG):
	$(MMIXAL) -l $(TARG).$(LST_SUFF) -o $(TARG).$(OBJ_SUFF) $(TARG).$(SRC_SUFF)

clean:
	rm -rf *.$(LST_SUFF) *.$(OBJ_SUFF)

