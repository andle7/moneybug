<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script></script>
<%@ include file="../resources/layout/header.jsp"%>
<%@ include file="../resources/layout/accountNav.jsp"%>

<div align="center">
	<!-- 날짜로 월간 넘어가게 설정가능해야함 -->
	<!--  ajax로 div에 gpt에서 받아온 결과 넣어줘야함. -->
	<!-- 차트 - 내역 -->
	<!-- 일별그래프 - 내역 -->
	<!-- GPT -->
	<!-- 선언만 먼저 해두고 ajax후에 success의 result로 chart생성 -->
<<<<<<< HEAD
	<div align="left">
		<label for="year">년 : </label>
			<select id="year" name="year">
  			<!-- 여기에 년도 옵션을 추가 -->
=======
	<div align="right">
		<label for="year">년 : </label>
			<select id="year" name="year">
>>>>>>> f652f4ae2c87244a90919d542c28dc1bf6b1d75a
		</select>

		<label for="month">월 : </label>
			<select id="month" name="month">
<<<<<<< HEAD
  			<!-- 여기에 월 옵션을 추가 -->
		</select>
		<button id="moveReport">이동</button>
=======
		</select>
		<button id="moveReport">이동</button>
		<button id="reportDownload">다운로드</button>
>>>>>>> f652f4ae2c87244a90919d542c28dc1bf6b1d75a
	</div>
	<h3>월간 지출 차트</h3>
	<div id="chartcontent" style="display: flex; width: 1100px; height: 655px; border: 1px solid #993300;">
    	<div style="flex: 1;" id="chartdiv">
        	<div id="mycharttest" style="width: 600px; height: 655px; border: 1px solid #993300;">
            	<canvas id="myChart" style="width: 600px; height: 655px; border: 1px solid #993300;"></canvas>
        	</div>
    	</div>
    	<div style="flex: 1; " id="MonthlyTalbe">
    	</div>
	</div>
	<br>
	<h3>최근 사용 내역(5회)</h3>
	<div id="mycharttest2" style="display: flex; width: 1100px; height: 650px; border: 1px solid #993300;">
    	<div style="flex: 1;">
     	   <canvas id="myChart2" style="width: 600px; height: 650px; border: 1px solid #993300;"></canvas>
    	</div>
   	 <div style="flex: 1;">
    	    <div style=" border: 1px solid #993300; height: 340px;" id="RecentTable"></div>
		<!-- DB에서 GPT답변 받아오는 div -->
			<div id="resultGPT" style="padding: 5px;">GPT : 돈 아껴써라 마!!!
	
			</div>
    	</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
    $(function() {
<<<<<<< HEAD
    	  // 년도 옵션 추가
    	  const yearSelect = document.getElementById("year");
    	  const currentYear = new Date().getFullYear();
    	  for (let year = currentYear; year >= currentYear - 10; year--) {
    	    const option = document.createElement("option");
    	    option.value = year;
    	    option.textContent = year;
    	    yearSelect.appendChild(option);
    	  }
    	  console.log(document.getElementById("year"));
    	  // 월 옵션 추가
    	  const monthSelect = document.getElementById("month");
    	  for (let month = 1; month <= 12; month++) {
    	    const option = document.createElement("option");
    	    option.value = month;
    	    option.textContent = month;
    	    monthSelect.appendChild(option);
    	  }
=======
		const ctx = document.getElementById('myChart');
		const ctx2 = document.getElementById('myChart2');
		let chart1;
		let chart2;
    	// 년도 옵션 추가
    	const yearSelect = document.getElementById("year");
    	const currentYear = new Date().getFullYear();
    	for (let year = currentYear; year >= currentYear - 10; year--) {
    	  let option = document.createElement("option");
    	  option.value = year;
    	  option.textContent = year;
    	  yearSelect.appendChild(option);
    	}
    	// 월 옵션 추가
    	const monthSelect = document.getElementById("month");
    	for (let month = 1; month <= 12; month++) {
    	  let option = document.createElement("option");
    	  option.value = month;
    	  option.textContent = month;
    	  monthSelect.appendChild(option);
    	}
    	monthSelect.selectedIndex = new Date().getMonth();
    	//사전 설정부  
    	  
    	  
>>>>>>> f652f4ae2c87244a90919d542c28dc1bf6b1d75a
        $.ajax({
            url: "monthlyReportRequestJSON",
            dataType: "json",
            method: "POST",
            data : {
            	year : $('#year').val(),
            	month : $('#month').val()
            },
            success: function(json) {
                let list = json.list;
                let map = json.map;
                let detailTotalDataList = [];
                let detailSomeDataPlusList = [];
                let detailSomeDataMinusList = [];
                let detailSomeLabelList = [];
                
                let listTable = '<table border="1" class="RecentTable"><tr><th>분류</th><th>사용내역</th><th>금액</th></tr>';
                for (var i = 0; i < list.length; i++) {
                    let formattedPrice = list[i].price.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
                    listTable += '<tr><td>' + list[i].accountCategory
                    + '</td><td>' + list[i].description
                    + '</td><td>' + formattedPrice + '</td></tr>';
                    detailSomeLabelList.push(list[i].description);
                    if(list[i].accountType=="지출"){
                    	detailSomeDataPlusList.push(0);
                        detailSomeDataMinusList.push(-list[i].price);
                    }else{
                    	
                    detailSomeDataPlusList.push(list[i].price);
                    detailSomeDataMinusList.push(0);
                    }
                }
                listTable += '</table>';
                


                $('#RecentTable').html(listTable);
                //
				$.ajax({
					url: "monthlyReportRequestBudgetAndExpenses",
					method: "POST",
		            data : {
		            	year : $('#year').val(),
		            	month : $('#month').val()
		            },
					success : function(budgetMap) {
		        	    let labelList = [];
		        	    let budgetDataList = [];
		                for (var budgetKey in budgetMap) {
		                    labelList.push(budgetKey);
		                    budgetDataList.push(budgetMap[budgetKey]);
		                }
		                
		                let mapTable = '<table border="1" class="MonthlyTable"><tr><th>분류</th><th>총액(현재 지출)</th><th>(지출 계획)</th></tr>';
		                let listInt = 0;
		                for (var key in map) {
		                    let formattedTotalPrice = map[key].toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
		                    let formattedTotalPrice2 = " ( "+(budgetDataList[listInt]).toLocaleString()+ " ) ";
		                    mapTable += '<tr><td>' + key + '</td><td>'
		                    + formattedTotalPrice + '</td><td>'+formattedTotalPrice2+'</td></tr>';
		                    listInt=listInt+1;
		                    detailTotalDataList.push(map[key]);
		                }
		                mapTable += '</table>'; //1차 ajax로부터 데이터
		                $('#MonthlyTalbe').html(mapTable);//1차 ajax로부터 데이터
		                
					//Chart.js 에서는 getContext('2d') 를 사용하지않아도됨.
						let chart1Data = {
							labels : labelList,
							datasets : [
								{
									label : '지출',
									data : detailTotalDataList,
									fill : true,
									backgroundColor : 'rgba(255, 99, 132, 0.2)',
									borderColor : 'rgb(255, 99, 132)',
									pointBackgroundColor : 'rgb(255, 99, 132)',
									pointBorderColor : '#fff',
									pointHoverBackgroundColor : '#fff',
									pointHoverBorderColor : 'rgb(255, 99, 132)'
									},
								{
									label : '예산-고정지출',
									data : budgetDataList,
									fill : true,
									backgroundColor : 'rgba(54, 162, 235, 0.2)',
									borderColor : 'rgb(54, 162, 235)',
									pointBackgroundColor : 'rgb(54, 162, 235)',
									pointBorderColor : '#fff',
									pointHoverBackgroundColor : '#fff',
									pointHoverBorderColor : 'rgb(54, 162, 235)'
								} ]
					}; // graph 데이터 선입력부분
					let config = {
						type : 'radar',
						data : chart1Data,
						options : {
							responsive : false,
							elements : {
								line : {
									borderWidth : 3
								}
							}
						},
					};
					chart1 = new Chart(ctx, config);
					let chart2Data = {
						labels : detailSomeLabelList,
						datasets : [{
							label : '수입',
							data : detailSomeDataPlusList,
							fill : true,
							backgroundColor : 'rgba(54, 162, 235, 0.2)',
							borderColor : 'rgb(54, 162, 235)',
							pointBackgroundColor : 'rgb(54, 162, 235)',
							pointBorderColor : '#fff',
							pointHoverBackgroundColor : '#fff',
							pointHoverBorderColor : 'rgb(54, 162, 235)'
							},
								{
									label : '지출',
									data : detailSomeDataMinusList,
									fill : true,
									backgroundColor : 'rgba(255, 99, 132, 0.2)',
									borderColor : 'rgb(255, 99, 132)',
									pointBackgroundColor : 'rgb(255, 99, 132)',
									pointBorderColor : '#fff',
									pointHoverBackgroundColor : '#fff',
									pointHoverBorderColor : 'rgb(255, 99, 132)'
								}
								 ]
					};
					let config2 = {
						type : 'bar',
						data : chart2Data,
						options : {
							responsive : false,
							indexAxis : 'y',
							elements : {
								line : {
									borderWidth : 3
								}
							}
						},
					};
					chart2 = new Chart(ctx2, config2);
				},//2차 success
				error: function(xhr, status, error) {
	                let errorMessage = "2차 오류 상태 코드: " + xhr.status + "\n"
	                    + "오류 메시지: " + error + "\n" + "오류 타입: "
	                    + status;
	                alert(errorMessage);
	            }
				}); // ajax2차
            },
            error: function(xhr, status, error) {
                let errorMessage = "오류 상태 코드: " + xhr.status + "\n"
                    + "오류 메시지: " + error + "\n" + "오류 타입: "
                    + status;
                alert(errorMessage);
            }
        }); // ajax1차 - 페이지 호출시 자동
        
        
        $.ajax({
        	url : "monthlyGPT",
            method: "POST",
            data : {
            	year : $('#year').val(),
            	month : $('#month').val()
            },
            success: function(answer) {
            	$('#resultGPT').html(answer);
            },
            error : function() {
            	$('#resultGPT').html("아직 분석되지 않은 레포트입니다.");				
			}
        });//gpt ajax
        
        
        $('#moveReport').click(function() {
            $.ajax({
                url: "monthlyReportRequestJSON",
                dataType: "json",
                method: "POST",
                data : {
                	year : $('#year').val(),
                	month : $('#month').val()
                },
                success: function(json) {
                    let list = json.list;
                    let map = json.map;
                    let detailTotalDataList = [];
                    let detailSomeDataPlusList = [];
                    let detailSomeDataMinusList = [];
                    let detailSomeLabelList = [];
                    
                    let listTable = '<table border="1" class="RecentTable"><tr><th>분류</th><th>사용내역</th><th>금액</th></tr>';
                    for (var i = 0; i < list.length; i++) {
                        let formattedPrice = list[i].price.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
                        listTable += '<tr><td>' + list[i].accountCategory
                        + '</td><td>' + list[i].description
                        + '</td><td>' + formattedPrice + '</td></tr>';
                        detailSomeLabelList.push(list[i].description);
                        if(list[i].accountType=="지출"){
                        	detailSomeDataPlusList.push(0);
                            detailSomeDataMinusList.push(-list[i].price);
                        }else{
                        	
                        detailSomeDataPlusList.push(list[i].price);
                        detailSomeDataMinusList.push(0);
                        }
                    }
                    listTable += '</table>';
                    


                    $('#RecentTable').html(listTable);
                    //
    				$.ajax({
    					url: "monthlyReportRequestBudgetAndExpenses",
    					method: "POST",
    		            data : {
    		            	year : $('#year').val(),
    		            	month : $('#month').val()
    		            },
    					success : function(budgetMap) {
    		        	    let labelList = [];
    		        	    let budgetDataList = [];
    		                for (var budgetKey in budgetMap) {
    		                    labelList.push(budgetKey);
    		                    budgetDataList.push(budgetMap[budgetKey]);
    		                }
    		                
    		                let mapTable = '<table border="1" class="MonthlyTable"><tr><th>분류</th><th>총액(현재 지출)</th><th>(지출 계획)</th></tr>';
    		                let listInt = 0;
    		                for (var key in map) {
    		                    let formattedTotalPrice = map[key].toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
    		                    let formattedTotalPrice2 = " ( "+(budgetDataList[listInt]).toLocaleString()+ " ) ";
    		                    mapTable += '<tr><td>' + key + '</td><td>'
    		                    + formattedTotalPrice + '</td><td>'+formattedTotalPrice2+'</td></tr>';
    		                    listInt=listInt+1;
    		                    console.log(listInt);
    		                    detailTotalDataList.push(map[key]);
    		                }
    		                mapTable += '</table>'; //1차 ajax로부터 데이터
    		                $('#MonthlyTalbe').html(mapTable);//1차 ajax로부터 데이터
    		                
    					//Chart.js 에서는 getContext('2d') 를 사용하지않아도됨.
    						let chart1Data = {
    							labels : labelList,
    							datasets : [
    								{
    									label : '지출',
    									data : detailTotalDataList,
    									fill : true,
    									backgroundColor : 'rgba(255, 99, 132, 0.2)',
    									borderColor : 'rgb(255, 99, 132)',
    									pointBackgroundColor : 'rgb(255, 99, 132)',
    									pointBorderColor : '#fff',
    									pointHoverBackgroundColor : '#fff',
    									pointHoverBorderColor : 'rgb(255, 99, 132)'
    									},
    								{
    									label : '예산-고정지출',
    									data : budgetDataList,
    									fill : true,
    									backgroundColor : 'rgba(54, 162, 235, 0.2)',
    									borderColor : 'rgb(54, 162, 235)',
    									pointBackgroundColor : 'rgb(54, 162, 235)',
    									pointBorderColor : '#fff',
    									pointHoverBackgroundColor : '#fff',
    									pointHoverBorderColor : 'rgb(54, 162, 235)'
    								} ]
    						}; // graph 데이터 선입력부분

    					chart1.data=chart1Data;
    					chart1.update();
    					
    					
    					
    					let chart2Data = {
    						labels : detailSomeLabelList,
    						datasets : [{
    							label : '수입',
    							data : detailSomeDataPlusList,
    							fill : true,
    							backgroundColor : 'rgba(54, 162, 235, 0.2)',
    							borderColor : 'rgb(54, 162, 235)',
    							pointBackgroundColor : 'rgb(54, 162, 235)',
    							pointBorderColor : '#fff',
    							pointHoverBackgroundColor : '#fff',
    							pointHoverBorderColor : 'rgb(54, 162, 235)'
    							},
    								{
    									label : '지출',
    									data : detailSomeDataMinusList,
    									fill : true,
    									backgroundColor : 'rgba(255, 99, 132, 0.2)',
    									borderColor : 'rgb(255, 99, 132)',
    									pointBackgroundColor : 'rgb(255, 99, 132)',
    									pointBorderColor : '#fff',
    									pointHoverBackgroundColor : '#fff',
    									pointHoverBorderColor : 'rgb(255, 99, 132)'
    								}
    								 ]
    					};

    					chart2.data = chart2Data;
    					chart2.update();
    				},//2차 success
    				error: function(xhr, status, error) {
    	                let errorMessage = "2차 오류 상태 코드: " + xhr.status + "\n"
    	                    + "오류 메시지: " + error + "\n" + "오류 타입: "
    	                    + status;
    	                alert(errorMessage);
    	            }
    				}); // ajax2차
    		        $.ajax({
    		        	url : "monthlyGPT",
    		            method: "POST",
    		            data : {
    		            	year : $('#year').val(),
    		            	month : $('#month').val()
    		            },
    		            success: function(answer) {
    		            	$('#resultGPT').html(answer);
    		            },
    		            error : function() {
    		            	$('#resultGPT').html("아직 분석되지 않은 레포트입니다.");
    					}
    		        });//gpt ajax
                },
                error: function(xhr, status, error) {
                    let errorMessage = "오류 상태 코드: " + xhr.status + "\n"
                        + "오류 메시지: " + error + "\n" + "오류 타입: "
                        + status;
                    alert(errorMessage);
                }
            }); // ajax1차 - 페이지 호출시 자동
		})
        
		$('#reportDownload').click(function() {
    		let accountBookId = 0; // 어떻게 accountBookId 값을 가져올지에 따라 설정
    		let year = $('#year').val();
    		let month = $('#month').val();
    
    		$.ajax({
        		url: "downloadPDF",
        		method: "POST",
        		xhrFields: {
            		responseType: "blob" //responseType을 blob으로 설정해 바이너리 데이터를 받아오도록함
        		},
        		data: {
            		accountBookId: accountBookId,
            		year: year,
            		month: month
        		},
		        success: function(data) {
        		    // 다운로드 링크 생성
            		let file = new File([data], "accountBook_" + accountBookId + "_" + year + "_" + month + ".pdf", { type: "application/pdf" }); //file객체를 이용해 binary데이터(data)를 "~"형태의 이름으로 저장 MIME타입은 application/pdf로 pdf임을 명시
            		let link = document.createElement("a");
            		link.href = URL.createObjectURL(file); //window객체의 하위객체인 URL 객체를 통해 파일 접근링크 생성
            		link.download = file.name; // 파일 다운로드
            		document.body.appendChild(link);
            		link.click();
            		document.body.removeChild(link);
        		},
        		error: function() {
            
        		}
    		});
		}); // reportDownload

    });//$
</script>
</div>
<%@ include file="../resources/layout/footer.jsp"%>