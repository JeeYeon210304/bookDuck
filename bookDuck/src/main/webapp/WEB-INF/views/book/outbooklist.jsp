<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="org.xml.sax.*"%>
<%@ page import="java.net.*"%>
<%@ page import="javax.xml.xpath.*"%>
<%@ page import="javax.xml.transform.*"%>
<%@ page import="javax.xml.transform.dom.*"%>
<%@ page import="javax.xml.transform.stream.*"%>
<%
	request.setCharacterEncoding("UTF-8");
//절대경로 확인
String path = request.getContextPath();

/*
 * XML Parsing 
 * 1. XML document loading -> XML Object 
 * 2. root element 
 * 3. child element 
 * 4. text node 
 * 5. print
 */

//인터파크 도서 검색에 대한 XML 요청 및 분석, 결과 출력
//http://book.interpark.com/api/search.api?key=개인키&query=검색어&queryType=검색기준&maxResults=10&inputEncoding=utf-8

//검색 기준 및 검색 단어 수신


String start = request.getParameter("start");
if(start == null){
	start = "1";
}
String sort = request.getParameter("sort");
if(sort == null){
	sort = "accuracy";
}
System.out.println("---------");
System.out.println(start);
System.out.println(sort);

/*
Crawler craw = new Crawler();
craw.Crawler(value, start, key);
*/

//System.out.println(key);
//System.out.println(value);
//System.out.println(start);


StringBuilder sb = new StringBuilder();
String totalcount = "0";
String count = "0";

	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	DocumentBuilder builder = factory.newDocumentBuilder();
	Document doc = null;
	String str = String.format(
	"http://book.interpark.com/api/search.api?key=7A71D8E679DA9C96874476B8E225B77A4592E29959B15764C52A257C0343754F&query=1&start=%s&maxResults=10&inputEncoding=utf-8&sort=%s&searchTarget=foreign",
	 start, sort);
	URL url = new URL(str);
	System.out.println(url);

	//System.out.println(url);
	InputSource is = new InputSource(url.openStream());
	doc = builder.parse(is);


	XPath xpath = XPathFactory.newInstance().newXPath();
	totalcount = xpath.compile("/channel/totalResults").evaluate(doc);
	NodeList itemList = (NodeList) xpath.compile("/channel/item").evaluate(doc, XPathConstants.NODESET);
	int count_ = itemList.getLength();
	count = String.valueOf(count_);
	for (int a = 1; a <= count_; a++) {
		Node item = (Node) xpath.compile(String.format("/channel/item[%s]", a)).evaluate(doc, XPathConstants.NODE);
		String coverLargeUrl = xpath.compile("coverLargeUrl").evaluate(item);
		String title = xpath.compile("title").evaluate(item);
		String author = xpath.compile("author").evaluate(item);
		String publisher = xpath.compile("publisher").evaluate(item);
		String priceStandard = xpath.compile("priceStandard").evaluate(item);
		String description = xpath.compile("description").evaluate(item);
		String pubDate = xpath.compile("pubDate").evaluate(item);
		String isbn = xpath.compile("isbn").evaluate(item);
		String link = xpath.compile("link").evaluate(item);
		String categoryId = xpath.compile("categoryId").evaluate(item);
		String categoryName = xpath.compile("categoryName").evaluate(item);
		//System.out.println(title);

		sb.append(String.format("<div class='row result'>"));
		sb.append(String.format("<div class='col-md-1'><span>%s</span></div>", a));
		sb.append(String.format("<div class='col-md-3'><img src='%s'></div>", coverLargeUrl));
		sb.append(String.format("<div class='col-md-6'><ul>"));
		sb.append(String.format("<li>title : %s</li>", title));
		sb.append(String.format("<li>author : %s</li>", author));
		sb.append(String.format("<li>publisher : %s</li>", publisher));
		sb.append(String.format("<li>description : %s</li>", description));
		sb.append(String.format("<li>priceStandard : %s</li>", priceStandard));
		sb.append(String.format("<li>pubDate : %s</li>", pubDate));
		sb.append(String.format("<li>isbn : %s</li>", isbn));
		sb.append(String.format("<li>categoryId : %s</li>", categoryId));
		sb.append(String.format("<li>categoryName : %s</li>", categoryName));
		sb.append(String.format("</ul></div>"));
		sb.append(String.format("<div><a href='%s' class='btn btn-default btn-xs' target='_blank'>인터파크 바로가기</a></div>",
		link));
		sb.append(String.format("</div>"));

	}
%>
<!DOCTYPE html>
<html>
<head>
<title>카악퉤..</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.1/css/font-awesome.min.css" />

<style>
div.result {
	border-top: 1px solid #dddddd;
	margin-top: 10px;
	padding: 20px;
	margin-bottom: 10px;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>



<!-- jQuery library -->

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
<script>


	var currentPageNum; //현재 페이지 번호 저장용 전역변수
	
    $(document).ready(function() {
        
        console.log("통신");
        
       	 currentPageNum = "1";
		 currentPage(currentPageNum);
        
		//이전, 다음 버튼 -> 페이지 이동
		$("#previous").click(function() {
			var previousNum = parseInt(currentPageNum)-1;
			//ajax($("#value").val(), $("#key option:selected").val(), previousNum);			
			currentPage(previousNum);
			startChange( previousNum, $("#publishTime").val());
		});
		
		$("#next").click(function() {
			var nextNum = parseInt(currentPageNum)+1;
			//ajax($("#value").val(), $("#key option:selected").val(), nextNum);			
			currentPage(nextNum);
			startChange( nextNum, $("#publishTime").val());
		});
	
		
		// 출간일 정렬
		$("#publishTime").click(function() {
			realsort(currentPageNum, $("#publishTime").val());
		});
		
		// 정확도 정렬
		$("#accuracy").click(function() {
			realsort(currentPageNum, $("#accuracy").val());
		});
		
		// 제목 정렬
		$("#title").click(function() {
			realsort(currentPageNum, $("#title").val());
		});
		
		// 판매량 정렬
		$("#salesPoint").click(function() {
			realsort(currentPageNum,  $("#salesPoint").val());
		});
		
		// 고객평점 정렬
		$("#customerRating").click(function() {
			realsort(currentPageNum,$("#customerRating").val());
		});
		
		// 리뷰갯수 정렬
		$("#reviewCount").click(function() {
			realsort( currentPageNum, $("#reviewCount").val());
		});
		
		// 가격오름순 정렬
		$("#price").click(function() {
			realsort(currentPageNum,  $("#price").val());
		});
		
		// 가격내림순 정렬
		$("#priceDesc").click(function() {
			realsort(currentPageNum,  $("#priceDesc").val());
		});
		
		
	    function realsort(start, sort){
	    	
            //console.log("시작");
	    	$.ajax({
            	
                type : "post",
                data: {"start" : start,  "sort" : sort},
                
                success: function(list){
                	// console.log("성공");
                	
                	var arr = list.split('<');
					//console.log(arr);
					
                    var value = "";
                    
                    
                    for(var i=79; i < arr.length; i++){
                    	value += '<'+arr[i]
                    };
                    
                    //console.log(value);
                    var value2 = value.split("<ul class=");
                    //console.log(value2);
                    
                    
					$("#hi").hide();
					$("#pagingBody").html(value2[0]);

                }, error: function(){
                    console.log("실패");
                }
            });
        }
    	
	    
	    
	    
	    
	    function startChange(start, sort){
	    	
            //console.log("시작");
	    	$.ajax({
            	
                type : "post",
                data: { "start" : start, "sort" : sort},
                
                success: function(list){
                	//console.log("성공");
                	//console.log(list);
        			
        			var arr = list.split('<');
					console.log(arr);
        			
                    var value = "";
                    
                    
                    for(var i=79; i < arr.length; i++){
                    	value += '<'+arr[i]
                    };
                    
                    //console.log(value);
                    var value2 = value.split("<ul class=");
                    //console.log(value2);
                    
                    
					$("#hi").hide();
					$("#pagingBody").html(value2[0]);

                }, error: function(){
                    console.log("덧붙이기 ajax 실패");
                }
            });
        }
    	
	    
	    	
		
    });

	
	

	function currentPage(idx) {
		$(".currentPage").text(idx);
		currentPageNum = idx;
	}
    
</script>

</head>
<body>

	<div class="container">

		<div class="panel page-header" style="text-align: center;">
			<h1 style="font-size: xx-large;">
				<!-- 주의)상대경로 대신 절대경로 표기를 권장한다. -->
				&#128218;&nbsp;해외도서 <small></small> <span
					style="font-size: small; color: #777777;"></span>
			</h1>
		</div>

		<div class="panel-group">
		</div>


		<div class="panel panel-default" id="output">
			<div class="panel-heading">&#128036;&nbsp;도서 목록</div>
			<div class="panel-body" id="hey">
				<button type="button" class="btn btn-default">
					TotalCount <span class="badge" id="totalcount"><%=totalcount%></span>
				</button>
				<button type="button" class="btn btn-default">
					Count <span class="badge" id="count"><%=count%></span>
				</button>
				<button type="button" class="btn btn-default">
					CurrentPage <span class="badge currentPage">0</span>
				</button>
				
				<div id="sorting" style="float: right">
					<button class="btn btn-default" id="accuracy" value="accuracy">정확도순</button>
					<button class="btn btn-default" id="publishTime" value="publishTime">출간일</button>
					<button class="btn btn-default" id="title" value="title">제목</button>
					<button class="btn btn-default" id="salesPoint" value="salesPoint">판매량</button>
					<button class="btn btn-default" id="customerRating" value="customerRating">고객평점</button>
					<button class="btn btn-default" id="reviewCount" value="reviewCount">리뷰갯수</button>
					<button class="btn btn-default" id="price" value="price">가격오름순</button>
					<button class="btn btn-default" id="priceDesc" value="priceDesc">가격내림순</button>
				</div>
				
				<div id="hi">
				<%=sb.toString()%>
				</div>
				
				<div id="pagingBody"></div>
			</div>
			<div id="pagingBody"></div>
			<ul class="pager">
				<li><button type="button" class="btn btn-default"
						id="previous" value="1">Previous</button></li>
				<li><button type="submit" class="btn btn-default" 
					id="next" value="2">Next</button></li>
			</ul>
		</div>


	</div>
		<script type="text/javascript">
	var r = document.getElementById('value');

	function startConverting() {
		//check this browser is chrome or not. because this application supported only in chrome browser

		if ('webkitSpeechRecognition' in window) {
			//Web speech API Function
			var speechRecognizer = new webkitSpeechRecognition();
			//continuous : you will catch mic only one time or not
			speechRecognizer.continuous = true;
			//interimResults : during capturing the mic you will send results or not
			speechRecognizer.interimResults = true;
			//lang : language (ko-KR : Korean, en-IN : englist)
			speechRecognizer.lang = "ko-KR";
			//start!
			speechRecognizer.start();

			var finalTranscripts = '';

			//if the voice catched onresult function will start
			speechRecognizer.onresult = function(event) {
				var interimTranscripts = '';
				for (var i = event.resultIndex; i < event.results.length; i++) {
					var transcript = event.results[i][0].transcript;
					transcript.replace("\n", "<br>");

					//isFinal : if speech recognition is finished, isFinal = true
					if (event.results[i].isFinal) {
						finalTranscripts += transcript;
					} else {
						interimTranscripts += transcript;
					}
				}
				//insert into HTML
				r.value = finalTranscripts + interimTranscripts;
			};
			speechRecognizer.onerror = function(event) {
			};
		} else {
		}
	}
	</script>

</body>
</html>