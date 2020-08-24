package alz.lesson.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import alz.lesson.domain.LessonCriteria;
import alz.lesson.domain.LessonDTO;
import alz.lesson.domain.LessonDetailDTO;
import alz.lesson.domain.LessonPageDTO;
import alz.lesson.domain.TeacherDTO;
import alz.lesson.service.LessonServiceImpl;
import alz.order.service.MerchandiseServiceImpl;
import alz.user.domain.UserDTO;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/lesson")
@Log4j
public class LessonPageController {
   
   private LessonServiceImpl lessonService;
   private MerchandiseServiceImpl merchandiseService;
   
   private ServletContext servletContext;
   
   @Autowired
   public LessonPageController(LessonServiceImpl lessonService, MerchandiseServiceImpl merchandiseService, ServletContext servletContext) {
      this.lessonService = lessonService;
      this.merchandiseService = merchandiseService;
      this.servletContext = servletContext;
   }
   
   public UserDTO getLoginUserInfo() {
      SecurityContext context = SecurityContextHolder.getContext();
      Authentication auth = context.getAuthentication();
      UserDTO userInfo = (UserDTO)auth.getPrincipal();
      return userInfo;
   }
   
	
//	@GetMapping("/list") 
//	public void list(Model model){
//		model.addAttribute("list", lessonService.readAll()); 
//	}
	 
   
	// 리스트
	@GetMapping("/list") 
	public void list(@RequestParam(required=false) Long main, 
					 @RequestParam(required=false) Long sub, LessonCriteria cri, Model model) {
		if(main!=null) {
			cri.setCategoryMain(main.intValue());
			cri.setCategorySub(sub.intValue());
		}
		cri.setState(7);
		model.addAttribute("list", lessonService.readAll(cri));
		int total = lessonService.getTotal(cri);
	  
		// 페이징 
		model.addAttribute("pageMaker", new LessonPageDTO(cri, total));
	  
	}
	 
  
   // 클래스 상세
   @GetMapping("/read")
   public void get(@RequestParam Long id, Model model) {
      model.addAttribute("lesson", lessonService.readByLessonId(id));
      model.addAttribute("detail", lessonService.detailByLessonId(id));
      model.addAttribute("curriculum", lessonService.curriculumByLessonId(id));
      model.addAttribute("schedule", lessonService.timeTableByLessonId(id));
      model.addAttribute("teacher", lessonService.teacherByLessonId(id));
      model.addAttribute("quickReview", lessonService.quickReviewByLessonId(id));
      model.addAttribute("merchandise", merchandiseService.readByrefId(id));
   }

   // 강사등록
   @GetMapping("/register")
   public void register(@RequestParam(required=false) Long originalId, Model model) {
      UserDTO user = getLoginUserInfo();
      if(user!=null) {
         model.addAttribute("teacher", lessonService.teacherByUserId(user.getId()));
      }
   }
   
   // 강사등록
   @PostMapping("/registerTeacher")
   public String registerTeacher(TeacherDTO teacher) {
      if(teacher.getId()==null) {
         teacher = lessonService.createTeacher(teacher);
      } else {
         teacher = lessonService.updateTeacher(teacher);
      }
      String url="redirect:/lesson/registerBasic?teacherId="+teacher.getId();
      
      if(teacher.getOriginalId()!=null)
    	  url = "redirect:/lesson/registerBasic?teacherId="+teacher.getId()+"&originalId="+teacher.getOriginalId();
      
      return url;
   }

   // 작성중클래스, 개설했던 클래스 가져오기
   @GetMapping("/registerBasic")
   public void registerBasic(@RequestParam(required=false) Long teacherId, 
		   					 @RequestParam(required=false) Long originalId, 
		   					 @RequestParam(required=false) Long lessonId, Model model) {
      if(teacherId!=null) {
    	 // 개설했던 클래스
    	 LessonDTO lesson = new LessonDTO();
    	 lesson.setTeacherId(teacherId);
    	 lesson.setState(7L);
         model.addAttribute("oldLessons", lessonService.lessonsByTeacherId(lesson));
         
         // 작성중 클래스
         lesson.setTeacherId(teacherId);
    	 lesson.setState(1L);
         model.addAttribute("lesson", lessonService.lessonByTeacherId(lesson));
      } else {
          model.addAttribute("lesson", lessonService.basicByLessonId(lessonId));
      }
      
      model.addAttribute("mainCategory", lessonService.mainCategory());
      model.addAttribute("subCategory", lessonService.subCategory());
      model.addAttribute("levelList", lessonService.lessonLevel());
   }
   
   // 기본정보 저장
   @PostMapping("/registerBasic")
   public String registerBasic(LessonDTO lesson, MultipartFile uploadFile) {
      int lessonId;
      Long originalId = lesson.getOriginalId();
      
      // 입출력 시작
    	  

      if(uploadFile!=null) {
      String uploadFolder = servletContext.getRealPath("/resources/img/lesson/thumb");
      File uploadPath = new File(uploadFolder, lesson.getTeacherId().toString()+lesson.getOpenAt());
      System.out.println("upload path : " + uploadPath);
      log.info("upload path : " + uploadPath);

      if (uploadPath.exists() == false) {
         uploadPath.mkdir();
      }

         String uploadFilename = uploadFile.getOriginalFilename();

         // IE has file path
         uploadFilename = uploadFilename.substring(uploadFilename.lastIndexOf("\\") + 1);

         UUID uuid = UUID.randomUUID();
         uploadFilename = uuid.toString() + "_" + uploadFilename;

         try {
            // 이미지 파일 path에 올리기
            File saveFile = new File(uploadPath, uploadFilename);
            uploadFile.transferTo(saveFile);

         } catch (Exception e) {
            log.error(e.getMessage());
         } // end catch

            lesson.setThumbnail(uploadFilename);
            
      }
            
            // 입출력 끝

      
      lessonId = lessonService.createLesson(lesson);
      
      String url = "redirect:/lesson/register?originalId="+originalId;
      
      if(lesson.getLocation().equals("next")) {
    	  url = "redirect:/lesson/registerSchedule?lessonId="+lessonId+"&originalId="+originalId;

	      if(originalId==null) {
	    	  url = "redirect:/lesson/registerSchedule?lessonId="+lessonId;
	      }
      } else {
    	  url = "redirect:/lesson/register?originalId="+originalId;
    	  
    	  if(originalId==null) {
        	  url = "redirect:/lesson/register";
	      }
      }

      return url;
   }
   
	// 클래스 스케줄 
	@GetMapping("/registerSchedule")
	public void registerSchedule(@RequestParam Long lessonId, @RequestParam(required=false) Long originalId, Model model) {
		if(originalId!=null) {
			model.addAttribute("schedule", lessonService.scheduleByLessonId(originalId));
		} else {
			model.addAttribute("schedule", lessonService.scheduleByLessonId(lessonId));
		}
	}
   
	// 클래스 세부 설명
	@GetMapping("/registerDetail")
	public void registerDetail(@RequestParam Long lessonId, @RequestParam(required=false) Long originalId, Model model) {
		model.addAttribute("detail", lessonService.detailByLessonId(lessonId));
	}
	
	// 클래스 세부 설명 저장 
	@PostMapping("/registerDetail")
	public String registerDetail(LessonDetailDTO lessonDetail) {
		int id;
	    Long originalId = lessonDetail.getOriginalId();
	    Long lessonId = lessonDetail.getLessonId();
	    id = lessonService.createLessonDetail(lessonDetail);
	      
	    String url = "redirect:/lesson/registerSchedule?originalId="+originalId;
	      
	    if(lessonDetail.getLocation().equals("prev")) {
	    	  url = "redirect:/lesson/registerSchedule?lessonId="+lessonId+"&originalId="+originalId;

		      if(originalId==null) {
		    	  url = "redirect:/lesson/registerSchedule?lessonId="+lessonId;
		      }
	      } else {
	    	  url = "redirect:/lesson/registerCurriculum?lessonId="+lessonId+"&originalId="+originalId;
	    	  
	    	  if(originalId==null) {
	        	  url = "redirect:/lesson/registerCurriculum?lessonId="+lessonId;
		      }
	      }
		
	   return url;
	}

	// 클래스 커리큘럼
	@GetMapping("/registerCurriculum")
	public void registerCurriculum(@RequestParam Long lessonId, @RequestParam(required=false) Long originalId, Model model) {
		if(originalId!=null) {
			model.addAttribute("originCurriculum", lessonService.curriculumByLessonId(originalId));
		}
		model.addAttribute("newCurriculum", lessonService.curriculumByLessonId(lessonId));
	}
	
	// 클래스 제출
	@PostMapping("/registerSubmit")
	public String registerSubmit(Long lessonId) {
		int success=0;
		if(lessonId!=null) {
			Long userId = getLoginUserInfo().getId();
			success=lessonService.lessonSubmit(lessonId, userId);
		}
		System.out.println("제출" + success);
		return "redirect:/";
	}
}
