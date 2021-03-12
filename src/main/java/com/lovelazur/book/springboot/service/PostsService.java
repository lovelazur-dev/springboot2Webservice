package com.lovelazur.book.springboot.service;

import com.lovelazur.book.springboot.domain.posts.Posts;
import com.lovelazur.book.springboot.domain.posts.PostsRepository;
import com.lovelazur.book.springboot.web.dto.PostsListResponseDto;
import com.lovelazur.book.springboot.web.dto.PostsResponseDto;
import com.lovelazur.book.springboot.web.dto.PostsSaveRequestDto;
import com.lovelazur.book.springboot.web.dto.PostsUpdateRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;


@RequiredArgsConstructor
@Service
public class PostsService {
    private final PostsRepository postsRepository;

    @Transactional
    public Long save(PostsSaveRequestDto requestDto) {

        //use repository save , argument entity
        return postsRepository.save(requestDto.toEntity()).getId();
    }

    @Transactional
    public void delete (Long id) {
        Posts posts = postsRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("해당 사용자가 없습니다. id=" + id));
        postsRepository.delete(posts);
    }

    @Transactional
    public Long update(Long id, PostsUpdateRequestDto requestDto) {
        Posts posts = postsRepository.findById(id)
                .orElseThrow(
                        () -> new IllegalArgumentException("해당 사용자가 없습니다. id=" + id)
                );
        //repository id key >> post domain update
        posts.update(requestDto.getTitle(), requestDto.getContent());
        return id;
    }

    @Transactional(readOnly = true)
    public PostsResponseDto findById(Long id) {
        Posts entity = postsRepository.findById(id)
                .orElseThrow(
                        () -> new IllegalArgumentException("해당 사용자가 없습니다. id=" + id)
                );
        System.out.println(new PostsResponseDto(entity));
        return new PostsResponseDto(entity);
    }

    @Transactional(readOnly = true)
    public List<PostsListResponseDto> findAllDesc() {
        return postsRepository.findAllDesc().stream()
                .map(PostsListResponseDto::new)
                .collect(Collectors.toList());
    }

}
