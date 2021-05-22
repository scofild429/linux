class radix_sort
{
    public static void main(String[] args)
    {
	int n = Integer.parseInt(args[0]);
	RandomArray array = new RandomArray(n);
	int [] list = array.Array();

	radix(list, n);

	for (int i = 0; i < n; i++) {
	    System.out.printf("%d ", list[i]);
	}

	System.out.println();

	
    }


    public static void radix(int [] array, int n){
	for (int grap = n/2; grap > 0; grap = grap/2) {
	    for (int i = grap; i < n; i++) {
		int j = i;
		int temp = array[j];
		if (array[j] < array[j-grap]) {
		    while (j- grap >= 0 && temp < array[j-grap]) {
			array[j] = array[j-grap];
			j = j - grap;
		    }
		}
		array[j] = temp;
	    }
	}
    }




    
}
