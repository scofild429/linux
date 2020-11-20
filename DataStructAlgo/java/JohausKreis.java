// javac Josehus.java && java Josehus 10 8
//there are two difference methode, one is with count methode and one is recursive

import java.util.ArrayList;
import java.util.List;
import java.util.*;

class JohausKreis
{
    static int run = 0;     // to count weiter, again and agina
    static int dis = 0;    //how many time are the list thougth counted
    static int count = 1;   // how many element are finish

    public static void main(String[] args)
    {
	if (args.length != 2 ) {
	    System.out.println("please only give two agreements");
	    return ;
	}
	int length = Integer.parseInt(args[0]);
	int step = Integer.parseInt(args[1]);
	List jose1 = josePermutation(length, step);
	for (int i = 0; i < jose1.size(); i++) {
	    System.out.printf("%d ",jose1.get(i));
	}
    }
    static List josePermutation(int length, int step)
    {
    	int [] circle = new int [length];
    	for (int i = 0; i < length; i++) {
    	    circle[i] = i+1;
    	}
    	List<Integer> Folge = new ArrayList<Integer>();
    	do {
    	    if(circle[run%length] != 0)
    		{
    		    if ((run+1-dis)%step == 0) {
    			Folge.add(circle[run%length]);
    			count++;
    			circle[run%length] = 0;
    		    }
    		    run++;
    		    continue;
    		}
    	    run++;
    	    dis++;
    	} while (count <= length);
    	return Folge;
    }
}

