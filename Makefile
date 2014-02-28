CC=gcc
CXX=g++
CXXFLAGS = -m32 -O3 -g0 -march=i686
LDFLAGS = $(CXXFLAGS)

dnsseed: dns.o toakrona.o netbase.o protocol.o db.o main.o util.o
	$(CXX) -pthread $(LDFLAGS) -o dnsseed dns.o toakrona.o netbase.o protocol.o db.o main.o util.o -lcrypto

%.o: %.cpp toakrona.h netbase.h protocol.h db.h serialize.h uint256.h util.h
	$(CXX) -DUSE_IPV6 -pthread $(CXXFLAGS) -Wno-invalid-offsetof -c -o $@ $<

dns.o: dns.c
	$(CC) -pthread -std=c99 $(CXXFLAGS) dns.c -c -o dns.o

%.o: %.cpp
