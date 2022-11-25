package com.putupiron.pufe.vo;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SearchCondition {
	private Integer page=1;
	private Integer pageSize=15; 
	private String keyword="";
	private String option;
	
	public Integer getOffset() {return (page-1)*pageSize;}
	
	public String getQueryString(Integer page) {
		return UriComponentsBuilder.newInstance()
				.queryParam("page",page)
				.queryParam("pageSize", pageSize)
				.queryParam("option",option)
				.queryParam("keyword", keyword)
				.build().toString();
	}
	public String getQueryString() {
		return getQueryString(page);
	}
}
