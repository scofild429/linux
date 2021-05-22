import java.util.Random;

class RandomArray
{
    private int n;
    private int [] array;
    
    public RandomArray(int n)
    {
	this.n = n;
	this.array = new int [n];
    }

    public int [] Array()
    {
	for (int i = 0; i < n; i++)
	    array[i] = i;
    
	Random r = new Random();

	for (int i = 0; i < n; i++) {
	    int a = r.nextInt(n-i);
	    int tmp = array[n-i-1];
	    array[n-i-1]= array[a];
	    array[a] = tmp;
	}

	return array;
    }

}
