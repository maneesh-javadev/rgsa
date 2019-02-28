package gov.in.rgsa.controller;

import java.util.Scanner;

public class PaltinumExchange {
	public static int MIN_VALUE=1;
	public static int MAX_VALUE=1000000000;

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner in = new Scanner(System.in);
		System.out.println("Please type the value of block...");
		Integer blockCount = in.nextInt();
		if(blockCount<=MIN_VALUE){
			System.out.println("Please Enter Minimum Value is 2 grams");
		}
		if(blockCount>MAX_VALUE){
			System.out.println("Value should be less than or equal to 1000000000 grams");
		}
		PaltinumExchange paltinumExchange = new PaltinumExchange();
		int foundUnit=paltinumExchange.findUnitOfCurrency(blockCount);
		
		if(foundUnit>blockCount){
			System.out.println("BLOCK MAX VALUE " + foundUnit);
		}
		else{
			System.out.println("BLOCK MAX VALUE " + blockCount);
		}
	}
	
	private int findUnitOfCurrency(int block){
		
		int m1=block/2;
		int m2=block/3;
		int m3=block/4;
		return (m1+m2+m3);
		
	}

}
