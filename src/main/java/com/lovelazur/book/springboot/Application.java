package com.lovelazur.book.springboot;
//test
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
public class Application {

    public static void main(String[] args)
    {
        SpringApplication.run(Application.class, args);
        //todo properties에 server none 등 되도록 코딩에정
        //tes
    }
}
