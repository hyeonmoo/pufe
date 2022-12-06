package com.putupiron.pufe.vo;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import lombok.Data;

@Data
public class MatchCondition {
	private	String		part;
	private	String		dateOption;
	private	String		timeOption;
	
	private	LocalDate	startDate;
	private LocalDate	endDate;
	private LocalTime	startTime;
	private	LocalTime	endTime;
	
	private static final int WHOLE_PERIOD=15;
	
	public void setDatePeriod(String dateOption) {
		String datePattern = "^\\d{4}-\\d{2}-\\d{2}$"; //yyyy-MM-dd 정규식
		if(Pattern.matches(datePattern, dateOption)) { //정규식을 만족하면 -> 구체적인 날짜를 선택했다면
			String[] strArr = dateOption.split("-"); //쪼개서
			List<Integer> dateList = new ArrayList<>();
			for(String str:strArr) dateList.add(Integer.parseInt(str)); //정수로 바꿔 리스트에 저장
			this.startDate = LocalDate.of(dateList.get(0),dateList.get(1),dateList.get(2));
			this.endDate = this.startDate.plusDays(1); // 시작 날짜와 끝 날짜 설정
		} else { //정규식을 만족하지 못하면 -> 기간을 선택했다면
			LocalDate now = LocalDate.now(); //현재날짜를 가리키는 LocalDate객체 생성
			switch(dateOption) { //설정 값좀 보자
			case "all": //전체
				this.startDate = now; //지금부터
				this.endDate = now.plusDays(WHOLE_PERIOD); // 2주 뒤, 즉 모두
				break;
			case "tomorrow": //내일까지
				this.startDate = now; //오늘부터
				this.endDate = now.plusDays(2); //미만이므로 2를 더해야 내일도 포함됨
				break;
			case "weekend": //주말동안
				LocalDate weekend = now; // 현재날짜를 가리키는 객체 하나 더 생성
				while(weekend.getDayOfWeek()!=DayOfWeek.SATURDAY)
					weekend=weekend.plusDays(1); //토요일이 될 때까지 다음날로 넘김
				this.startDate = weekend; //토요일이 된 weekend를 저장
				this.endDate = weekend.plusDays(2); //일요일 저장
				break;
			case "recent7": //최근 일주일
				this.startDate = now;
				this.endDate = now.plusDays(7);
				break;
			}
		}
	}
	public void setTimePeriod(String timeOption) {
		String timePattern = "^\\d{2}:\\d{2}~\\d{2}:\\d{2}$";
		String timePattern_solo = "^\\d{2}:\\d{2}$";
		if(Pattern.matches(timePattern, timeOption)) {
			String[] strArr = timeOption.split("~");
			List<Integer> timeList = new ArrayList<>();
			String[] time = strArr[0].split(":");
			for(String t:time) timeList.add(Integer.parseInt(t));
			time = strArr[1].split(":");
			for(String t:time) timeList.add(Integer.parseInt(t));
			this.startTime = LocalTime.of(timeList.get(0), timeList.get(1));
			this.endTime = LocalTime.of(timeList.get(2), timeList.get(3));
		} else if(Pattern.matches(timePattern_solo, timeOption)) {
			String[] time = timeOption.split(":");
			List<Integer> timeList = new ArrayList<>();
			for(String t:time) timeList.add(Integer.parseInt(t));
			this.startTime = LocalTime.of(timeList.get(0), timeList.get(1));
			this.endTime = LocalTime.of(timeList.get(0), timeList.get(1));
		} else {
			switch(timeOption) {
			case "all":
				this.startTime = LocalTime.of(6, 0);
				this.endTime = LocalTime.of(22, 0);
				break;
			case "morning":
				this.startTime = LocalTime.of(6, 0);
				this.endTime = LocalTime.of(11, 30);
				break;
			case "afternoon":
				this.startTime = LocalTime.of(12, 0);
				this.endTime = LocalTime.of(17, 30);
				break;
			case "evening":
				this.startTime = LocalTime.of(18, 0);
				this.endTime = LocalTime.of(22, 0);
				break;
			}
		}
	}
}