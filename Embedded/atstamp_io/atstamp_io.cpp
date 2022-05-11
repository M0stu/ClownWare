﻿
// Checks status of push button connected to P2.0  (active low)
// When pushed, LED connected to P1.0 flashes five times
#include "ATSTAMP.h"
#include <stdio.h>
#include <conio.h>
#include <windows.h>

// i.o pins 1
#define ot0 P0,0
#define ot1 P0,1
#define in0 P2.0

// i.o pins 2
#define ot2 P0,2
#define ot3 P0,3
#define in1 P2.1

// i.o pins 3
#define ot4 P0,4
#define ot5 P0,5
#define in2 P2.2

// i.o pins 3
#define ot6 P0,6
#define ot7 P0,7
#define in3 P2.3

//Global Variables
			//NoNe  And   OR    Xor  TsBuf  NOR  NAND  Hex-inv
int chips[8] = {0, 7408, 7432, 7486, 74125,7402, 7400 , 7404 };
int chip = 0;

void check();


void And(){
check();


	clr(ot0);
	clr(ot1);

	clr(ot2);
	setb(ot3);


	setb(ot4);
	clr(ot5);


	setb(ot6);
	setb(ot7);

		if(!GetBit(P2,0)){
			if(!GetBit(P2,1)){
				if(!GetBit(P2,2)){
					if(GetBit(P2,3)){

					chip = 1; }}}}

}


void Nand(){
check();


	clr(ot0);
	clr(ot1);

	clr(ot2);
	setb(ot3);


	setb(ot4);
	clr(ot5);


	setb(ot6);
	setb(ot7);

		if(GetBit(P2,0)){
			if(GetBit(P2,1)){
				if(GetBit(P2,2)){
					if(!GetBit(P2,3)){

					chip = 6; }}}}

}

void Or(){
check();

	setb(ot0);
	clr(ot1);

	clr(ot2);
	clr(ot3);


	clr(ot4);
	setb(ot5);



	setb(ot6);
	setb(ot7);


		if(!GetBit(P2,0)){
			if(GetBit(P2,1)){
				if(!GetBit(P2,2)) {
					if(!GetBit(P2,3)) {
						chip = 2;
					}}}}











}

void Nor(){
check();
	//1
	clr(P2,0);
	clr(ot1);

	//0
	clr(ot3);
	setb(P2,1);

	//0
	clr(P2,2);
	setb(ot5);
	//0
	setb(ot6);
	setb(P2,3);


		if(GetBit(P0,0)){
			if(!GetBit(P0,2)){
				if(!GetBit(P0,4)) {
					if(!GetBit(P0,7)) {
						chip = 5;

					}}}}





}

void Xor(){
check();

	clr(ot0);
	clr(ot1);

	clr(ot2);
	setb(ot3);


	setb(ot4);
	clr(ot5);



	setb(ot6);
	setb(ot7);

		if(!GetBit(P2,0))
			if(GetBit(P2,1))
				if(GetBit(P2,2))
					if(!GetBit(P2,3)){
						chip = 3;
					}

}

//Tri-State Buffer
void tsBuffer(){
	check();
	// C
	setb(ot0);
	// A
	clr(ot1);

	setb(ot2);
	clr(ot3);


	clr(ot4);
	setb(ot5);



	clr(ot6);
	clr(ot7);

		if(!GetBit(P2,0))
			if(!GetBit(P2,1))
				if(GetBit(P2,2))
					if(!GetBit(P2,3)) {
						chip=4;
					}

}
int flag;
hexinv(){


	clr(ot0);
	clr(ot2);
	clr(ot4);
	clr(ot6);
	clr(P2,0);
	clr(P2,2);
	if(ot1)
		if(ot3)
			if(ot5)
				if(ot7)
					if(P2,3)
						if(P2,1){
	setb(ot0);
	setb(ot2);
	setb(ot4);
	setb(ot6);
	setb(P2,0);
	setb(P2,2);
	if(!ot1)
		if(!ot3)
			if(!ot5)
				if(!ot7)
					if(!P2,3)
						if(!P2,1){
							chip=7;
							}

						}
  }




/*void mainSwitchApp(){

	switch (Chip){
				case 1: // code to be executed if n = 1;
					printf("The IC inserted is
					break;
				case 2: // code to be executed if n = 2;
					break;
				default: // code to be executed if n doesn't match any cases
					printf("The chip is not listed");
					break;
		}

} */

void check(){


	clr(ot0);
	clr(ot1);
	clr(ot2);
	clr(ot3);
	clr(ot4);
	clr(ot5);
	clr(ot6);
	clr(ot7);
	if(GetBit(P2,0))
			if(GetBit(P2,1))
				if(GetBit(P2,2))
					if(GetBit(P2,3)){

					chip = 0; }

}


int main()
{
	if(!OpenCom(6, 115200))
	{
		exit(0);
	}
	   while(1)
	   {

			And();
		 //	Nand();        它不要打开 ~ مش عايزة تشتغل انا اتخنقت
			Or();
  			Nor();
			Xor();
			tsBuffer();
			//hexinv();



		   if(chip)
				printf("The ic inserted = %d \n",chips[chip] );
			else
				printf("Please Insert IC \n");

            Sleep(3000);
//		 if(!GetBit(P2,0))
//		   for(int i =0;i<5;i++)
//			{
//				clr(P1,0);
//				Sleep(1000);
//				setb(P1,0);
//				Sleep(1000);
//			}
	   }
	  return 0;
}





