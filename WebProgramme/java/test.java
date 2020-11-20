class test
{
    public static void main(String[] args) throws Exception
    {
		
	Class cls1 = String.class;
	System.out.println(cls1.hashCode());
	
	String s = "Hello";
	Class cls2 = s.getClass();
	System.out.println(cls2.hashCode());


	Class cls3 = Class.forName("java.lang.String");
	System.out.println(cls3.hashCode());

	
    }
}
