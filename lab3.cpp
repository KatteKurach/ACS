#include "stdafx.h"
#include <iostream>
#include <string>
#include <conio.h>

using namespace std;

	void print_array(__int8 a[], string name) 
	{
		cout << "Massive: " << name << endl;
		for (int i = 0; i < 8; i++)
		{
			cout << (int)a[i] << " ";
		}
		cout << endl;
	}

	void print_array1(_int16 a[], string name)
	{
		cout << "Massive: " << name << endl;
		for (int i = 0; i < 8; i++)
		{
			cout << (int)a[i] << " ";
		}
		cout << endl;
	}

	void print_array2(__int32 a[])
	{
		for (int i = 0; i < 8; i++)
		{
			cout << (int)a[i] << " ";
		}
		cout << endl;
	}

	int read_num(int base)
	{
		int L = (int)pow(2, base - 1) * (-1);
		int R = (int)pow(2, base - 1) - 1;

		int num = 0;
		int index = 0;
		string snum = "";
		bool minus = false;

		while (true)
		{
			int max = 0;
			char symb = _getch();

			if (symb == 32 || symb == '\r')
			{
				if ((int)snum.size() == 0) {
					continue;
				}
				if ((int)snum.size() == 1 && minus) {
					continue;
				}

				if (minus) {
					return -num; 
				}
				else {
					return num;
				}
			}

			if (symb == 45)
			{
				if ((int)snum.size() != 0) {
					continue;
				} 
				snum += '-';
				minus = true;
				cout << "-";
				continue;
			}

			if (symb >= '0' && symb <= '9') {
				int newNum = num * 10;
				newNum += symb - '0';
				
				if (L <= newNum && newNum <= R) {
					num = newNum;
					cout << symb;
					snum += symb;
				}
				else {
					continue;
				}
			}

			if (symb == 8) {
				if ((int)snum.size() == 0) {
					continue;
				}

				if ((int)snum.size() == 1 && minus) {
					minus = false;
					snum.pop_back();
					cout << '\b' << ' ' << '\b';
					continue;
				}

				snum.pop_back();
				num /= 10;
				cout << '\b' << ' ' << '\b';
			}
		}
	}

	void read_array(_int8 a[], string name) 
	{
		cout << "Massive: " << name << endl;

		int i = 0;

		while (i != 8)
		{
			a[i] =  read_num(8);
			cout << ' ';
			i++;
		}
		cout << endl;
	}


	void read_array1(_int16 a[], string name)
	{
		cout << "Massive: " << name << endl;

		int i = 0;

		while (i != 8)
		{
			a[i] = read_num(16);
			cout << ' ';
			i++;
		}
		cout << endl;	
	}

	int main()
	{
		__int32 zero = 0;
		__int8 a[8] = { -2, 4, 1, 5, 6, 12, 9, 1 };
		__int8 b[8] = { 9, 2, 4, 3, 1, 4, 5, 6};
		__int8 c[8] = { 1, 3, 1, 3, 9, 8, 3, 1 };
		__int16 d[8] = { 1, 2, 3, 4, 1200, 6, 7, 1 };
		__int16 f1[8] = {};
		__int32 f[8] = {};

		cout << "F[i] = (A[i] - B[i]) + (C[i] * D[i])" << endl;
		/*read_array(a, "A");
		read_array(b, "B");
		read_array(c, "C");
		read_array1(d, "D");*/

		print_array(a, "A");
		print_array(b, "B");
		print_array(c, "C");
		print_array1(d, "D");

		__asm {

			movq mm0, a
			movq mm1, mm0
			pxor mm2, mm2
			pcmpgtb mm2, mm0
			punpcklbw mm0, mm2
			punpckhbw mm1, mm2

			movq mm2, b
			movq mm3, mm2
			pxor mm4, mm4
			pcmpgtb mm4, mm2
			punpcklbw mm3, mm4
			punpckhbw mm2, mm4

			psubsw mm0, mm3   //a[1-4] - b[1-4] -> mm0
 			psubsw mm1, mm2   //a[5-8] - b[5-8] -> mm1

			movq mm2, c
			movq mm3, mm2
			pxor mm4, mm4
			pcmpgtb mm4, mm2
			punpcklbw mm2, mm4
			punpckhbw mm3, mm4

			pmullw mm2, d[TYPE d * 0]  //c[1-4] * d[1-4] -> mm2
			pmullw mm3, d[TYPE d* 4]  //c[5-8] * d[5-8] -> mm3

			paddsw mm0, mm2   //mm0 += mm2
			paddsw mm1, mm3   //mm1 += mm3
			
			/*movq mm2, mm0
			movq mm3, mm2
			pxor mm4, mm4
			pcmpgtb mm4, mm2
			punpcklwd mm2, mm4
			punpckhwd mm3, mm4

			movq mm4, mm1
			movq mm5, mm4
			pxor mm6, mm6
			pcmpgtb mm6, mm4
			punpcklwd mm4, mm6
			punpckhwd mm5, mm6*/

			movq f1[TYPE f1 * 0], mm0
			movq f1[TYPE f1 * 4], mm1
		} 

		cout << "RESULT: " << endl;
		print_array1(f1, "F");
		system("pause");
	}


