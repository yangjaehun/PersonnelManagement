package com.project.pm.commute.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.pm.commute.model.CommuteVO;
import com.project.pm.commute.service.CommuteService;
import com.project.pm.employee.model.EmpVO;
import com.project.pm.parameter.controller.ParameterStringBuilder;

@Controller
public class CommuteController {
	
	@Autowired
	private CommuteService service;
	
	// 출근 메소드
		@ResponseBody
		@RequestMapping(value="/commute/commuteStart.pm", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
		public String commuteStart(HttpServletRequest request) {

			HttpSession session = request.getSession();
			EmpVO loginuser = (EmpVO)session.getAttribute("loginuser");
			String name = loginuser.getName();
			
			String fk_empno = request.getParameter("fk_empno");
			
			int n = service.commuteStart(fk_empno);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			
			if(n > 0) {
				System.out.println("들어옴");
				try {
					sendSlack(name+"님이 " + getTime() + "에 출근 하셨습니다.");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			return jsonObj.toString();
		}
		
		
		// 출근했는지 확인하는 메소드
		@ResponseBody
		@RequestMapping(value="/commute/checkCommute.pm", produces="text/plain;charset=UTF-8", method = {RequestMethod.GET})
		public String checkCommute(HttpServletRequest request) {
			
			boolean isExist = false;
			
			JSONObject jsonObj = new JSONObject();
			
			String fk_empno = request.getParameter("fk_empno");
			
			CommuteVO commutevo = service.checkCommute(fk_empno);
			
			if(commutevo != null) {
				isExist = true;
				
				jsonObj.put("commuteno", commutevo.getCommuteno());
				jsonObj.put("fk_empno", commutevo.getFk_empno());
				jsonObj.put("start_work_time", commutevo.getStart_work_time());
				jsonObj.put("end_work_time", commutevo.getEnd_work_time());
				jsonObj.put("overtime", commutevo.getOvertime());
				jsonObj.put("worktime", commutevo.getWorktime());
			}
			
			jsonObj.put("isExist", isExist);
			
			
			return jsonObj.toString();
		}
		
		// 퇴근하기 버튼
		@ResponseBody
		@RequestMapping(value="/commute/commuteEnd.pm", produces="text/plain;charset=UTF-8", method = {RequestMethod.POST})
		public String commuteEnd(HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			EmpVO loginuser = (EmpVO)session.getAttribute("loginuser");
			String name = loginuser.getName();
			
			String fk_empno = request.getParameter("fk_empno");
			String worktime = request.getParameter("worktime");
			String overtime = request.getParameter("overtime");
			
			Map<String,String> paraMap = new HashMap<>();
			
			paraMap.put("fk_empno",fk_empno);
			paraMap.put("worktime",worktime);
			paraMap.put("overtime",overtime);
			
			int n = service.commuteEnd(paraMap);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("n", n);
			
			if(n > 0) {
				System.out.println("들어옴");
				try {
					sendSlack(name+"님이 " + getTime() + "에 퇴근 하셨습니다.");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			return jsonObj.toString();
		}
		
		@RequestMapping(value="/commute/mycommute.pm", method = {RequestMethod.GET})
		public String mycommute(HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			EmpVO evo = (EmpVO) session.getAttribute("loginuser");
			String empno = evo.getEmpno();
			//System.out.println("확인용 empno => " + empno);
			
			String startdate = request.getParameter("startdate");
			String enddate = request.getParameter("enddate");
			
			if(startdate == null && enddate == null) { // 처음으로 페이지 진입시
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				
				Calendar cal = Calendar.getInstance();
				
				//일주일의 첫날 선택
		        cal.setFirstDayOfWeek(Calendar.MONDAY);
		 
		        //해당 주차 시작일과의 차이 구하기용
		        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - cal.getFirstDayOfWeek();
		 
		        //해당 주차의 첫날 세팅
		        cal.add(Calendar.DAY_OF_MONTH, - dayOfWeek);
		        
		        //해당 주차의 첫일자
		        startdate = format.format(cal.getTime());
		 
		        //해당 주차의 마지막 세팅
		        cal.add(Calendar.DAY_OF_MONTH, 4); 
		 
		        //해당 주차의 마지막일자
		        enddate = format.format(cal.getTime());
		        
				/*
				 * System.out.println("stDt => "+startdate);
				 * System.out.println("edDt => "+enddate);
				 */
		        
			}
			
			Map<String, String> paraMap = new HashMap<>();
	        
	        paraMap.put("startdate",startdate);
	        paraMap.put("enddate",enddate);
	        paraMap.put("fk_empno",empno);
	        
	        List<CommuteVO> commuteList = service.mycommute(paraMap);
	        
	        long plus_worktime = 0;
			
			if(commuteList != null) {
				
				for(CommuteVO commutevo :commuteList) {
					
					String worktime = commutevo.getWorktime();
					String overtime = commutevo.getOvertime();
					System.out.println(worktime);
					
					int integer_worktime = Integer.parseInt(worktime);
					int integer_overtime = Integer.parseInt(overtime);
					 
					plus_worktime += integer_worktime;
					plus_worktime += integer_overtime;
					
					if(integer_worktime != 0) {
						worktime = getWorkingTime(integer_worktime);
						commutevo.setWorktime(worktime);
					}
					if(integer_overtime != 0) {
						overtime = getWorkingTime(integer_overtime);
						commutevo.setOvertime(overtime);;
					}
					
				}
				
			}
			
			request.setAttribute("plus_worktime", plus_worktime);
	        request.setAttribute("commuteList", commuteList);
	        
			return "manage/mycommute.admin";
		}
		
		
		@ResponseBody
		@RequestMapping(value="/commute/ajaxMycommute.pm", produces="text/plain;charset=UTF-8", method = {RequestMethod.GET})
		public String ajaxMycommute(HttpServletRequest request) {
			
			String fk_empno = request.getParameter("fk_empno");
			String startdate = request.getParameter("startdate");
			String enddate = request.getParameter("enddate");
			
			//System.out.println(fk_empno);
			//System.out.println(startdate);
			//System.out.println(enddate);
			
			Map<String,String> paraMap = new HashMap<>();
			
			paraMap.put("startdate",startdate);
	        paraMap.put("enddate",enddate);
	        paraMap.put("fk_empno",fk_empno);
			
	        List<CommuteVO> commuteList = service.mycommute(paraMap);
			
	        JSONArray jsonArr = new JSONArray();
	        
	        if(commuteList != null) {
	        		
	        		for(CommuteVO commutevo : commuteList) {
	        			JSONObject jsonObj = new JSONObject();
	        			
	        			System.out.println("확인 "+commutevo.getOvertime());
	        			
	        			jsonObj.put("dt", commutevo.getDt());
	        			jsonObj.put("commuteno", commutevo.getCommuteno());
	        			jsonObj.put("start_work_time", commutevo.getStart_work_time());
	        			jsonObj.put("end_work_time", commutevo.getEnd_work_time());
	        			jsonObj.put("worktime", commutevo.getWorktime());
	        			jsonObj.put("overtime", commutevo.getOvertime());
	        			
	        			jsonArr.put(jsonObj);
	        		}
	        	
	        }
			
			return jsonArr.toString();
		}
		
		private String getWorkingTime(int worktime) {
			
			String hour = "";
			String minute = "";
			
			hour = String.valueOf((int)Math.floor(worktime/60));
			minute = String.valueOf((int)Math.floor(worktime%60));
			String workingTime = hour+"시간 "+minute+"분";
			
			return workingTime;
			
		}
		
		public void sendSlack(String message) throws Exception {
	        //create a connection to a given URL using POST method
	        URL url = new URL("https://slack.com/api/chat.postMessage");
	        HttpURLConnection httpURLConnection = (HttpURLConnection) url.openConnection();
	        
	        //Setting Headers
	        httpURLConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
	        httpURLConnection.setRequestProperty("Authorization", "Bearer ");
	        httpURLConnection.setRequestMethod("POST");

	        //Adding Request Params
	        Map<String, String> params = new HashMap<>();
	        params.put("channel", "C04EF7EHM6F");
	        params.put("text", message);
	        params.put("pretty", "1");
	        httpURLConnection.setDoOutput(true);
	        DataOutputStream out = new DataOutputStream(httpURLConnection.getOutputStream());
	        out.writeBytes(ParameterStringBuilder.getParamsString(params));
	        out.flush();
	        out.close();

	        //Configuring TimeOut
	        httpURLConnection.setConnectTimeout(5000);
	        httpURLConnection.setReadTimeout(5000);

	        //Reading the Response
	        BufferedReader in = new BufferedReader(
	                new InputStreamReader(httpURLConnection.getInputStream())
	        );
	        String inputLine;
	        StringBuffer content = new StringBuffer();
	        while ((inputLine = in.readLine()) != null) {
	            content.append(inputLine);
	        }
	        in.close();

	        //Disconnect
	        httpURLConnection.disconnect();

	        //Print the content
	        System.out.println("content = " + content);
	    }
		
		
		
		
		@ResponseBody
		@RequestMapping(value="/insight/sumWorktimeByDept.pm", method = {RequestMethod.GET})
		public List<Map<String,Object>> sumWorktimeByDept(HttpServletRequest request) {
			
			
			return service.sumWorktimeByDept();
		}
		
		
		
		@ResponseBody
		@RequestMapping(value="/insight/avgSalaryByDept.pm", method = {RequestMethod.GET})
		public List<Map<String,Object>> avgSalaryByDept(HttpServletRequest request) {
			
			
			return service.avgSalaryByDept();
		}
		
		
		// 현재 시간을 가져오는 메소드
		private String getTime() {
			
			Calendar calendar = Calendar.getInstance();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
			return formatter.format(calendar.getTime());
		}
	

}
