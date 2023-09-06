/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import pubilc.sw.monitoring.repository.RequestRepository;
import pubilc.sw.monitoring.dto.RequestDTO;
import pubilc.sw.monitoring.entity.MemberEntity;
import pubilc.sw.monitoring.entity.RequestEntity;
import pubilc.sw.monitoring.entity.UserEntity;
import pubilc.sw.monitoring.repository.MemberRepository;
import pubilc.sw.monitoring.repository.UserRepository;

/**
 *
 * @author parkchaebin
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class RequestService {

    private final RequestRepository requestRepository;
    private final UserRepository userRepository;
    private final MemberRepository memberRepository;
    private final FileService fileService;

    @Value("${request.folder}")
    private String requestFolderPath;

    @Autowired
    private ServletContext ctx;

    /**
     * 해당 프로젝트의 모든 요구사항
     *
     * @param pid 해당 프로젝트 아이디
     * @return 해당 프로젝트의 모든 요구사항 리스트 객체
     */
    public List<RequestDTO> getRequests(Long pid) {
        List<RequestEntity> requestEntities = requestRepository.findByPid(pid);
        List<RequestDTO> requestDTOs = new ArrayList<>();

        for (RequestEntity requestEntity : requestEntities) {

            UserEntity userEntity = userRepository.findById(requestEntity.getUid()).orElse(null);
            String username = (userEntity != null) ? userEntity.getName() : null;

            requestDTOs.add(RequestDTO.builder()
                    .frid(requestEntity.getFrid())
                    .pid(requestEntity.getPid())
                    .rid(requestEntity.getRid())
                    .name(requestEntity.getName())
                    .content(requestEntity.getContent())
                    .date(requestEntity.getDate())
                    .rank(requestEntity.getRank())
                    .stage(requestEntity.getStage())
                    .target(requestEntity.getTarget())
                    .uid(requestEntity.getUid())
                    .note(requestEntity.getNote())
                    .username(username) // username 설정
                    .build());
        }

        return requestDTOs;
    }

    /**
     * 요구사항 저장 및 수정
     *
     * @param requestDTOList
     * @return 저장 성공 여부
     */
    public boolean saveRequest(RequestDTO requestDTO) {
        List<RequestEntity> requestEntities = new ArrayList<>();

        RequestEntity requestEntity = RequestEntity.builder()
                .frid(requestDTO.getFrid())
                .pid(requestDTO.getPid())
                .rid(requestDTO.getRid())
                .name(requestDTO.getName())
                .content(requestDTO.getContent())
                .date(requestDTO.getDate())
                .rank(requestDTO.getRank())
                .stage(requestDTO.getStage())
                .target(requestDTO.getTarget())
                .uid(requestDTO.getUid())
                .note(requestDTO.getNote())
                .build();

        return requestRepository.save(requestEntity) != null;
    }

    /**
     * 입력한 이름을 기반으로 프로젝트 멤버 중 해당하는 이름 검색
     *
     * @param username
     * @param pid
     * @return
     */
    public List<String> searchUserNames(String username, Long pid) {
        // 해당 프로젝트의 멤버 조회
        List<MemberEntity> projectMembers = memberRepository.findMembersByPid(pid);

        // 프로젝트 멤버 중 입력한 값이 들어간 이름 검색
        List<String> usernameList = new ArrayList<>();

        for (MemberEntity member : projectMembers) {
            UserEntity user = userRepository.findById(member.getUid()).orElse(null);
            if (user != null && user.getName().toLowerCase().contains(username.toLowerCase())) {
                usernameList.add(user.getName());
            }
        }

        return usernameList;
    }

    /**
     * 요구사항 삭제
     *
     * @param frid
     * @return 삭제 성공 여부
     */
    public boolean deleteRequestByFrid(Long frid) {
        try {
            requestRepository.deleteByFrid(frid);
            return true;
        } catch (Exception ex) {
            log.error("deleteRequestByFrid() error: {} ", ex.getMessage());
            return false;
        }
    }

    // 요구사항 여러개 삭제 
    public boolean deleteRequestByFrids(List<Long> frids) {
        boolean delete = false;

        for (Long frid : frids) {
            try {
                requestRepository.deleteByFrid(frid);

                delete = true;
            } catch (Exception ex) {
                log.error("deleteRequestByFrids() error: {}", ex.getMessage());
            }
        }

        return delete;  // 하나 이상의 요구사항이 삭제된 경우 true 반환
    }

    /**
     * 해당 프로젝트 아이디에 대한 모든 요구사항 전체 삭제
     *
     * @param pid
     * @return 전체 삭제 성공 여부
     */
    public boolean deleteRequestsByPid(Long pid) {
        try {
            List<RequestEntity> requestsToDelete = requestRepository.findByPid(pid);
            requestRepository.deleteAllInBatch(requestsToDelete);
            return true;
        } catch (Exception ex) {
            log.error("deleteRequestsByPid() error: {} ", ex.getMessage());
            return false;
        }
    }

    /**
     * 요구사항 엑셀 생성 (생성 후 폴더에 파일 저장)
     *
     * @param requestDTOs
     * @return 엑셀 파일 생성 성공 여부
     */
    public boolean createRequestExcel(List<RequestDTO> requestDTOs) {
        boolean status = false;

        try {
            Workbook workbook = new XSSFWorkbook();  // 엑셀 파일 생성
            Sheet sheet = workbook.createSheet("요구사항 목록");  // 시트 생성

            // 헤더 생성
            Row headerRow = sheet.createRow(0);
            String[] headers = {"요구사항ID", "요구사항명", "상세설명", "추정치", "우선순위", "개발단계", "반복대상", "담당자", "비고"};

            for (int i = 0; i < headers.length; i++) {
                Cell headerCell = headerRow.createCell(i);
                headerCell.setCellValue(headers[i]);
            }

            // 데이터 생성
            int rowNum = 1;
            for (RequestDTO requestDTO : requestDTOs) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(requestDTO.getRid());
                row.createCell(1).setCellValue(requestDTO.getName());
                row.createCell(2).setCellValue(requestDTO.getContent());
                row.createCell(3).setCellValue(requestDTO.getDate());
                row.createCell(4).setCellValue(requestDTO.getRank());
                row.createCell(5).setCellValue(requestDTO.getStage());
                row.createCell(6).setCellValue(requestDTO.getTarget());
                row.createCell(7).setCellValue(requestDTO.getUid());
                row.createCell(8).setCellValue(requestDTO.getNote());
            }

            LocalDateTime now = LocalDateTime.now();
            String fileName = "Request" + now.format(DateTimeFormatter.ofPattern("yyMMdd")) + ".xlsx";
            File file = new File(ctx.getRealPath(requestFolderPath) + File.separator + requestDTOs.get(0).getPid(), fileName);

            saveFile(workbook, file.getParentFile().getAbsolutePath(), file.getName());  // 파일 저장 
            status = true;

        } catch (IOException ex) {
            log.error("createRequestExcel() error: {} ", ex.getMessage());
        }

        return status;
    }

    // 파일 저장 
    private void saveFile(Workbook workbook, String folderPath, String fileName) throws IOException {
        File folder = new File(folderPath);

        // 파일 폴더가 존재하지 않는 경우 폴더 생성
        if (!folder.exists()) {
            folder.mkdirs();
        }

        File file = new File(folder, fileName);
        try (FileOutputStream fileOut = new FileOutputStream(file)) {
            workbook.write(fileOut);
        }
    }

    /**
     * 해당 프로젝트에 해당하는 엑셀 파일 이름 가져오는 함수
     *
     * @param pid 프로젝트 아이디
     * @return 엑셀 파일 이름 리스트
     */
    public List<String> getExcelNames(Long pid) {
        File folder = new File(ctx.getRealPath(requestFolderPath) + File.separator + pid);
        List<String> excelFileNames = new ArrayList<>();

        if (folder.exists() && folder.isDirectory()) {
            File[] files = folder.listFiles();
            if (files != null) {
                for (File file : files) {
                    if (file.isFile() && file.getName().endsWith(".xlsx")) {
                        excelFileNames.add(file.getName());
                    }
                }
            }
        }

        return excelFileNames;
    }

    /**
     * 엑셀 파일 다운
     *
     * @param filename
     * @param pid
     * @return
     */
    public ResponseEntity<Resource> downloadFile(String filename, String pid) {
        return fileService.downloadFile((requestFolderPath) + File.separator + pid, filename);
    }

    /**
     * 현재 요구사항 엑셀 파일 생성 후 다운 (폴더에 저장하지 않음)
     *
     * @param requestDTOs
     * @param response
     * @throws IOException
     */
    public void createDownRequestExcel(List<RequestDTO> requestDTOs, HttpServletResponse response) throws IOException {

        Workbook workbook = new XSSFWorkbook();  // 엑셀 파일 생성
        Sheet sheet = workbook.createSheet("요구사항 목록");  // 시트 생성

        // 헤더 생성
        Row headerRow = sheet.createRow(0);
        String[] headers = {"요구사항ID", "요구사항명", "상세설명", "추정치", "우선순위", "개발단계", "반복대상", "담당자", "비고"};

        for (int i = 0; i < headers.length; i++) {
            Cell headerCell = headerRow.createCell(i);
            headerCell.setCellValue(headers[i]);
        }

        // 데이터 생성
        int rowNum = 1;
        for (RequestDTO requestDTO : requestDTOs) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(requestDTO.getRid());
            row.createCell(1).setCellValue(requestDTO.getName());
            row.createCell(2).setCellValue(requestDTO.getContent());
            row.createCell(3).setCellValue(requestDTO.getDate());
            row.createCell(4).setCellValue(requestDTO.getRank());
            row.createCell(5).setCellValue(requestDTO.getStage());
            row.createCell(6).setCellValue(requestDTO.getTarget());
            row.createCell(7).setCellValue(requestDTO.getUid());
            row.createCell(8).setCellValue(requestDTO.getNote());
        }

        LocalDateTime now = LocalDateTime.now();
        String fileName = "Request" + now.format(DateTimeFormatter.ofPattern("yyMMdd_HHmmss")) + ".xlsx";

        // 파일 스트림 설정
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

        try (OutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
        }
    }

}
