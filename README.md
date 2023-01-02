# 헬스클럽 통합 이용 웹페이지 '철좀들어'
### 헬스클럽의 각 구성원(관리자, 트레이너, 일반 이용자)의 입장에서 헬스클럽 이용에 필요한 기능들로 구성된 웹페이지

## 사용 기술
> ### Spring framework
> ### Mybatis
> ### MySQL

## 주요 기능
  ## 전체
    Big Three Rank
    -관리자, 트레이너에 의해 헬스클럽에서 측정한 3대 중량 기록이 기록되고, 랭크됨

    Health Mate 매칭
    -헬스메이트와 같이 운동하고싶은 날짜, 시간, 운동 부위를 선택 후 매칭 or 등록
    -매칭 시 자신의 3대 중량기록보다 높은 등록자 중 자신과 가장 비슷한 기록의 등록자가 매칭됨

    헬스 추천 정보
    -관리자, 트레이너가 헬스클럽을 이용하는데 유용한 정보들을 포스트

    헬스클럽 기구 정보
    -헬스클럽에 비치된 기구의 정보를 열람

  ## 일반 이용자
    기간권 상품구매
    -단순 기간권과 PT결합 상품을 구분하여 출력, 원하는 상품 선택 후 구매버튼 클릭 시 결제

    Personal Training 예약
    -예약을 원하는 날짜와 시간을 선택해 PT 예약 신청
    -예약 신청, 예약 완료, 진행된 PT 시간 확인 가능
