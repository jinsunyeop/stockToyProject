package com.spring.sunyeop2.login.service;

import com.spring.sunyeop2.core.response.Message;
import com.spring.sunyeop2.login.info.User;
import com.spring.sunyeop2.login.mapper.LoginMapper;
import com.spring.sunyeop2.login.mapper.UserMapper;
import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    UserMapper userMapper;

    @Value("${sunyeop2.profile.rootPath}")
    String rootPath;

    String baseMiddlePath = "/assets/profileImg";

    /*
    *  @param param (MultipartFile, String usrAs)
    *  프로필 수정 (이미지 업로드 및 업데이트, 닉네임 수정 및 저장)
    * */
    public ResponseEntity<Message> changeInfo(HashMap<String,Object> param)  {
        Message msg = new Message();
        MultipartFile fileInfo = (MultipartFile) param.get("file");

        //중간 폴더
        String middlePath = baseMiddlePath +"/"+(long)param.get("usrId");

        try {
            if(fileInfo != null){
                //파일명
                String fileName = fileInfo.getOriginalFilename();

                File file = new File(rootPath+middlePath);
                if(!file.exists()){file.mkdirs();}else{
                    File[] files = file.listFiles();
                    files[0].delete();
                }

                //img,jpg,jpeg
                String fileType = fileName.substring(fileName.lastIndexOf(".") + 1);

                //파일 저장
                String fullPath = middlePath +"/"+System.currentTimeMillis()+"."+fileType;
                fileInfo.transferTo(new File(rootPath+fullPath));

                param.put("filePath",fullPath);
                param.put("fileNm",fileName);

                userMapper.updateProfileImg(param);
                userMapper.updateUsrAs(param);
            }else {
                userMapper.updateUsrAs(param);
            }
            msg.setMessage("성공적으로 수정되었습니다. 해당 모든 수정사항은 재로그인시 적용됩니다.");
            msg.setStatus(HttpStatus.OK);
        }catch (Exception e) {
            msg.setMessage("요청 중 에러가 발생하였습니다. 다시 시도하시기 바랍니다.");
            msg.setStatus(HttpStatus.BAD_REQUEST);
            e.printStackTrace();
        }

        return new ResponseEntity<>(msg,HttpStatus.OK);
    }

}
