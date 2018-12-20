# Makefile template for AccidentalNoise

CC = g++
src = $(wildcard src/*.cpp)
obj = $(src:.cpp=.o)
dep = $(obj:.o=.d)  # one dependency file for each source

TARGET_LIB = libnoise.so
LDFLAGS = -shared
#CPPFLAGS = -I ./include -fPIC -Wall -Wextra -O2 -g
CPPFLAGS = -I ./include -fPIC -O2 -g

$(TARGET_LIB): $(obj)
	$(CC) ${LDFLAGS} -o $@ $^ 

-include $(dep)   # include all dep files in the makefile

# rule to generate a dep file by using the C preprocessor
# (see man cpp for details on the -MM and -MT options)
%.d: %.cpp
	@$(CPP) $(CPPFLAGS) $< -MM -MT $(@:.d=.o) >$@

.PHONY: clean
clean:
	rm -f $(obj) $(dep) TARGET_LIB
