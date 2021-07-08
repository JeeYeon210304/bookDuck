<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="css/login.css" rel="stylesheet">
</head>
<script type="text/javascript">

	$(function(){
		$("#loginChk").hide();
	});
	
	function login(){
		var member_id = $("#member_id").val().trim();
		var member_pw = $("#member_pw").val().trim();
		var loginVal = {
				"member_id": member_id,
				"member_pw": member_pw
		}
		
		if(member_id == null || member_id == "" || member_pw == null || member_pw == "" ){
			alert("ID 및 PW를 입력해 주세요");
		}else{
			$.ajax({
				type:"post",
				url:"login.do",
				data:JSON.stringify(loginVal),
				contentType:"application/json",
				dataType:"json",
				success: function(msg){
					if(msg.check == true){
						location.href='index.jsp';
					}else{
						$("#loginChk").show();
						$("#loginChk").html("ID 혹은 PW가 잘못되었습니다.")
					}
				},
				error:function(){
					alert("통신 실패");
				}
			});
		}
	}
</script>
	
<script type="text/javascript">
	function JoinForm(){
		$(".join").click(function(){
			$(".join").attr("action", "/member/joinform");
			$(".join").submit();
		});
	});
	
	function FindIdForm(){
		$(".find_id").click(function(){
			$(".find_id").attr("action", "/member/findIdForm");
			$(".find_id").submit();
		});
	});
	
	function FindPwForm(){
		$(".find_pw").click(function(){
			$(".find_pw").attr("action", "/member/findPwForm");
			$(".find_pw").submit();
		});
	});
</script>

<!-- bootstrap 4 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
  
<jsp:include page="../header.jsp"/>

<body>
<div class="login-form">
	<div class="general-login">
	<table id="login-form">
			<tr>
				<th>ID</th>
			<td><input type="text" id="member_id"/></td>
			</tr>
			<tr>
				<th>PW</th>
				<td><input type="password" id="member_pw"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="login" id="login" onclick="login();"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center" id="loginChk"></td>
			</tr>
			<tr>
			<td>
			<input type="button" value="회원가입" id="join" onclick="location.href='joinform.do'"/></td>
			<td>
			<input type="button" value="아이디 찾기" id="find_id" onclick="location.href='findIdForm.do'"/></td>
			<td>
			<input type="button" value="비밀번호 찾기" id="find_pw" onclick="location.href='findPwForm.do'"/></td>
			</tr>
	</table>
	</div>

<div class="sns-login-area">
<!-- 네이버 로그인 -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- 카카오로그인 또한 별다를 거없이 카카오(https://developers.kakao.com/)
개발자센터에서 앱을 만들고 키값을 받은후에 주어진 설명따라 진행하겠습니다. 아래의 스크립트를 복사해서 상위에 붙여넣고 아래 스크립트에서 설명하겠습니다. -->
<!-- kakaoLogin -->
<script type="text/javascript"src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- 구글 로그인같은경우는 동일한방식으로 진행이되지만 사이트 자체에서 영어로 되어있는부분이 어려움이 있을수있습니다.
(https://developers.google.com/identity/sign-in/web/sign-in#before_you_begin) 
사이트에서 진행방법에따라 진행하면되는데 네이버 카카오 전부 동일하게 애플리케이션을 만들고 키값을 받게되면 아래의 스크립트로 이동하겠습니다.
 -->
<!-- googleLogin -->
<script src="https://apis.google.com/js/client:platform.js?onload=init" async defer></script>

<script>
    function onSubmit(e){
        console.log("rere")
        e.preventDefault();
    }
</script>
</div> <!-- sns-login-area 끝 -->
</div>
</head>

<body>

	<!-- 네이버아이디로로그인 버튼 노출 영역 -->
  <div id="naver_id_login"></div>
  <!-- //네이버아이디로로그인 버튼 노출 영역 -->
  <script type="text/javascript">
      var naver_id_login = new naver_id_login("Hft3mSmHcCpHqnsB7j3E", "http://localhost:8787/bookduck/naverlogin.do");
      var state = naver_id_login.getUniqState();
      naver_id_login.setButton("white", 2,40);
      naver_id_login.setDomain("http://localhost:8787");
      naver_id_login.setState(state);
      naver_id_login.setPopup();
      naver_id_login.init_naver_id_login();
  </script>
  
  <!-- 구글 아이콘 -->
  <a><img src="https://www.drupal.org/files/styles/grid-3-2x/public/project-images/Google-login.png?itok=mHMjUmpH" style="width:40px; " id="glogin"></a>
  <!-- 카카오 아이콘 -->
  <a><img src="https://mblogthumb-phinf.pstatic.net/MjAxODAyMDJfMzQg/MDAxNTE3NTAyODA4ODA1.aYtwH9e-REqhMJ-y4FntHDf9cG--EQq76kK3k27DQd8g.Bv8IKu7PShK6fJCmgifry9yIFuBBJpQ1utdqGXUrT7kg.PNG.marketstory24/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1_%EB%A1%9C%EA%B3%A0_1.png?type=w800" style="width:40px; "  id="kakao-login-btn"></a>
  <!-- googleLogin -->
         <!-- 이곳에서 동일하게 키값을 통해서 전달받은 정보를 onsingup함수 를통해 location.href로 로그인컨트롤러에 보내주게됩니다.-->
    <script>
         function init() {
                gapi.load('auth2', function() {
                    auth2 = gapi.auth2.init({
                        client_id: '409001703950-2aoh9f52ta7827mps5porjeknt3104mk.apps.googleusercontent.com',
                        cookiepolicy: 'single_host_origin',
                        scope: 'profile email'
                    });
                    element = document.getElementById('glogin');
                    auth2.attachClickHandler(element, {}, onSignUp, onFailure);
                });
            }
            function onSignUp(googleUser) {
              var profile = googleUser.getBasicProfile();
              const member_email = profile.getEmail();
              const member_id = profile.getId();
              location.href = 'googlelogin.do?member_email='+member_email+"&member_id="+member_id;
            }
            function onFailure(err){
                console.log(err)
                return;
            }
    </script>
    <!-- kakaoLogin -->
    <!-- 아래 카카오 init메소드에 키값을 넣어주고 똑같이 카카오에서 진행해주는 api가 팝업으로 실행되면 동의를 한 정보들을 받아오게됩니다.
    그리고 성공 함수를 통해서 받아온 정보가 일치하게되면 href 를통해 컨트롤러에 보내주게되고 네이버와 마찬가지로 이메일중복값에 따라 회원가입과 로그인으로 나뉘게됩니다. -->
    <script type="text/javascript">
        Kakao.init("b4f94ac66d295c885352ddef0bf123d4"); //javascript key
        
        Kakao.Auth.createLoginButton({
			//id값을 설정한 곳에 버튼을 자동생성한다
			container : '#kakao-login-btn',
			success : function(authObj) {
				
				//request함수를 통해 사용자 정보를 얻는다
				Kakao.API.request({
					url : '/v2/user/me',
					success : function(res) {
					//카카오 이메일 정보 가져온 후 컨트롤러로 전송
					location.href = 'kakaologin.do?kakao_email='+res.kakao_account.email+"";
						//window.close();
					}
				})
				console.log(authObj);
				var token = authObj.access_token;
			},
			fail : function(err) {
				alert(JSON.stringify(err));	
			}
		});
    </script>

</body>
</html>