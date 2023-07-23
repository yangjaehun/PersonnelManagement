package com.project.pm.alarm.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.pm.alarm.model.AlarmDAO;
import com.project.pm.alarm.model.AlarmVO;

@Service
public class AlarmServiceImp implements AlarmService{
	
	@Autowired
	private AlarmDAO adao;

	// AOP 알람추가하기
	@Override
	public void addAlarm(Map<String, String> paraMap) {
		Calendar currentDate = Calendar.getInstance();
		SimpleDateFormat dateft = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		
		String time = dateft.format(currentDate.getTime());

		String str_fk_recipientno = paraMap.get("fk_recipientno");
		
		if(str_fk_recipientno == null || str_fk_recipientno == "") {
			return;
		}
		
		String str_url2 = paraMap.get("url2");
		String[] arr_fk_recipientno = str_fk_recipientno.split(",");
		String[] arr_url2 = str_url2.split(",");
		
		String alarmType = "";
		
		if( "1".equals(paraMap.get("alarm_type"))) alarmType = "&#9200;";
		if( "2".equals(paraMap.get("alarm_type"))) alarmType = "&#10071;";
		if( "3".equals(paraMap.get("alarm_type"))) alarmType = "&#9989;";
		if( "4".equals(paraMap.get("alarm_type"))) alarmType = "&#128161;";
		if( "5".equals(paraMap.get("alarm_type"))) alarmType = "&#128226;";
		if( "6".equals(paraMap.get("alarm_type"))) alarmType = "&#128178;";
		
		StringBuilder sb = new StringBuilder();
		sb.append(" INSERT ALL ");
		
		String startLine = " into tbl_alarm (pk_alarmno, fk_recipientno, url2, url, alarm_content, alarm_type ) values (";
		String endLine =  paraMap.get("url") + "', '" + paraMap.get("alarm_content") + "', '" + alarmType + "') ";
		
		if(arr_url2.length>1) {
			
			for( int i=0; i<arr_fk_recipientno.length; i++) {
				sb.append(startLine);
				sb.append( time+i +" , " + arr_fk_recipientno[i] + " , '" + arr_url2[i] + "', '");
				sb.append(endLine);
			}
			
		} else {
			
			for( int i=0; i<arr_fk_recipientno.length; i++) {
				sb.append(startLine);
				sb.append( time+i +" , " + arr_fk_recipientno[i] + " , '" + str_url2 + "', '");
				sb.append(endLine);
			}
			
		}
		
		
		sb.append(" SELECT * FROM DUAL ");
		
		//System.out.println(sql));
		// mdao.sendMessenger(sb.toString()); 
		adao.addAlarm(sb.toString());
	}


	// 알람 조회하기
	@Override
	public List<AlarmVO> getAlarmList(String empno) {
		List<AlarmVO> alarmList = adao.getAlarmList(empno);
		return alarmList;
	}
	
	
	// 지난 알람 조회하기
	@Override
	public List<AlarmVO> getPastAlarmList(String empno) {
		List<AlarmVO> alarmList = adao.getPastAlarmList(empno);
		return alarmList;
	}


	// 알람 읽기
	@Override
	public void readAlarm(String alarmno) {
		adao.readAlarm(alarmno);
	}
	
	
	// 모든 알람 읽기
	@Override
	public void readAllAlarm(String empno) {
		adao.readAllAlarm(empno);
	}


	// 안 읽은 소식 개수 알아오기
	@Override
	public String getUnreadAlarmCnt(String empno) {
		String n = adao.getUnreadAlarmCnt(empno);
		return n;
	}
}

