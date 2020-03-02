## 프로젝트 소개

원활한 의사소통과 구성원과 협업의 효율을 높이기 위한 그룹웨어 프로그램입니다.

## 주요기능
1. 출퇴근 관리 및 근무시간 카운팅 서비스
2. 회의실 예약 및 구성원 초대 서비스 ( 회의 불참 및 취소 신청 가능, 일정에 자동 등록 )
3. 전자 결재 서비스
  - ( 상신, 결재, 협의, 참조와 같은 기본적인 work - flow 와 동일히 구현)
4. 일정 생성 및 공유 서비스, ( 인사 관리자의 경우 전체 구성원 일정 등록 가능 )
5. 간단한 사내메일 서비스 ( 수신확인, 보관함, 검색기능 구현 )
6. 공지사항 게시판 (주요 공지 및 일반 공지 게시 기능)
7. To-do List, 할일 목록, 작업률(%)로 제공, 긴급도(긴급, 보통, 완만) 설정 가능
8. 조직도 및 구성원 검색 서비스
9. 인사 관리자의 구성원 등록, 계급조정, 부서이동 등 개인정보 수정 서비스

## 시연 GIF
### 회의실 예약
회의실 예약 서비스 입니다.
등록되어있는 회의실이 노출되며, 회의실별로 예약 가능한 시간대 별로 버튼이 예약 버튼이 활성화 됩니다.
(이미 지난 시간은 예약 되지 않습니다.)
본인은 예약자로, 참여자 2명 이상으로 예약 가능하게 구현하였으며, 최소 참여인원을 지킬 시 참여자는 언제든지 불참 신청이 가능합니다.
참여자로 지정되었을 경우 참여에 대하여 확실한 메세지가 갈 수 있도록 알람 서비스와 연계하였습니다. 
또한, 회의실 예약자 혹은 참여자로 지정되었을 경우 회의실 예약 현황과, 메인페이지의 캘런더 및 일정에 노출되어 회의 참여와 일정 확인에 용의하도록 구현하였습니다. 
![회의실예약1](https://user-images.githubusercontent.com/52588452/75668948-73d2f180-5cbd-11ea-8200-3ae192b5b6fb.gif)
![회의실예약2](https://user-images.githubusercontent.com/52588452/75668954-77ff0f00-5cbd-11ea-9a5e-9bcc692c332c.gif)


### 일정 생성, 공유 서비스
일정 관리 서비스 입니다.
개인 일정 등록은 물론, 구성원 간 일정 공유가 가능합니다. 공유받은 일정은 물론 의사에 따라 삭제가 가능하며, 공유받은 일정이 불필요하여 삭제하여도, 일정 원본 등록자는 이를 알 수 없습니다.
인사관리자의 경우 전체 구성원에게 노출되는 일정을 등록 할 수 있습니다.
**일정에는 구성원의 생일과, 입사기념일이 자동으로 노출됩니다.**
![ezgif-6-7188f484f07d](https://user-images.githubusercontent.com/52588452/75671379-ee9e0b80-5cc1-11ea-9493-51cfcb995bf8.gif)



### 전자 결재 서비스
전자 결재 서비스입니다.
상신, 결재, 참조, 합의 와 같은 기본적인 work-flow 에 맞추어 구현하였습니다.
접속자 기준으로 본인의 이름으로 올리거나, 받은 서류들이 각 카테고리에 맞추어 노출되며, 부여받은 권한에 맞는 결재(합의, 결재)를 할 수 있습니다.합의자, 참조자로 참조되어 있다면 해당 카테고리에 분류되어 보여지며, 어떠한 결재 버튼도 노출되지 않습니다.
결재 문서를 받았을 경우 이용자의 편의를 위하여 알람 서비스와 연계하였습니다.
실제 work-flow와 동일히 결재자 혹은 합의자가 합의거부, 또는 결재 거부를 한다면 상신이 중단됩니다. 모든 합의자, 결재자가 결재를 해준다면 결재 완료 텝으로 넘어갑니다.

![전재결재1](https://user-images.githubusercontent.com/52588452/75669340-3b7fe300-5cbe-11ea-8cbc-b47bc09eda48.gif)
![전자결재2](https://user-images.githubusercontent.com/52588452/75669343-3d49a680-5cbe-11ea-8290-ed61a034955d.gif)
![전자결재3](https://user-images.githubusercontent.com/52588452/75669349-3f136a00-5cbe-11ea-9bf1-dd014003e34b.gif)



### 출근관리 및 근무시간 관리 서비스
출근하기 버튼을 누르면, 우상단의 멈춰있던 근무시간 카운터가 돌아가며, 그룹웨어 전체페이지에서 노출됩니다.
또한 퇴근하기 버튼이 노출되는데, 이 버튼을 클릭했을 때, 법정 근로시간인 8시간을 채우지 않으면 조기퇴근이, 채웠다면 정상퇴근이 메세지가 노출됩니다.
![출근하기](https://user-images.githubusercontent.com/52588452/75668378-99133000-5cbc-11ea-9179-cbeacd72e279.gif)


### 사내 메일 서비스
에디터를 활용하여 가독성을 높이기 위한 데코레이팅이 가능하며, 사진 및 동영상업로드가 모두 가능합니다.
메일 수신 시 알람 서비스와 연계되어있습니다.
수신확인과 보관함 기능을 지원합니다.
![메일발송](https://user-images.githubusercontent.com/52588452/75670382-f957a100-5cbf-11ea-996f-a403fc230e1d.gif)
![메일답장](https://user-images.githubusercontent.com/52588452/75670375-f78ddd80-5cbf-11ea-8ab1-aa25fa004021.gif)

## 사용 STACK
- Bootstrap
- AJAX
- JQuery
- JSP
- JSTL
- JAVA
- Spring
- Mybatis
- Oracle DB
- Apache Maven
- Apache Tomcat

## 스키마 설계
[ERD 보러가기(ERD Cloud Link)](https://www.erdcloud.com/d/bHGwDJMBXx8qSuuNf)
![ERD img](https://user-images.githubusercontent.com/52588452/75664976-bba24a80-5cb6-11ea-80e3-017d520a20f9.png)


## Future Upgrade Plan
- 테이블의 복잡성을 줄이는 것에 중점을 두고 설계하였습니다. 하지만, 개발을 하며 DB구조로 인한 구현의 한계가 있어 리펙토링 시 구조 개편을 할 계획입니다.
- 전반적인 사용자 UI, UX 개선
- 서비스 디테일 추가

### Dev
최윤정
melangyun@gmail.com
