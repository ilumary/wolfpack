UNAMEOS := $(shell uname)

executable := wolfpack

ifeq ($(UNAMEOS), Linux)
	CXX ?= g++
endif
ifeq ($(UNAMEOS), Darwin)
	CXX = clang++
endif

includes = -I $(abspath .)
compileFlags := -std=c++2b $(includes) -O2

CXXFLAGS := $(compileFlags) -MMD -MP

all: app clean

app: $(executable)

$(executable): main.cpp.o
	$(CXX) main.cpp.o -o $@ $(LDFLAGS)

%.cpp.o: %.cpp Makefile
	$(CXX) $(CXXFLAGS) -c $< -o $@

.PHONY: clean

clean:
	rm *.o
	rm *.d

-include $(deps)
