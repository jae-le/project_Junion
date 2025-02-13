package com.boot.Service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.DAO.CardPageDAO;
import com.boot.DAO.ComNoticeDAO;
import com.boot.DAO.CompanyListDAO;
import com.boot.DTO.ComNoticeAttachDTO;
import com.boot.DTO.ComNoticeDTO;
import com.boot.DTO.Standard;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("CardPageService")
public class CardPageServiceImpl implements CardPageService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
//	public ArrayList<ComNoticeDAO> cardPageList(Standard std) {//페이징을 및 검색을 위한 메소드
	public ArrayList<ComNoticeDTO> cardPageList(String orderType, Standard std) {//페이징을 및 검색을 위한 메소드
		log.info("CardPageServiceImpl");
		log.info("std 확인용 ->"+std);
		log.info("orderType 확인용 ->"+orderType);
		log.info("com_email 확인용 ->"+std.getComEmail());
		
		CardPageDAO dao = sqlSession.getMapper(CardPageDAO.class);
//		CardPageDAO daos = sqlSession.getMapper(CardPageDAO.class);
		ArrayList <ComNoticeDTO> list = dao.cardPageList(orderType, std);// 진행중인 공고를 얻음
//		ArrayList <ComNoticeDAO> list = dao.cardPageList(dao);
		log.info("list 확인용 ->"+list);
		return list;
	}
	

	@Override
//	public int getTotalCount(){//전체 공고 수 구하기
	public int getTotalCount(Standard  std){//전체 공고 수 구하기
	log.info("@# CardPageServiceImpl getTotalCount");
	log.info("@# CardPageServiceImpl getTotalCount std=>"+std);
	CardPageDAO dao= sqlSession.getMapper(CardPageDAO.class);
	
	log.info("이메일 확인은? "+std.getComEmail());
//	int total = dao.getTotalCount();
	int total = dao.getTotalCount(std);
	log.info("전체 공고 수는? "+total);
	
	return total;
	}
	
	@Override
	public ArrayList<String> getCareerList() {// 경력 선택지를 얻음
		log.info("@# getStackList");
		CardPageDAO dao = sqlSession.getMapper(CardPageDAO.class);
		ArrayList<String> list = dao.getCareerList();
		return list;
	}
	
	@Override
	public ArrayList<String> getStackList() {// 스택 값을 얻음
		log.info("@# getStackList");
		CardPageDAO dao = sqlSession.getMapper(CardPageDAO.class);
		ArrayList<String> list = dao.getStackList();
		return list;
	}

	@Override
	public ArrayList<String> getLocationList() {// 위치 정보를 얻음
		log.info("@# getLocationList");
		CardPageDAO dao = sqlSession.getMapper(CardPageDAO.class);
		ArrayList<String> list = dao.getLocationList();
		return list;
	}
	
	
	// 2024-08-01 지수 (공고 목록 사진 들고오기)
	@Override
	public List<ComNoticeAttachDTO> cardPageFileList(int notice_num) {
		log.info("CardPageServiceImpl cardPageFileList");
		CardPageDAO dao = sqlSession.getMapper(CardPageDAO.class);
		
		return dao.cardPageFileList(notice_num);
	}

}
