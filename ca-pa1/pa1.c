//---------------------------------------------------------------
//
//  4190.308 Computer Architecture (Fall 2019)
//
//  Project #1: 64-bit Integer Arithmetic using 32-bit Operations
//
//  September 9, 2019
//
//  Jin-Soo Kim (jinsoo.kim@snu.ac.kr)
//  Systems Software & Architecture Laboratory
//  Dept. of Computer Science and Engineering
//  Seoul National University
//
//---------------------------------------------------------------

#include <stdio.h>
#include "pa1.h"


// NOTE!!!!!
// You should use only 32-bit integer operations inside Uadd64(), Usub64(), 
// Umul64(), and Udiv64() functions. 


// Uadd64() implements the addition of two 64-bit unsigned integers.
// Assume that A and B are the 64-bit unsigned integer represented by
// a and b, respectively. Uadd64() should return x, where x.hi and x.lo 
// contain the upper and lower 32 bits of (A + B), respectively.

HL64 Uadd64 (HL64 a, HL64 b)
{
	HL64 	x;
	x.lo = a.lo + b.lo;
	if(x.lo < a.lo) {
		x.hi += 1;
	}
	x.hi += (a.hi + b.hi);

	return x;
}

// Usub64() implements the subtraction between two 64-bit unsigned integers.
// Assume that A and B are the 64-bit unsigned integer represented by
// a and b, respectively. Usub64() should return x, where x.hi and x.lo 
// contain the upper and lower 32 bits of (A - B), respectively.


HL64 Usub64 (HL64 a, HL64 b)
{
	HL64 	x;
	if(a.lo >= b.lo) {
		x.lo = a.lo - b.lo;
	}
	else {
		x.lo = (1<<32) + a.lo - b.lo;
		a.hi -= 1;
	}
	if(a.hi >= b.hi) {
		x.hi = a.hi - b.hi;
	}
	else {
		x.hi = (1<<32) + a.hi - b.hi;
	}

	return x;
}


// Umul64() implements the multiplication of two 64-bit unsigned integers.
// Assume that A and B are the 64-bit unsigned integer represented by
// a and b, respectively.  Umul64() should return x, where x.hi and x.lo 
// contain the upper and lower 32 bits of (A * B), respectively.

HL64 Umul64 (HL64 a, HL64 b)
{
	HL64 	x;
	x.lo = 0;
	x.hi = 0;
	while(b.lo != 0 || b.hi != 0) {
		if(b.lo & 1) {
			x.lo += a.lo;
			if(x.lo < a.lo) {
				x.hi += 1;
			}
			x.hi += a.hi;
		}
		a.hi <<= 1;
		if((a.lo>>31) & 1) {
			a.hi += 1;
		}
		a.lo <<= 1;
		b.lo >>= 1;
		if(b.hi & 1) {
			b.lo += 0x80000000;
		}
		b.hi >>= 1;
	}

	return x;
}


// Udiv64() implements the division of two 64-bit unsigned integers.
// Assume that A and B are the 64-bit unsigned integer represented by
// a and b, respectively.  Udiv64() should return x, where x.hi and x.lo 
// contain the upper and lower 32 bits of the quotient of (A / B), 
// respectively.

HL64 Udiv64 (HL64 a, HL64 b)
{
	HL64 	x;
	x.lo = 0;
	x.hi = 0;
	if(b.hi == 0 && b.lo == 0) {
		return x;
	}
	for(int i=0; i<=64; i++) {
		if(x.hi < b.hi || (x.hi==b.hi && x.lo < b.lo)) {
			x.hi <<= 1;
			if((x.lo>>31) & 1) {
				x.hi += 1;
			}
			x.lo <<= 1;
			if((a.hi>>31) & 1) {
				x.lo += 1;
			}
			a.hi <<= 1;
			if((a.lo>>31) & 1) {
				a.hi += 1;
			}
			a.lo <<= 1;
		}
		else {
			x = Usub64(x, b);
			x.hi <<= 1;
			if((x.lo>>31) & 1) {
				x.hi += 1;
			}
			x.lo <<= 1;
			if((a.hi>>31) & 1) {
				x.lo += 1;
			}
			a.hi <<= 1;
			if((a.lo>>31) & 1) {
				a.hi += 1;
			}
			a.lo <<= 1;
			a.lo += 1;
		}
	}

	return a;
}


