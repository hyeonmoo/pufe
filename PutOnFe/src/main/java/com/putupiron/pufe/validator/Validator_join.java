package com.putupiron.pufe.validator;

import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.putupiron.pufe.dto.JoinData;

public class Validator_join implements Validator {
	@Override
	public boolean supports(Class<?> clazz) {
		return JoinData.class.isAssignableFrom(clazz); 
	}
	@Override
	public void validate(Object target, Errors errors) {
		JoinData jd = (JoinData)target;
		//비밀번호 정규식(문자, 숫자를 포함한 8자 이상)
		String regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$";
		if(!Pattern.matches(regex, jd.getUser_pw())) //비밀번호가 정규식을 만족하지 못할 경우
			errors.rejectValue("user_pw", "비밀번호는 문자,숫자 포함 8자 이상이어야 합니다.");
		if(!jd.getUser_pw().equals(jd.getPw_confirm())) //비밀번호와 확인란의 문자가 불일치
			errors.rejectValue("user_pw","비밀번호가 일치하지 않습니다.");
		if(jd.getTerms_user()==null) //약관 미동의 시
			errors.rejectValue("terms_user","모든 약관에 동의하셔야 합니다.");
		if(jd.getTerms_club()==null)
			errors.rejectValue("terms_club", "모든 약관에 동의하셔야 합니다.");
	}
}
