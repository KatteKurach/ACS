#include "stdafx.h"
#include <iostream>
#include <string>
#include <conio.h>

using namespace std;

float a[8] = { -2, 4.24, 1.12, 5.32, 6.12, 312.14, 9.1, 1 };
float b[8] = { 9, 243.24, 4.12, 312.1, 1.3, 4.3, 5.32, 6313.32 };
float c[8] = { 1, 3.524, 1.24, 3.6, 932.1, 821.76, 3.432, 1.21 };

double d[8] = { 1.5, 2.232333, 31, 4.2, 1.5423, 60.7, 72.4, 1.1 };
double f[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };


void write_array1(float a[], string name)
{
	cout << "Array: " << name << endl;

	for (int i = 0; i < 8; i++) {
		cout << a[i] << "   ";
	}
	cout << endl;
}


void write_array2(double a[], string name)
{
	cout << "Array: " << name << endl;

	for (int i = 0; i < 8; i++) {
		cout << a[i] << "   ";
	}
	cout << endl;
}

double read_num2(int maxSize) 
{
	double number = 0;
	int por = 0;
	bool dot = false;
	bool minus = false;
	string snum = "";

	while (true)
	{
		char num = _getch();

		if (num == 8) {
			if ((int)snum.size() == 0) { continue; }
			if ((int)snum.size() == 1 && minus)
			{
				minus = false;
				snum.pop_back();
				cout << '\b' << ' ' << '\b';
				continue;
			}
			if (por == 0 && dot)
			{
				dot = false;
				cout << '\b' << ' ' << '\b';
				continue;
			}
			if (dot && por >= 1)
			{
				por--;
				snum.pop_back();
				double temp = number / 10;
				number = (int)temp;
				maxSize++;
				cout << '\b' << ' ' << '\b';
				continue;
			}

			snum.pop_back();
			double temp = number / 10;
			number = (int)temp;
			cout << '\b' << ' ' << '\b';
			maxSize++;
			continue;
		}

		if (maxSize == 0)
		{
			while (por != 0)
			{
				number /= 10;
				por--;
			}
			if (minus) { return -number; }
			else { return number; }
		}

		if (num == 32 || num == '\r')
		{
			if ((int)snum.size() == 1 && minus == true) { continue; }
			if ((int)snum.size() == 0) { continue; }
			if (por == 0 && dot)
			{
				cout << '\b' << ' ' << '\b';
				if (minus) { return -number; }
				else { return number; }
			}
			while (por != 0)
			{
				number /= 10;
				por--;
			}
			if (minus) { return -number; }
			else { return number; }
		}

		if (num == '-')
		{
			if (minus) { continue;  }
			if ((int)snum.size() != 0) { continue; }
			snum += '-';
			minus = true;
			cout << "-";
			continue;
		}

		if (num == '.') {
			if (dot) { continue; }
			if ((int)snum.size() == 0) { continue; }
			if ((int)snum.size() == 1 && minus) { continue; }
			cout << ".";
			dot = true;
			continue;
		}

		if (num >= '0' && num <= '9') {
			if (dot)
			{
				por++;
			}
			int newNum = number * 10;
			newNum += num - '0';
			snum += num;
			number = newNum;
			cout << num;
		}
		maxSize--;
	}
}

float read_num1(int maxSize)
{
	float number = 0;
	int por = 0;
	bool dot = false;
	bool minus = false;
	string snum = "";

	while (true)
	{
		char num = _getch();

		if (num == 8) {
			if ((int)snum.size() == 0) { continue; }
			if ((int)snum.size() == 1 && minus)
			{
				minus = false;
				snum.pop_back();
				cout << '\b' << ' ' << '\b';
				continue;
			}
			if (por == 0 && dot)
			{
				dot = false;
				cout << '\b' << ' ' << '\b';
				continue;
			}
			if (dot && por >= 1)
			{
				por--;
				snum.pop_back();
				double temp = number / 10;
				number = (int)temp;
				maxSize++;
				cout << '\b' << ' ' << '\b';
				continue;
			}

			snum.pop_back();
			double temp = number / 10;
			number = (int)temp;
			cout << '\b' << ' ' << '\b';
			maxSize++;
			continue;
		}

		if (maxSize == 0)
		{
			while (por != 0)
			{
				number /= 10;
				por--;
			}
			if (minus) { return -number; }
			else { return number; }
		}

		if (num == 32 || num == '\r')
		{
			if ((int)snum.size() == 1 && minus == true) { continue; }
			if ((int)snum.size() == 0) { continue; }
			if (por == 0 && dot)
			{
				cout << '\b' << ' ' << '\b';
				if (minus) { return -number; }
				else { return number; }
			}
			while (por != 0)
			{
				number /= 10;
				por--;
			}
			if (minus) { return -number; }
			else { return number; }
		}

		if (num == '-')
		{
			if (minus) { continue; }
			if ((int)snum.size() != 0) { continue; }
			snum += '-';
			minus = true;
			cout << "-";
			continue;
		}

		if (num == '.') {
			if (dot) { continue; }
			if ((int)snum.size() == 0) { continue; }
			if ((int)snum.size() == 1 && minus) { continue; }
			cout << ".";
			dot = true;
			continue;
		}

		if (num >= '0' && num <= '9') {
			if (dot)
			{
				por++;
			}
			int newNum = number * 10;
			newNum += num - '0';
			snum += num;
			number = newNum;
			cout << num;
		}
		maxSize--;
	}
}


void read_array1(float a[], string name, int max)
{
	cout << "Array: " << name << endl;
	for (int i = 0; i < 8; i++)
	{
		a[i] = read_num1(max);
		cout << " ";
	}
	cout << endl;
}

void read_array2(double a[], string name, int max)
{
	cout << "Array: " << name << endl;
	for (int i = 0; i < 8; i++)
	{
		a[i] = read_num2(max);
		cout << " ";
	}
	cout << endl;
}

int main()
{
	cout << "________F[i] = (A[i] - B[i]) + (C[i] * D[i])________" << endl;
	
	write_array1(a, "A");
	write_array1(b, "B");
	write_array1(c, "C");
	write_array2(d, "D");

	/*
	read_array1(a, "A", 5);
	read_array1(b, "B", 5);
	read_array1(c, "C", 5);
	read_array2(d, "D", 7);*/

	__asm {
			movups xmm0, a[TYPE a * 0]
			movups xmm1, a[TYPE a * 4]
			movups xmm2, b[TYPE b * 0]
			movups xmm3, b[TYPE b * 4]

			subps xmm0, xmm2 //a[1-4] -= b[1-4] (32)
			subps xmm1, xmm3 //a[5-8] -= b[5-8]	

			/*	                    //xmm0 = abcd (32)
			cvtps2pd xmm5, xmm0 //xmm5 = ab (64)
			movups xmm2, xmm0   //xmm2 = xmm0 = abcd
			unpckhps xmm0, xmm2 //xmm0 = ccdd
			movq xmm2, xmm0     //xmm2 = xmm0 = ccdd
			unpcklps xmm2, xmm0 //xmm2 = cccc
			unpckhps xmm2, xmm0 //xmm2 = cdcd
			cvtps2pd xmm4, xmm2 //xmm4 = cd(64)*/

			movups xmm7, c[TYPE c * 0]
			movups xmm2, c[TYPE c * 4]

			cvtps2pd xmm3, xmm7 //xmm3=с[1-2] 
			shufps xmm7, xmm7, 01001110b
			cvtps2pd xmm4, xmm7 //xmm4=c[3-4]

			cvtps2pd xmm5, xmm2 //xmm5=c[5-6] 
			shufps xmm2, xmm2, 01001110b
			cvtps2pd xmm6, xmm2 //xmm6=c[7-8]

			mulpd xmm3, d[TYPE d * 0]  //c[1-2]*d[1-2]
			mulpd xmm4, d[TYPE d * 2]  //c[3-4]*d[3-4]
			mulpd xmm5, d[TYPE d * 4]  //c[5-6]*d[5-6]
			mulpd xmm6, d[TYPE d * 6]  //c[7-8]*d[7-8]

			cvtps2pd xmm2, xmm0 // xmm0 = abcd -> xmm2 = ab(64) --- xmm2=a[1-2]-b[1-2] 
			shufps xmm0, xmm0, 01001110b //xmm0 = cdab(32) <-b
			cvtps2pd xmm7, xmm0 //xmm7 = cd(64) --- xmm7=a[3-4]-b[3-4]

			addpd xmm3, xmm2
			addpd xmm4, xmm7
			movupd f[TYPE f * 0], xmm3
			movupd f[TYPE f * 2], xmm4

			cvtps2pd xmm0, xmm1 //xmm0=a[5-6]-b[5-6] 
			shufps xmm1, xmm1, 01001110b
			cvtps2pd xmm2, xmm1 //xmm2=a[7-8]-b[7-8]

			addpd xmm5, xmm0
			addpd xmm6, xmm2
			movupd f[TYPE f * 4], xmm5
			movupd f[TYPE f * 6], xmm6
	}

	cout << endl;
	cout << "RESULT: " << endl;
	write_array2(f, "F");

	/*for (int i = 0; i < 8; i++) 
	{
		cout << a[i] - b[i] + c[i] * d[i] << "  ";
	}
	cout << endl;*/

	system("pause");
}

