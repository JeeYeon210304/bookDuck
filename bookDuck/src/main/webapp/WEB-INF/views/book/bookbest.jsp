<%@ page language="java" contentType="text/html; charset=UTF-8"  
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ page import="javax.xml.parsers.*" %>    
<%@ page import="org.w3c.dom.*" %>    
<%@ page import="org.xml.sax.*" %>    
<%@ page import="java.net.*" %>    
<%@ page import="javax.xml.xpath.*" %>    
<%@ page import="javax.xml.transform.*" %>    
<%@ page import="javax.xml.transform.dom.*" %>    
<%@ page import="javax.xml.transform.stream.*" %>    
<%
	request.setCharacterEncoding("UTF-8");
    //절대경로 확인
    String path = request.getContextPath();
 
   
    //인터파크 도서 검색에 대한 XML 요청 및 분석, 결과 출력
    //http://book.interpark.com/api/search.api?key=개인키&query=검색어&queryType=검색기준&maxResults=10&inputEncoding=utf-8
 
    
 
    StringBuilder sb = new StringBuilder();
    String totalcount = "0";
    String count = "0";
    

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = null;
        String str = String.format(
                "http://book.interpark.com/api/bestSeller.api?key=771E0F8039AED93A550A2E5AF9B584422BCE5DADA5A58066811AADA99D972FA1&categoryId=100",
                URLEncoder.encode("UTF-8"));
        URL url = new URL(str);
        InputSource is = new InputSource(url.openStream());
        doc = builder.parse(is);
    
    
        XPath xpath = XPathFactory.newInstance().newXPath();
        totalcount = xpath.compile("/channel/totalResults").evaluate(doc);
        NodeList itemList = (NodeList)xpath.compile("/channel/item").evaluate(doc, XPathConstants.NODESET);
        int count_ = itemList.getLength();
        count = String.valueOf(count_); 
        for (int a=1; a <= count_; a++) {
            Node item = (Node)xpath.compile(String.format("/channel/item[%s]", a)).evaluate(doc, XPathConstants.NODE);
            String coverLargeUrl = xpath.compile("coverLargeUrl").evaluate(item);
            String title = xpath.compile("title").evaluate(item);
            String author = xpath.compile("author").evaluate(item);
            String publisher = xpath.compile("publisher").evaluate(item);
            String priceStandard = xpath.compile("priceStandard").evaluate(item);
            String description = xpath.compile("description").evaluate(item);
            String pubDate = xpath.compile("pubDate").evaluate(item);
            String isbn = xpath.compile("isbn").evaluate(item);
            String link = xpath.compile("link").evaluate(item);
            String categoryName = xpath.compile("categoryName").evaluate(item);
            String categoryId = xpath.compile("categoryId").evaluate(item);

    		// 비어있는 값 대비
    		if(description == null || description == "" || description == " " ){
    			description = "이 도서는 정보를 제공하지 않습니다.";
    		}
    		if(categoryId == null || categoryId == "" || categoryId == " " ){
    			categoryId = "이 도서는 정보를 제공하지 않습니다.";
    		}
    		if(categoryName == null || categoryName == "" || categoryName == " " ){
    			categoryName = "이 도서는 정보를 제공하지 않습니다.";
    		}
    		if(isbn == null || isbn == "" || isbn == " " ){
    			isbn = "이 도서는 정보를 제공하지 않습니다.";
    		}
    		if(pubDate == null || pubDate == "" || pubDate == " " ){
    			pubDate = "이 도서는 정보를 제공하지 않습니다.";
    		}
    		if(publisher == null || publisher == "" || publisher == " " ){
    			publisher = "이 도서는 정보를 제공하지 않습니다.";
    		}
    		if(author == null || author == "" || author == " " ){
    			author = "이 도서는 정보를 제공하지 않습니다.";
    		}
    		
            sb.append(String.format("<div class='row result'>"));
            sb.append(String.format("<div class='col-md-1'><span>%s</span></div>", a));
            sb.append(String.format("<div class='col-md-4' style=' overflow : auto;'><img src='%s' class='resize'></div>", coverLargeUrl));
            sb.append(String.format("<div class='col-md-7'><ul>"));
    		sb.append(String.format("<table id = 'tbb' style='table-layout:fixed'><tr> <td id='td1'><b> &#128157;&nbsp; 제목 </b></td> <td id='td2'>%s</td> </tr>", title));
    		sb.append(String.format("<tr> <td id='td1' ><b> &#128039;&nbsp; 저자 </b></td> <td  id='td2'>%s</td> </tr>", author));
    		sb.append(String.format("<tr> <td id='td1' ><b> &#127804;&nbsp; 출판사 </b></td> <td  id='td2'>%s</td> </tr>", publisher));
    		sb.append(String.format("<tr> <td id='td1' ><b> &#127904;&nbsp; 설명 </b></td> <td id='td2'>%s</td> </tr>", description));
    		sb.append(String.format("<tr> <td id='td1' ><b> &#127826;&nbsp; 판매가 </b></td> <td id='td2'>%s</td> </tr>", priceStandard));
    		sb.append(String.format("<tr> <td id='td1' ><b> &#10024;&nbsp; 출간일 </b></td> <td id='td2'>%s</td> </tr>", pubDate));
    		sb.append(String.format("<tr> <td id='td1' ><b> &#127800;&nbsp; ISBN </b></td> <td id='td2'>%s</td> </tr>", isbn));
    		sb.append(String.format("<tr> <td id='td1' ><b> &#128049;&nbsp; 카테고리 </b></td> <td id='td2'>%s</td> </tr>", categoryName));
    		sb.append(String.format("<tr> <td id='td1' ><b> &#127776;&nbsp; 분류 </b></td> <td id='td2'>%s</td> </tr> </table>", categoryId));
    		sb.append(String.format("</div>"));
    		sb.append(String.format("</div>"));
    		sb.append(String.format("<div class='wrapper'>"));
    		sb.append(String.format("<div id='btncss'><a href='%s' target='_blank'>&#128184;&nbsp;구매하기</a></div>",
    		link));
    		sb.append(String.format("<div id='btncss'><a href='recommendBook.do?title=%s&coverLargeUrl=%s&isbn=%s&author=%s&categoryId=%s'  target='_blank'>&#128149;&nbsp;도서추천</a></div>",title,coverLargeUrl,isbn,author,categoryId));
    		sb.append(String.format("<div id='btncss'><a href='scinsert.do?title=%s&isbn=%s&coverLargeUrl=%s&author=%s&categoryId=%s' target='_blank'>&nbsp;&#127873;&nbsp;&nbsp;찜하기&nbsp;&nbsp;</a></div>",title,isbn,coverLargeUrl,author,categoryId));
    		sb.append(String.format("</div>"));
        }
    
    
%>
<!DOCTYPE html>
<html>
<head>
<title>베스트셀러</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
 
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 
 
<!-- jQuery library -->
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
<!-- Latest compiled JavaScript -->
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
<style type="text/css">


div.result {
	border-top: 1px solid #dddddd;
	margin-top: 10px;
	padding: 20px;
	margin-bottom: 10px;
}


/* 책 정보 */
td{
	width: 130px;
	text-align: left;
	vertical-align: top;
	
}
#td1{
	padding: 3px;
}

#td2{
	width: 380px;
	padding : 3px;
}



/* 도서 검색 대문 */
#h1 {
	font-size: 40px;
	font-weight: bold;
	text-align: center;
	color: #696969;
	letter-spacing: 3px;
	transition: 1s;
	-webkit-transition: 1s;
	-ms-transition: 1s;
	position: relative;
	padding: 12px;
}

#h1:before, #h1:after {
	content: "";
	position: absolute;
	height: 8px;
	width: 0px;
	background: #ffd800;
	transition: 300ms;
	-webkit-transition: 1s;
	-ms-transition: 1s;
	opacity: 0.3;
	left: 50%;
	
}

#h1:before {
	bottom: 0;
}

#h1:after {
	top: 0;
}

#h1:hover {
	letter-spacing: 30px;
}

#h1:hover:before, #h1:hover:after {
	width: 100%;
	opacity: 1;
	left: 0;
}

#h1:hover ~ #h2 {
	opacity: 0;
}

#h2{
	color: #0A11FF;
	font-family: 'Pinyon Script', cursive;
	text-align: center;
	font-size: 30px;
	font-weight: 100;
	bottom: 40px;
	transition: 1s;
	-webkit-transition: 1s;
	-ms-transition: 1s;
	opacity: 0.3;
	width: 100%;
}

/* 구매하기, 추천하기, 찜하기 버튼 */
.wrapper {
  position : relative;
  text-align: right;
  bottom : 10px;
}

#btncss { 
  padding : 10px 10px 10px 10px;
  color: #A071F5;
  font-weight : bold;
  text-transform: uppercase;
  text-align: center;
  position: relative;
  text-decoration: none;
  display:inline-block;
}

a{
text-decoration: none;
}

#btncss a:hover, #btncss a:visited, #btncss a:active {
text-decoration: none;
}


#btncss::before {
  content: '';
  position: absolute;
  bottom: 0%;
  left: 0px;
  width: 100%;
  height: 1px;
  background: #6098FF;
  display: block;
  -webkit-transform-origin: right top;
  -ms-transform-origin: right top;
  transform-origin: right top;
  -webkit-transform: scale(0, 1);
  -ms-transform: scale(0, 1);
  transform: scale(0, 1);
  -webkit-transition: transform 0.4s cubic-bezier(1, 0, 0, 1);
  transition: transform 0.4s cubic-bezier(1, 0, 0, 1)
}

#btncss:hover::before {
  -webkit-transform-origin: left top;
  -ms-transform-origin: left top;
  transform-origin: left top;
  -webkit-transform: scale(1, 1);
  -ms-transform: scale(1, 1);
  transform: scale(1, 1)
}

/* 올라가기 고정 버튼 */
#upup {
    position: fixed;
    height : 30px;
    width : 50px;
    right: 50px;
    bottom: 50px;
    z-index: 50;
    /*
    height : 50px;
    width : 50px;
    
    right: 2%;
    bottom: 50px;
    z-index: 999;
    */
 
}

/* 페이지 스크롤업 이미지 */
#upup img{
	height : 50px;
    width : 50px;
}

/* 이미지 리사이즈 */
.resize{
	height: auto;
	width: 265px;
	
</style> 
<script>
	// 올라가기 고정 버튼  
	$(function(){
		$('#upup').on('click',function(e){
			e.preventDefault();
			$('html,body').animate({scrollTop:0},1000);
		});
	});
</script>
 
</head>
<body>
  <jsp:include page="../header.jsp"/>
  
    <div class="container">
            
        <div class="panel page-header" style="text-align: center;">
           <div class="e">
          	 <h1 id="h1">
              &#128218;&nbsp;베스트셀러
           	 </h1>
             <h2 id="h2">BookDuck</h2>
            </div>
        </div>
      <div id="btncss" style="float: right; padding: 4px 15px 15px 10px;"><a href="newBook.do">&#10024;&nbsp;신간도서</a></div>
      <div id="btncss" style="float: right; padding: 4px 15px 15px 10px;"><a href="booksearch.do">&#128270;&nbsp;도서검색</a></div>
      <br/><br/>
 
        <div class="panel panel-default" id="output">
            <div class="panel-heading">&#128036;&nbsp;베스트셀러</div>
            <div class="panel-body">
                <button type="button" class="btn btn-default" style="text-align: right;">
                      최근 7일 간의 판매량과 주문 수를 기준으로 매일 1회 집계됩니다.
                 </button>
                 
                 <div style="float : right; padding: 3px 4px;">
                      <span class="badge" id="totalcount"><%=totalcount%></span>&nbsp;권의 도서를 소개합니다.
                </div>
                
                <%=sb.toString() %>
                
            </div>
        </div>
    		<!-- 페이지 스크롤업 -->
		<div id="upup">
			<img src="resources/img/arrow_up.png" >
		</div>
    
    
    </div>
 
</body>
</html>

