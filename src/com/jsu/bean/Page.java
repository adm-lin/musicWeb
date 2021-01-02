package com.jsu.bean;

import java.util.List;

public class Page<T> {
    private Integer currentPage;
    private Integer pageSize;
    private Integer beforePage;
    private Integer afterPage;
    private Integer totalRows;
    private Integer totalPages;

    private List<T> list;

    public Page() {
    }
    public Page(List<T> list){
        this.list=list;
    }

    public Page(Integer currentPage, Integer pageSize, Integer beforePage, Integer afterPage, Integer totalRows, Integer totalPages, List<T> list) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.beforePage = beforePage;
        this.afterPage = afterPage;
        this.totalRows = totalRows;
        this.totalPages = totalPages;
        this.list = list;
    }

    public Page(Integer currentPage, Integer pageSize, Integer totalRows, List<T> list) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.totalRows = totalRows;
        this.list = list;
        //一共有多少页totalPages
        this.totalPages= this.totalRows%this.pageSize==0?this.totalRows/this.pageSize:this.totalRows/this.pageSize+1;
        //上一页
        this.beforePage=this.currentPage-1<=0?1:this.currentPage-1;
        //下一页
        this.afterPage=this.currentPage+1>=this.totalPages?this.totalPages:this.currentPage+1;


    }

    public Integer getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getBeforePage() {
        return beforePage;
    }

    public void setBeforePage(Integer beforePage) {
        this.beforePage = beforePage;
    }

    public Integer getAfterPage() {
        return afterPage;
    }

    public void setAfterPage(Integer afterPage) {
        this.afterPage = afterPage;
    }

    public Integer getTotalRows() {
        return totalRows;
    }

    public void setTotalRows(Integer totalRows) {
        this.totalRows = totalRows;
    }

    public Integer getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    @Override
    public String toString() {
        return "PageBean{" +
                "currentPage=" + currentPage +
                ", pageSize=" + pageSize +
                ", beforePage=" + beforePage +
                ", afterPage=" + afterPage +
                ", totalRows=" + totalRows +
                ", totalPages=" + totalPages +
                ", list=" + list +
                '}';
    }

}
