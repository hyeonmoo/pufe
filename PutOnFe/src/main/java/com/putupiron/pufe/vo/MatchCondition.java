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
		String datePattern = "^\\d{4}-\\d{2}-\\d{2}$";
		if(Pattern.matches(datePattern, dateOption)) {
			String[] strArr = dateOption.split("-");
			List<Integer> dateList = new ArrayList<>();
			for(String str:strArr) dateList.add(Integer.parseInt(str));
			this.startDate = LocalDate.of(dateList.get(0),dateList.get(1),dateList.get(2));
			this.endDate = this.startDate.plusDays(1);
		} else {
			LocalDate now = LocalDate.now();
			switch(dateOption) {
			case "all":
				this.startDate = now;
				this.endDate = now.plusDays(WHOLE_PERIOD);
				break;
			case "tomorrow":
				this.startDate = now;
				this.endDate = now.plusDays(2);
				break;
			case "weekend":
				LocalDate weekend = now;
				while(weekend.getDayOfWeek()!=DayOfWeek.SATURDAY)
					weekend=weekend.plusDays(1);
				this.startDate = weekend;
				this.endDate = weekend.plusDays(2);
				break;
			case "recent7":
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