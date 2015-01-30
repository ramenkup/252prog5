
public class skipper {

	int[] array= new int[10]; //$a0
	int starting;//$a1
	int count=0;
	
	
	public skipper(int start){
		starting=start;
	}
	
	

	public int[] skip(int starting){
		int[] temp= new int[array.length];
		int fourcounter= starting;
		int onecounter=0;
		while(fourcounter < array.length){
			temp[onecounter]= array[fourcounter];
			fourcounter=+4;
			onecounter+=1;
			count++;
		
		}
		return temp;
	}
	
	public void printArray(){
		int i=0;
		int[] temp= this.skip(starting);
		System.out.print(count);
		while(i < temp.length && temp[i]!=0){
			System.out.println(temp[i]);
			i++;
		}
	}
}
