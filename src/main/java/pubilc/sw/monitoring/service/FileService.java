/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author qntjd
 * 파일 처리를 위한 클래스
 */
@Service
@RequiredArgsConstructor
@PropertySource("classpath:/system.properties")
public class FileService {
    
    @Autowired
    private ServletContext ctx;
    
    /**
     * 서버가 시작될 때 파일들의 저장을 위한 폴더가 없으면 생성한다
     */
    @PostConstruct
    public void startServerEditFolder(){
        try{
            Properties properties = new Properties();
            properties.load(new FileInputStream(new ClassPathResource("system.properties").getFile()));
            for (Map.Entry<Object, Object> entry : properties.entrySet()) {
                if(entry.getKey().toString().contains(".folder")){
                    File dir = new File(ctx.getRealPath(entry.getValue().toString()));
                    if(!dir.exists()){
                        dir.mkdir();
                    }
                }
            }
        }catch (IOException e) {
            
        }
    }
    
    /**
     * 파일을 해당하는 폴더에 파일을 저장
     * @param path 파일 저장 위치
     * @param id 파일 소유 아이디
     * @param files 저장해야할 파일 리스트
     */
    public void saveFile(String path, String id, List<MultipartFile> files){
        if(!files.isEmpty()){ // 저장할 파일이 있을 때
            path = String.format("%s%s%s", ctx.getRealPath(path),File.separator,id);
            File baseidDir = new File(path);// 각 파일을 소유하는 폴더 경로

            if(!baseidDir.exists()){ // 각 파일의 소유자 폴더가 존재하지 않을 시 폴더를 생성
                baseidDir.mkdir();
            }
           for(MultipartFile file : files){
                File f = new File(String.format("%s%s%s", baseidDir,File.separator,file.getOriginalFilename())); // 저장할 파일을 생성
                try(BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(f))){
                    bos.write(file.getBytes()); //파일을 저장

                }catch(IOException e){

                }
           }
        }
    }
    
    //폴더 안에 파일 목록을 검색한다.
    public List<String> searchFile(String path, String id){
        List<String> fileNameList = new ArrayList<>();
        File[] fileList = new File(String.format("%s%s%s", ctx.getRealPath(path),File.separator,id)).listFiles();
        for(File file : fileList){
                fileNameList.add(file.getName());
        }
        return fileNameList;
    }
    
    //파일 다운로드
    public ResponseEntity<Resource> downloadFile(String url, String filename){
        HttpHeaders headers = new HttpHeaders();
        //파일의 Content-Type 찾기
        Path path = Paths.get(ctx.getRealPath(url) + File.separator + filename);
        String contentType = null;
        try {
            contentType = Files.probeContentType(path);
        } catch (IOException e) {
        }

        //Http 헤더 생성
        headers.setContentDisposition(
                ContentDisposition.builder("attachment").filename(filename, StandardCharsets.UTF_8).build());
        headers.add(HttpHeaders.CONTENT_TYPE, contentType);

        //파일을 입력 스트림으로 만들어 내려받기 준비
        Resource resource = null;
        try {
            resource = new InputStreamResource(Files.newInputStream(path));
        } catch (IOException e) {
        }
        if (resource == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
    }
    
    //폴더 전체를 삭제
    public void deleteFile(String path, String id){
        path = String.format("%s%s%s", ctx.getRealPath(path),File.separator,id);
        File file = new File(path);
        if(file.exists()){ // 해당 경로의 폴더가 존재할 때 실행
            File[] fileList = file.listFiles();
            if(fileList != null){ 
                for(File f : fileList){ 
                    if(f.isFile()){ // 파일이면 그대로 삭제
                        f.delete();
                    }else{ // 재귀함수를 통해 폴더들 삭제
                        deleteFile(f.getAbsolutePath(), id);
                    }
                }
            }
            file.delete(); // 해당 경로의 폴더 삭제
        }
    }
    
    // 파일 부분 삭제
    public void deleteFile(String path, String id ,String list){
        path = String.format("%s%s%s", ctx.getRealPath(path),File.separator,id);
        File file = new File(path);
        File[] fileList = file.listFiles();
        if(fileList != null){
            for(File f : fileList){
                if(f.getName().indexOf(list) != 0){ // 삭제 리스트에서 파일이름이 포함되어 있으면 삭제
                    f.delete();
                }
            }
        }
    }
    
    /**
     * String을 txt파일로 저장하는 함수 => 회의록의 내용을 저장하기위한 함수
     * @param content 저장할 내용
     * @param path 저장할 경로
     * @param name 생성할 파일 명
     * @return 저장 성공 여부
     */
    public boolean saveStringToFile(String content, String path, String name){
        try {
            Files.write(Paths.get(ctx.getRealPath(path)), content.getBytes(StandardCharsets.UTF_8));
            return true;
        } catch (IOException ex) {
            return false;
        }
    }
}
