package com.boot.Service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.DAO.ResumeDAO;
import com.boot.DAO.SNSMyPageDAO;
import com.boot.DTO.CompanyInfoDTO;
import com.boot.DTO.ResumeDTO;
import com.boot.DTO.SNSFeedbackDTO;
import com.boot.DTO.SNSFollowDTO;
import com.boot.DTO.SNSIntroDTO;
import com.boot.DTO.UserDTO;
import com.boot.DTO.UserImageUploadDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("SNSMyPageService")
public class SNSMyPageServiceImpl implements SNSMyPageService {
    @Autowired
    private SqlSession sqlSession;


    @Override
	public List<ResumeDTO> resumeInfo(HashMap<String, String> param) {
//	public ResumeDTO resumeInfo(HashMap<String, String> param) {
		log.info("@# SNSServiceImpl snsResume");
			
		SNSMyPageDAO dao = sqlSession.getMapper(SNSMyPageDAO.class);
		List<ResumeDTO> resumeDTO = dao.resumeInfo(param);
//		ResumeDTO resumeDTO = dao.resumeInfo(param);
		  
	    log.info("@# Retrieved Resumes: " + resumeDTO);
		
		return resumeDTO;
	}

	@Override
	public CompanyInfoDTO companyInfo(String email) {
		SNSMyPageDAO dao= sqlSession.getMapper(SNSMyPageDAO.class);
		CompanyInfoDTO companyDTO = dao.companyInfo(email);
		 log.info("@# companyInfo =>"+companyDTO);
		
		return companyDTO;
	}

	@Override
	public UserDTO getUserInfo(String user_email) {
		log.info("@# SNSServiceImpl getUserInfo");
		
		SNSMyPageDAO dao = sqlSession.getMapper(SNSMyPageDAO.class);
		 log.info("Fetching user info for email: " + user_email);
		UserDTO userDTO = dao.getUserInfo(user_email);
		log.info("Retrieved UserDTO: " + userDTO);
		
		log.info("@# userDTO=>"+userDTO);
		return userDTO;
		
	}
	
	@Override
	public SNSIntroDTO getSNSIntro(String user_email) {
		log.info("@#SNSServiceImpl getSNSIntro");
		
		SNSMyPageDAO dao = sqlSession.getMapper(SNSMyPageDAO.class);
		SNSIntroDTO introDTO = dao.getSNSIntro(user_email);
		return introDTO;
	}
	
	@Override
	public void modifySNSIntro(HashMap<String, String> param) {
		SNSMyPageDAO dao = sqlSession.getMapper(SNSMyPageDAO.class);
		dao.modifySNSIntro(param);
	}

	@Override
	public List<SNSIntroDTO> getSNSStack(String user_email) {
		SNSMyPageDAO dao= sqlSession.getMapper(SNSMyPageDAO.class);
		List<SNSIntroDTO> snsStack = dao.getSNSStack(user_email);
		log.info("@# snsIntro =>"+snsStack);
		return snsStack;
	}

	@Override
	public List<SNSIntroDTO> getSNSJob(String user_email) {
		SNSMyPageDAO dao= sqlSession.getMapper(SNSMyPageDAO.class);
		List<SNSIntroDTO> snsJob = dao.getSNSJob(user_email);
		log.info("@# snsIntro =>"+snsJob);
		return snsJob;
	}

	@Override
	public List<UserImageUploadDTO> getUserImage(String user_email) {
		SNSMyPageDAO dao= sqlSession.getMapper(SNSMyPageDAO.class);
		return dao.getUserImage(user_email);
	}

	@Override
	public void deletePost(HashMap<String, String> param) {
		log.info("@# 게시물 삭제");
		SNSMyPageDAO dao = sqlSession.getMapper(SNSMyPageDAO.class);
		dao.deletePost(param);
	}

	@Override
	public void writeFeedback(SNSFeedbackDTO snsFeedbackDTO) {
		log.info("@# 피드백 작성");
		SNSMyPageDAO dao = sqlSession.getMapper(SNSMyPageDAO.class);
		dao.writeFeedback(snsFeedbackDTO);
		
	}
	
	@Override
	public List<SNSFeedbackDTO> getFeedback(HashMap<String, String> param) {
		SNSMyPageDAO dao= sqlSession.getMapper(SNSMyPageDAO.class);
		List<SNSFeedbackDTO> snsFeedback = dao.getFeedback(param);
		log.info("@# SNSFeedback =>"+snsFeedback);
		return snsFeedback;
	}
	
	@Override
	public void deleteFeedback(HashMap<String, String> param) {
		log.info("@# 게시물 삭제");
		SNSMyPageDAO dao = sqlSession.getMapper(SNSMyPageDAO.class);
		dao.deleteFeedback(param);
	}

	@Override
	public SNSFollowDTO followerCount(String user_email) {
		SNSMyPageDAO dao = sqlSession.getMapper(SNSMyPageDAO.class);
		SNSFollowDTO followerCount = dao.followerCount(user_email);
		return followerCount;
	}
	
	@Override
	public SNSFollowDTO followingCount(String user_email) {
		SNSMyPageDAO dao = sqlSession.getMapper(SNSMyPageDAO.class);
		SNSFollowDTO followingCount = dao.followingCount(user_email);
		return followingCount;
	}

	@Override
	public List<SNSFollowDTO> followerList(HashMap<String, String> param) {
		log.info("@# DAO param follow_email: " + param.get("follow_email")); 
		SNSMyPageDAO dao= sqlSession.getMapper(SNSMyPageDAO.class);
		List<SNSFollowDTO> followerList = dao.followerList(param);
		log.info("@# followList =>"+followerList);
		return followerList;
	}

	@Override
	public List<SNSFollowDTO> followingList(HashMap<String, String> param) {
		SNSMyPageDAO dao= sqlSession.getMapper(SNSMyPageDAO.class);
		log.info("Params: " + param);
		List<SNSFollowDTO> followingList = dao.followingList(param);
		log.info("@# followingList =>"+followingList);
		log.info("Following List from DAO: " + followingList);
		return followingList;
	}
	
}
