package com.spring.sunyeop2.core.util;


import lombok.*;

@ToString
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Paging {
    private int totalRecordCount;   // 전체 데이터 수
    private int totalPageCount;     // 전체 페이지 수
    private int startPage;          // 첫 페이지 번호
    private int endPage;            // 끝 페이지 번호
    private int startIndex;         // LIMIT 시작 위치 ( limitStart )
    private boolean existPrevPage;  // 이전 페이지 존재 여부
    private boolean existNextPage;  // 다음 페이지 존재 여부

    private int page;               // 현재 페이지 번호
    private int recordSize;         	// 페이지당 출력할 데이터 개수 ( recordSize )
    private int pageSize;           // 화면 하단에 출력할 페이지 사이즈

    public Paging(int totalRecordCount, int page, int recordSize, int pageSize) {

        this.page = page;
        this.recordSize = recordSize;
        this.pageSize = pageSize;
        this.totalRecordCount = totalRecordCount;
        this.calculation(page, recordSize, pageSize);


    }


    private void calculation(int page, int recordSize, int pageSize) {

        // 전체 페이지 수 계산
        totalPageCount = ((totalRecordCount - 1) / recordSize) + 1;

        // 현재 페이지 번호가 전체 페이지 수보다 큰 경우, 현재 페이지 번호에 전체 페이지 수 저장
        if (page > totalPageCount) {
            page = totalPageCount;
        }

        // 첫 페이지 번호 계산
        startPage = ((page - 1) / pageSize) * pageSize + 1;

        // 끝 페이지 번호 계산
        endPage = startPage + pageSize - 1;

        // 끝 페이지가 전체 페이지 수보다 큰 경우, 끝 페이지 전체 페이지 수 저장
        if (endPage > totalPageCount) {
            endPage = totalPageCount;
        }

        // LIMIT 시작 위치 계산
        startIndex = (page - 1) * recordSize;

        // 이전 페이지 존재 여부 확인
        existPrevPage = startPage != 1;

        // 다음 페이지 존재 여부 확인
        existNextPage = totalRecordCount / ((startPage+pageSize-1) * recordSize) > 0 ;
    }

}
