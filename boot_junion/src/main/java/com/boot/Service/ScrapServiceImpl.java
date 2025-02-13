package com.boot.Service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.DAO.ScrapDAO;
import com.boot.DTO.ScrapDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("ScrapService")
public class ScrapServiceImpl implements ScrapService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String existingCompany(String user_email, int notice_num){//기존 관심기업 스크랩 정보를 가져옴
		ScrapDAO dao = sqlSession.getMapper(ScrapDAO.class);
		String com_email = dao.existingCompany(user_email, notice_num);// session, 페이지에서 각각 값을 가져옴
		return com_email;	
	}
	
	@Override
	public boolean uploadcomScrap(HashMap<String, String> param){//관심기업 스크랩
		ScrapDAO dao = sqlSession.getMapper(ScrapDAO.class);
//		String user_email = param.get("user_email");
//		int notice_num = Integer.parseInt(param.get("notice_num"));
		boolean result = false;
		
//		String check = dao.existingCompany(user_email, notice_num);
		String check = dao.existingCompany(param);//파라미터를 달리 해서 같은 메소드를 날림
		if(check == null) {//관심 기업에 추가되지 않았다면 관심 기업 목록에 추가
			dao.uploadcomScrap(param);
			result = true;
		}else {
			dao.deleteComScrap(param);
			result = false;
		}
			
		return result;
	}
	
	
	
	@Override
	//관심 기업 목록
		public ArrayList<String> getScrapList(String user_email){//관심기업 목록에서 기업 리스트를 가져옴
	
		ScrapDAO dao = sqlSession.getMapper(ScrapDAO.class);
		ArrayList<String> list = dao.getScrapList(user_email);
		
		return list;
	}
	
	
	
	@Override
	public boolean comListScrap(HashMap<String, String> param) {// 관심 기업 목록에서 스크랩 처리
		
		ScrapDAO dao = sqlSession.getMapper(ScrapDAO.class);
		String check = dao.getCheck(param);
		boolean result = false;
		
		if(check == null) {
			dao.uploadcomScrap(param);
			result = true;
		}else {
			dao.deleteComScrap(param);
			result = false;
		}
		return result;
	}
	

	@Override
	public String getCheck(String com_email, String user_email) {// 기업목록 상세 : 관심기업 정보를 가져옴
		log.info("scrap serviceimpl getScrapNoticeNum method!!!");
		ScrapDAO dao = sqlSession.getMapper(ScrapDAO.class);
		String check = dao.getCheck(com_email, user_email);
		
		return check;
	}
	

		
	@Override
	public ArrayList<Integer> getScrapNoticeNum(String user_email){//관심 공고 목록을 가져옴
		log.info("scrap serviceimpl getScrapNoticeNum method!!!");
		ScrapDAO dao = sqlSession.getMapper(ScrapDAO.class);
		ArrayList<Integer> list = dao.getScrapNoticeNum(user_email);
		
		return list;
	}
	
	@Override
	public boolean checkScrapNotice(HashMap<String, String> param){//관심 공고 스크랩
		log.info("checkScrapNotice!!!");
		
		ScrapDAO dao = sqlSession.getMapper(ScrapDAO.class);	
		ScrapDTO check = dao.checkNoticeNum(param);
		boolean result = false;	
		
		if(check == null) {
			dao.addScrapNotice(param);
			result = true;
		}else {
			dao.deleteScrapNotice(param);
			result = false;
		}
//		
		return result;
	}


	

//	@Override
//	public ArrayList<ComNoticeDTO> getScrapNoticList(String noticeScrapArray) {//스크랩 채용공고 목록 보기
//		
//		// 쉼표로 구분된 문자열을 정수 리스트로 변환
//		List<Integer> noticeArr = Arrays.stream(noticeScrapArray.split(","))
//				.map(String::trim)          // 각 문자열의 양쪽 공백 제거
//				.map(Integer::parseInt)     // 문자열을 정수로 변환
//				.collect(Collectors.toList());
//		log.info("@# getScrapNoticList noticeArr=>"+noticeArr);
//		
//		
//		// noticeArr 번호를 하나하나씩 넣어서 쿼리 실행
//		ArrayList<ComNoticeDTO> list = new ArrayList<>();
//		
//		ScrapDAO dao = sqlSession.getMapper(ScrapDAO.class);
//		
//		 for (int noticeNum : noticeArr) {
//	            ComNoticeDTO dto = dao.getScrapNotice(noticeNum);
//	            list.add(dto);
//			log.info("@# getScrapNoticList list=>"+list);
//	     }
//		 
//		return list;
//	}

	



	
	
	

	
//	@Override
//	public ArrayList<ComNoticeDTO> JobPostCard() {//채용정보 목록 불러오기
//		log.info("@# JobPostServiceImpl JobPostCard");
//		
//		ComNoticeDAO dao = sqlSession.getMapper(ComNoticeDAO.class);
//		ArrayList<ComNoticeDTO> dto = dao.JobPostCard();
//		
////		 log.info("@# JobPostCard =>"+dto);
//		
//		return dto;
////		return null;
//	}
//	
//
//	public ArrayList<ComNoticeDTO> JobPostCard(String user_email) {//채용정보 목록 불러오기
//		log.info("@# JobPostServiceImpl JobPostCard");
//		
//		ComNoticeDAO dao = sqlSession.getMapper(ComNoticeDAO.class);
//		ArrayList<ComNoticeDTO> dto = dao.JobPostCard();
//		
////		 log.info("@# JobPostCard =>"+dto);
//		
//		return dto;
////		return null;
//	}
//	
//	public ComNoticeDTO JobPost(int notice_num) {//채용공고 상세
//		log.info("@# JobPostServiceImpl JobPost!!!");
//		
//		ComNoticeDAO dao = sqlSession.getMapper(ComNoticeDAO.class);
//		ComNoticeDTO dto = dao.JobPost(notice_num);
//		
//		return dto;
//	}
//	
//	public String comLocation(String com_email){//상세 채용공고-회사 위치 가져오기
//
//		ComNoticeDAO dao = sqlSession.getMapper(ComNoticeDAO.class);
//		String com_location = dao.comLocation(com_email);
//		
//		return com_location;
//	}
//	
//	
//	
////	지수
//
//	
//	@Override
//	public void registerNotice(ComNoticeDTO comNoticeDTO) {
//		log.info("@# ComNoticeServiceImpl list registerNotice");
//		
//		ComNoticeDAO dao = sqlSession.getMapper(ComNoticeDAO.class);
//		dao.registerNotice(comNoticeDTO);
//
//		log.info("@# comNoticeDTO=>"+comNoticeDTO);
//		
////		첨부파일 있는지 체크
//		log.info("@# comNoticeDTO.getComNoticeAttachList()=>"+comNoticeDTO.getComNoticeAttachList());
//		if (comNoticeDTO.getComNoticeAttachList() == null || comNoticeDTO.getComNoticeAttachList().size() == 0) {
//			log.info("@# null");
//			return;
//		}
//		
////		첨부파일이 있는 경우 처리
//		comNoticeDTO.getComNoticeAttachList().forEach(attach -> {
//			attach.setNotice_num(comNoticeDTO.getNotice_num());
//			dao.registInsertFile(attach);
//		});
//		
//		updateNoticeNums(comNoticeDTO.getCom_email());
//	}
//	
//	@Override
//    public void updateNoticeNums(String com_email) {
//		ComNoticeDAO dao = sqlSession.getMapper(ComNoticeDAO.class);
//        // com_email로 notice_num을 조회
//        List<Integer> noticeNums = dao.getNoticeNums(com_email);
//
//        // notice_num 리스트를 콤마로 구분된 문자열로 변환
//        String noticeNumsStr = noticeNums.stream()
//                                         .map(String::valueOf)
//                                         .collect(Collectors.joining(","));
//
//        // com_tb 테이블에 업데이트
//        dao.updateNoticeNums(com_email, noticeNumsStr);
//    }
//	
//	
//	
//	//파일 업로드
//	@Override
//	public List<ComNoticeAttachDTO> registGetFileList(int notice_num) {
//		log.info("@# ComNoticeServiceImpl registGetFileList");
//		
//		ComNoticeDAO dao = sqlSession.getMapper(ComNoticeDAO.class);
//		
//		return dao.registGetFileList(notice_num);
//	}
//
//	@Override
//	public void registDeleteFile(List<ComNoticeAttachDTO> fileList) {
//		log.info("@# ComNoticeServiceImpl deleteFiles");
//		log.info("@# ComNoticeServiceImpl fileList 값 =>"+fileList);
//		
//		if (fileList == null || fileList.size() == 0) {
//			return;
//		}
//		
//		fileList.forEach(attach -> {
//			try {
//				Path file = Paths.get("C:\\devv\\upload\\"+attach.getUploadPath()+"\\"
//											 +attach.getUuid()+"_"+attach.getFileName());
//				Files.deleteIfExists(file);
//				
//				if (Files.probeContentType(file).startsWith("image")) {
//					Path thumbNail = Paths.get("C:\\devv\\upload\\"+attach.getUploadPath()+"\\s_"
//							+attach.getUuid()+"_"+attach.getFileName());
//					Files.delete(thumbNail);
//				}
//			} catch (Exception e) {
//				log.error("delete file error"+e.getMessage());
//			}
//		});//end of forEach
//	}
//
//	


}
