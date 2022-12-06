package com.putupiron.pufe;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.putupiron.pufe.dao.GoodsDao;
import com.putupiron.pufe.dao.HealthMateDao;
import com.putupiron.pufe.dao.MachineDao;
import com.putupiron.pufe.dao.PTDao;
import com.putupiron.pufe.dao.RecommendDao;
import com.putupiron.pufe.dao.UserDao;
import com.putupiron.pufe.dto.BigThree;
import com.putupiron.pufe.dto.Goods;
import com.putupiron.pufe.dto.HealthMate_Post;
import com.putupiron.pufe.dto.Machine;
import com.putupiron.pufe.dto.PTReserv;
import com.putupiron.pufe.dto.Recommend;
import com.putupiron.pufe.dto.User;
import com.putupiron.pufe.dto.UserView;
import com.putupiron.pufe.vo.MatchCondition;
import com.putupiron.pufe.vo.MyMatch;
import com.putupiron.pufe.vo.PageHandler;
import com.putupiron.pufe.vo.SearchCondition;

@Controller
public class Ctrl_Home {
	@Autowired UserDao userDao;
	@Autowired MachineDao machineDao;
	@Autowired RecommendDao recDao;
	@Autowired PTDao ptDao;
	@Autowired GoodsDao goodsDao;
	@Autowired HealthMateDao hMateDao;

//	홈 화면
	@GetMapping("/")
	public String home(SearchCondition sc, HttpSession session, Model m) throws Exception {
		//홈 화면이 로드 될 때마다 불필요한 데이터 삭제
		userDao.deleteExpiredGoods(); // 기한만료 상품 유저데이터에서 삭제
		ptDao.decBookableNum(); // 예약확정 후 예약날짜 경과 시 PT예약가능횟수 차감
		ptDao.deleteExpiredRequest(); // 요청 상태로 경과된 PT예약 삭제
		hMateDao.deleteExpiredMatching(); // 날짜 지난 매칭 삭제

		List<Machine> machineList = machineDao.selectAllMachines(); // 클럽 기구정보 로드(이미지 슬라이드)
		List<Recommend> recommendList = recDao.indexrec(); // 추천 헬스정보 로드
		recommendList.removeIf(rec->(recommendList.indexOf(rec)>5)); // 추천 정보 중 최신 6개의 게시물만 남겨놓고 삭제
		m.addAttribute("machineList", machineList);
		m.addAttribute("recommendList", recommendList);//세션정보로 로그인 한 유저 특정
		
		String user_email = (String) session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		if(user == null) return "index";
		
		// 유저 타입에 따라 회원정보란에 노출될 정보 차별화
		switch (user.getUser_type()) {
		case "A": // 관리자
			m.addAttribute("stats", userDao.statistics()); // 회원 통계정보 로드
			break;
		case "T": // 트레이너
			List<UserView> myClientList = userDao.allUserView(); // 모든 유저 정보 로드
			myClientList.removeIf(client->client.getTrainer()==null||!client.getTrainer().equals(user_email)); // DAO로 받아온 모든 유저 중 로그인 한 트레이너 전담이 아닌 다른 유저들은 리스트에서 삭제
			List<PTReserv> todayPTs = ptDao.reservList(user_email, user.getUser_type()); // 로그인 한 트레이너의 모든 PT예약정보 로드
			todayPTs.removeIf(pt->!pt.getPt_date().equals((LocalDate.now()))); // 오늘 예약된 PT예약정보만 빼고 리스트에서 삭제
			String todayString = new ObjectMapper().writeValueAsString(todayPTs); // 모델에 담길 객체타입 리스트를 자바스크립트에서 사용하기 위해 JSON직렬화
			
			m.addAttribute("clientNum",myClientList.size());
			m.addAttribute("today",new Date());
			m.addAttribute("todayString",todayString);
			break;
		case "U": // 일반회원
			List<MyMatch> myMatches = hMateDao.confirmedPostOfUser(user_email); // 로그인 한 유저의 확정된 헬스메이트 매칭정보 로드(시간순으로 로드됨)
			MyMatch myMatch = null; // 모델에 담기 위해 if문 밖에 선언
			myMatches.removeIf(each->(LocalDateTime.of(each.getDate(), each.getTime()).isBefore(LocalDateTime.now()))); // 현재시각 이전의 매칭데이터는 삭제 -> 현재시각 이후 가장 최근의 매칭정보가 리스트 맨 앞에 위치하게 됨
			if(myMatches.size()!=0) { // 매칭정보가 존재한다면
				myMatch = myMatches.get(0); //맨 앞놈, 즉 가장 최근의 매칭정보를 모델에 담을 객체에 저장
				myMatch.setName(myMatch.getPoster_name().equals(user.getUser_name())?myMatch.getPartner_name():myMatch.getPoster_name()); // 파트너 이름 저장(로그인유저가 포스팅을 했다면 파트너, 요청을 했다면 포스터)
			}
			m.addAttribute("myMatch",myMatch);
			m.addAttribute("userview", userDao.homeUserView(user_email));
			break;
		}
		Integer user_rank = userDao.userBig3Rank(user_email); // 해당 유저의 3대중량 랭크정보 로드
		
		m.addAttribute("user", user);
		m.addAttribute("rank", user_rank);
		return "index";
	}

//	네비게이션 바에 세션의 유저 정보 전송
	public User navBar(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		String user_email = (String) session.getAttribute("email");
		User user = userDao.selectUser(user_email);
		m.addAttribute("user", user);
		m.addAttribute("from",hsReq.getServletPath()); //로그인 버튼이 아닌 다른 버튼을 누르고 로그인창에 진입했을 때 로그인 성공시 그 버튼으로 이동했어야 할 페이지의 ServletPath를 모델에 저장
		return user;
	}

//	메뉴버튼1
	@GetMapping("/menu1")
	public String menu1(String viewType, HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		User user = navBar(session, m, hsReq);
		if (user == null) //로그인 했어요?
			return "login"; //안했음 가세요~
		switch (user.getUser_type()) {
		case "U": //일반회원->상품구매 창으로 이동
			List<Goods> goodsList = goodsDao.allGoods("noPT"); //모든 상품정보 로드(초기화면을 기간권으로 설정하기 위해 옵션은 noPT)
			for(Goods goods:goodsList) goods.setEnd_date(LocalDate.now().plusDays(goods.getPeriod()*30)); // 현재날짜 기준 각 상품 구매시 만료일자를 저장
			m.addAttribute("goodsList", goodsList);
			return "menu_user1";
		case "T": //트레이너->자신이 전담하는 회원들 정보조회 페이지로 이동
			m.addAttribute("tulist", userDao.TrainerUserView(user.getUser_email()));
			return "menu_trainer1";
		case "A": //관리자->회원관리 페이지로 이동
			if (viewType == null) viewType = "user"; //초기화면을 일반회원으로 설정
			m.addAttribute("stats", userDao.statistics()); //회원 통계정보 저장
			m.addAttribute("userlist", userDao.allUserView()); //일반회원정보
			m.addAttribute("trainerlist", userDao.allTrainerView());//트레이너정보
			m.addAttribute("adminlist", userDao.allAdminView());//관리자정보
			m.addAttribute("viewType", viewType); //보여줄 화면 설정
			return "menu_admin1";
		default: //어느 누구도 아닐리는 없긴함
			return "redirect:/login";
		}
	}

//	메뉴버튼2
	@GetMapping("/menu2")
	public String menu2(SearchCondition sc, HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		User user = navBar(session, m, hsReq);
		if (user == null) return "login";
		switch (user.getUser_type()) {
		case "U": return "menu_user2";
		case "T": return "menu_trainer2";
		case "A":
			int totalCnt = machineDao.searchCnt(sc);
			PageHandler ph = new PageHandler(totalCnt, sc);
			List<Machine> machinelist = machineDao.search(sc);
			m.addAttribute("machinelist", machinelist);
			m.addAttribute("ph", ph);
			return "machineList";
		default:
			return "redirect:/login";
		}
	}

//	추천운동정보
	@GetMapping("/recommend")
	public String recommend(SearchCondition sc, HttpSession session, Model m, HttpServletRequest hsReq)
			throws Exception {
		navBar(session, m, hsReq);
		int totalCnt = recDao.searchCnt(sc);
		PageHandler ph = new PageHandler(totalCnt, sc);
		List<Recommend> list = recDao.search(sc);
		m.addAttribute("now", new java.util.Date());
		m.addAttribute("list", list);
		m.addAttribute("ph", ph);
		return "boarder_recommend";
	}

//	클럽 시설 정보
	@GetMapping("/machines")
	public String machines(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		navBar(session, m, hsReq);
		List<Machine> machineList = machineDao.selectAllMachines();
		m.addAttribute("machineList", machineList);
		return "machineView";
	}

//	Big3 랭킹
	@GetMapping("/bigThree")
	public String big3Rank(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		User user = navBar(session, m, hsReq);
		if (user == null)
			return "redirect:/login";
		List<BigThree> list = userDao.bigThreeRank();
		m.addAttribute("list", list);
		return "bigThree";
	}

//	헬스메이트 매칭-더보기
	@GetMapping("/healthmate")
	public String healthmate(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		User user = navBar(session, m, hsReq);
		if (user == null)
			return "redirect:/login";
		m.addAttribute("myPosts",hMateDao.myPosts(user.getUser_email()));
		m.addAttribute("myRequests",hMateDao.myRequests(user.getUser_email()));
		m.addAttribute("postList",hMateDao.postList());
		return "boarder_matching";
	}
//	헬스메이트 매칭-매칭버튼
	@PostMapping("/matching")
	public String matching(MatchCondition mc,HttpSession session, Model m, HttpServletRequest hsReq) throws Exception{
		User user = navBar(session,m,hsReq);
		mc.setDatePeriod(mc.getDateOption());
		mc.setTimePeriod(mc.getTimeOption());
		int userBig3=user.getSquat()+user.getBenchpress()+user.getDeadlift();
		List<HealthMate_Post> hmpList = hMateDao.postList(mc);
		HealthMate_Post recommendedPost=null;
		if(hmpList.size()!=0) {
			hmpList.removeIf(hmp->hmp.getPoster().equals(user.getUser_email())); //ArrayList 안의 해당 람다식조건을 만족하는 요소 제거
			for(HealthMate_Post hmp:hmpList) hmp.setPoster_big3(hmp.getPoster_big3()-userBig3);
			boolean hasPositive=false;
			for(HealthMate_Post hmp:hmpList) if(hmp.getPoster_big3()>=0) hasPositive=true;
			if(hasPositive) {
				hmpList.removeIf(hmp->hmp.getPoster_big3()<0);
				recommendedPost=hmpList.get(hmpList.size()-1);
			} else recommendedPost=hmpList.get(0);
			recommendedPost.setPoster_big3(recommendedPost.getPoster_big3()+userBig3);
		}
		m.addAttribute("mc",mc);
		m.addAttribute("recommend",recommendedPost);
		return healthmate(session,m,hsReq);
	}
//	오시는 길
	@GetMapping("/road")
	public String road(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		navBar(session, m, hsReq);
		return "road";
	}

//	마이페이지
	@GetMapping("/myPage")
	public String myPage(HttpSession session, Model m, HttpServletRequest hsReq) throws Exception {
		User user = navBar(session, m, hsReq);
		if (user == null)
			return "redirect:/login";
		m.addAttribute("menu", "info");
		m.addAttribute("page", "show");
		return "myPage";
	}
}
