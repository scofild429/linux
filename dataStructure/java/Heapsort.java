class Heapsort
{
    public static void main(String[] args)
    {
	int n = Integer.parseInt(args[0]);
	RandomArray array = new RandomArray(n);

	int [] list = array.Array();

	heapsort(list, n);
	
	for (int i = 0; i < n; i++) {
	    System.out.printf("%d ", list[i]);
	}
	System.out.println();
    }


    
    public static void heapsort(int [] a, int n){
	int beginIndex = (n >> 1)-1;
	for (int i = beginIndex; i >= 0; i--) {
	    Maxheap(a, i, n-1);
	}
	for (int i = n-1; i > 0; i--) {
	    swap(a, 0, i);
	    Maxheap(a, 0, i-1);
	}

    }

    public static void Maxheap(int [] a, int index, int n){
	int l = (index << 1) +1;
	int r = l + 1;
	int max = l;
	if (l > n) {
	    return;
	}

	if (r <= n && a[l] < a[r] ) {
	    max = r;
	}

	if (a[index] < a[max]) {
	    swap(a, index, max);
	    Maxheap(a, max, n);
	}
    }

    public static void swap(int [] a, int m, int n){
	int temp = a[m];
	a[m]=a[n];
	a[n]=temp;
    }
    
}
