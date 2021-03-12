package com.lovelazur.book.springboot.web.dto;
import org.junit.Test;

import static org.assertj.core.api.Assertions.assertThat;
//assertj의 assertThat 사용. 좀 더 유리

public class HelloResponseDtoTest {
    @Test
    public void 롬복_기능테스트(){
        String name = "test";
        int amount =1000;
        //when
        HelloResponseDto dto = new HelloResponseDto(name, amount);

        //then
        assertThat(dto.getName()).isEqualTo(name);
        assertThat(dto.getAmount()).isEqualTo(amount);
    }
}
