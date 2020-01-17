package hcl.com.mix_lib;

public interface Face {

    default void HelloWorld(){
        System.out.println("Default Hello World ");
    }
}
