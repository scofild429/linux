import java.util.*;
public class Quicksort {

    public static void main(String[] args) {
	int n = Integer.parseInt(args[0]);
	RandomArray array = new RandomArray(n);
	int [] arr = array.Array();

	qSort(arr, 0, arr.length - 1);

	for (int i = 0; i < n; i++) {
	    System.out.printf("%d ", arr[i]);
	}

	System.out.println();

    }

    
    public static void qSort(int[] arr, int head, int tail) {
        if (head >= tail || arr == null || arr.length <= 1) {
            return;
        }
        int i = head, j = tail, pivot = arr[(head + tail) / 2];
        while (i <= j) {
            while (arr[i] < pivot) {
                ++i;
            }
            while (arr[j] > pivot) {
                --j;
            }
            if (i < j) {
                int t = arr[i];
                arr[i] = arr[j];
                arr[j] = t;
                ++i;
                --j;
            } else if (i == j) {
	    	++i; //  For the case that arr[i]= arr[j] = pivot
	    }
        }
        qSort(arr, head, j);
        qSort(arr, i, tail);
    }
}
