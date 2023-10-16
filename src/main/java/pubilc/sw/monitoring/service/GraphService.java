/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import javax.servlet.ServletContext;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import pubilc.sw.monitoring.entity.ProjectEntity;
import pubilc.sw.monitoring.repository.MemberRepository;
import pubilc.sw.monitoring.repository.ProjectRepository;

/**
 *
 * @author parkchaebin
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class GraphService {

    private final MemberRepository memberRepository;
    private final ProjectRepository projectRepository;

    @Value("${request.folder}")
    private String requestFolderPath;

    @Autowired
    private ServletContext ctx;

    // 전체 요구사항 그래프 데이터 
    // 날짜, all, 총 요구사항 수, 완료 요구사항 수, 반복 요구사항 수, 총 추정치, 완료 추정치, 반복 추정치
    public List<Object[]> getData(Long pid) {
        String directoryPath = ctx.getRealPath(requestFolderPath) + File.separator + pid;
        String fileNamePattern = "Request\\d{6}\\.xlsx";  // 파일 이름 패턴 

        File directory = new File(directoryPath);
        List<Object[]> data = new ArrayList<>();

        if (directory.exists() && directory.isDirectory()) {
            File[] files = directory.listFiles((dir, name) -> name.matches(fileNamePattern));  // 디렉토리 내에 해당 패턴을 가진 파일 목록

            if (files != null) {
                // 파일을 날짜 순으로 정렬
                Arrays.sort(files, (file1, file2) -> {
                    String dateStr1 = file1.getName().replaceAll("[^0-9]", "");
                    String dateStr2 = file2.getName().replaceAll("[^0-9]", "");
                    return dateStr1.compareTo(dateStr2);
                });

                for (File file : files) {
                    try {
                        String fileName = file.getName();
                        String dateStr = fileName.replaceAll("[^0-9]", "");
                        int dateValue = Integer.parseInt(dateStr);

                        FileInputStream fis = new FileInputStream(file);
                        Workbook workbook = new XSSFWorkbook(fis);
                        Sheet sheet = workbook.getSheetAt(0);

                        Object[] allData = new Object[8];
                        Arrays.fill(allData, 0);
                        
                        for (Row row : sheet) {
                            Cell cell3 = row.getCell(3);
                            if (cell3 != null && cell3.getCellType() == CellType.NUMERIC) {
                                int estimatedValue = (int) cell3.getNumericCellValue();
                                if (estimatedValue != -1) {  // 추정치 -1인 경우 제외하고 계산 
                            
                                    allData[2] = (int) allData[2] + 1;  // 총 요구사항 수 

                                    Cell cell5 = row.getCell(5);
                                    if (cell5 != null && cell5.getCellType() == CellType.STRING && cell5.getStringCellValue().equals("완료")) {
                                        allData[3] = (int) allData[3] + 1;  // 완료 요구사항 수 

                                        if (cell3 != null && cell3.getCellType() == CellType.NUMERIC) {
                                            allData[6] = (int) allData[6] + (int) cell3.getNumericCellValue();  // 완료 추정치 
                                        }
                                    }

                                    Cell cell6 = row.getCell(6);
                                    if (cell6 != null && cell6.getCellType() == CellType.STRING && cell6.getStringCellValue().equals("true")) {
                                        allData[4] = (int) allData[4] + 1;  // 반복 요구사항 수 

                                        if (cell3 != null && cell3.getCellType() == CellType.NUMERIC) {
                                            allData[7] = (int) allData[7] + (int) cell3.getNumericCellValue();  // 반복 추정치 
                                        }
                                    }

                                    if (cell3 != null && cell3.getCellType() == CellType.NUMERIC) {
                                        allData[5] = (int) allData[5] + (int) cell3.getNumericCellValue();  // 총 추정치 
                                    }
                                }
                            }
                        }

                        allData[0] = dateValue;  // 날짜 
                        allData[1] = "all";
                        data.add(allData);

                        fis.close();

                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                log.error("파일이 없습니다.");
            }
        } else {
            log.error("디렉토리가 존재하지 않습니다.");
        }

        return data;
    }

    
    // 멤버 요구사항 그래프 데이터 
    // 날짜, 담당자, 총 요구사항 수, 완료 요구사항 수, 반복 요구사항 수, 총 추정치, 완료 추정치, 반복 추정치
    public List<Object[]> getMemberData(Long pid) {
        List<Object[]> data = new ArrayList<>();

        String directoryPath = ctx.getRealPath(requestFolderPath) + File.separator + pid;
        String fileNamePattern = "Request\\d{6}\\.xlsx";  // 파일 이름 패턴 설정

        File directory = new File(directoryPath);

        if (directory.exists() && directory.isDirectory()) {
            File[] files = directory.listFiles((dir, name) -> name.matches(fileNamePattern));  // 디렉토리 내에 해당 패턴을 가진 파일 목록

            if (files != null) {
                // 파일을 날짜 순으로 정렬
                Arrays.sort(files, (file1, file2) -> {
                    String dateStr1 = file1.getName().replaceAll("[^0-9]", "");
                    String dateStr2 = file2.getName().replaceAll("[^0-9]", "");
                    return dateStr1.compareTo(dateStr2);
                });

                for (File file : files) {
                    try {
                        String fileName = file.getName();
                        String dateStr = fileName.replaceAll("[^0-9]", "");
                        int dateValue = Integer.parseInt(dateStr);

                        FileInputStream fis = new FileInputStream(file);
                        Workbook workbook = new XSSFWorkbook(fis);
                        Sheet sheet = workbook.getSheetAt(0);

                        // 엑셀의 7번째열에서 담당자 데이터 추출 
                        List<String> uidList = new ArrayList<>();
                        boolean firstRowSkipped = false; 
                        for (Row row : sheet) {
                            if (!firstRowSkipped) {
                                firstRowSkipped = true;
                                continue; // 첫 번째 행 값은 넣지않음 
                            }
                            Cell cell7 = row.getCell(7);
                            if (cell7 != null && cell7.getCellType() == CellType.STRING) {
                                String uid = cell7.getStringCellValue();
                                uidList.add(uid);
                            }
                        }
                        uidList = uidList.stream().distinct().collect(Collectors.toList());  // 중복 제거

                        for (String uid : uidList) {
                            // 각 멤버별로 데이터를 저장하기 위한 배열 초기화
                            Object[] memberData = new Object[8];
                            Arrays.fill(memberData, 0);

                            for (Row row : sheet) {
                                Cell cell3 = row.getCell(3);
                                if (cell3 != null && cell3.getCellType() == CellType.NUMERIC) {
                                    int estimatedValue = (int) cell3.getNumericCellValue();
                                     if (estimatedValue != -1) {  // 추정치 -1인 경우 제외하고 계산 
                                         
                                        Cell cell7 = row.getCell(7);
                                        if (cell7 != null && cell7.getCellType() == CellType.STRING && cell7.getStringCellValue().equals(uid)) {
                                            memberData[2] = (int) memberData[2] + 1;  // 총 요구사항 수 

                                            Cell cell5 = row.getCell(5);
                                            if (cell5 != null && cell5.getCellType() == CellType.STRING && cell5.getStringCellValue().equals("완료")) {
                                                memberData[3] = (int) memberData[3] + 1;  // 완료 요구사항 수 

                                                if (cell3 != null && cell3.getCellType() == CellType.NUMERIC) {
                                                    memberData[6] = (int) memberData[6] + (int) cell3.getNumericCellValue();  // 완료 추정치 
                                                }
                                            }

                                            Cell cell6 = row.getCell(6);
                                            if (cell6 != null && cell6.getCellType() == CellType.STRING && cell6.getStringCellValue().equals("true")) {
                                                memberData[4] = (int) memberData[4] + 1;  // 반복 요구사항 수 

                                                if (cell3 != null && cell3.getCellType() == CellType.NUMERIC) {
                                                    memberData[7] = (int) memberData[7] + (int) cell3.getNumericCellValue();  // 반복 추정치 
                                                }
                                            }

                                            if (cell3 != null && cell3.getCellType() == CellType.NUMERIC) {
                                                memberData[5] = (int) memberData[5] + (int) cell3.getNumericCellValue();  // 총 추정치 
                                            }
                                        }
                                    }
                                }
                            }

                            memberData[0] = dateValue;  // 날짜
                            memberData[1] = uid;  // 멤버 아이디
                            data.add(memberData);
                        }

                        fis.close();

                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                } 
            } else {
                log.error("파일이 없습니다.");
            }
        } else {
            log.error("디렉토리가 존재하지 않습니다.");
        }

        return data;
    }

    
    // 번다운 그래프 데이터 
    // 날짜, 담당자, 총 추정치, 남은 추정치(총 추정치-완료 추정치)
    public List<Object[]> burnMemberData(Long pid) {
        List<Object[]> data = new ArrayList<>();

        String directoryPath = ctx.getRealPath(requestFolderPath) + File.separator + pid;
        String fileNamePattern = "Request\\d{6}\\.xlsx";  // 파일 이름 패턴 설정

        File directory = new File(directoryPath);

        if (directory.exists() && directory.isDirectory()) {
            File[] files = directory.listFiles((dir, name) -> name.matches(fileNamePattern));  // 디렉토리 내에 해당 패턴을 가진 파일 목록

            if (files != null) {
                // 파일을 날짜 순으로 정렬
                Arrays.sort(files, (file1, file2) -> {
                    String dateStr1 = file1.getName().replaceAll("[^0-9]", "");
                    String dateStr2 = file2.getName().replaceAll("[^0-9]", "");
                    return dateStr1.compareTo(dateStr2);
                });

                for (File file : files) {
                    try {
                        String fileName = file.getName();
                        String dateStr = fileName.replaceAll("[^0-9]", "");
                        int dateValue = Integer.parseInt(dateStr);

                        FileInputStream fis = new FileInputStream(file);
                        Workbook workbook = new XSSFWorkbook(fis);
                        Sheet sheet = workbook.getSheetAt(0);

                        // 엑셀의 7번째열에서 담당자 데이터 추출 
                        List<String> uidList = new ArrayList<>();
                        boolean firstRowSkipped = false; 
                        for (Row row : sheet) {
                            if (!firstRowSkipped) {
                                firstRowSkipped = true;
                                continue; // 첫 번째 행 값은 넣지않음 
                            }
                            Cell cell7 = row.getCell(7);
                            if (cell7 != null && cell7.getCellType() == CellType.STRING) {
                                String uid = cell7.getStringCellValue();
                                uidList.add(uid);
                            }
                        }
                        uidList.add("all"); // "all" 아이디 추가
                        uidList = uidList.stream().distinct().collect(Collectors.toList());  // 중복 제거

                        for (String uid : uidList) {
                            Object[] memberData = new Object[4];
                            Arrays.fill(memberData, 0);

                            for (Row row : sheet) {
                                Cell cell7 = row.getCell(7);
                                if (cell7 != null && cell7.getCellType() == CellType.STRING && (cell7.getStringCellValue().equals(uid) || uid.equals("all"))) {
                                    Cell cell3 = row.getCell(3);
                                    if (cell3 != null && cell3.getCellType() == CellType.NUMERIC) {
                                        int date = (int) cell3.getNumericCellValue();
                                        if (date != -1) {  // 추정치 -1인 경우 제외하고 계산 
                                            memberData[2] = (int) memberData[2] + date;  // 총 추정치 

                                            Cell cell5 = row.getCell(5);
                                            if (cell5 != null && cell5.getCellType() == CellType.STRING && cell5.getStringCellValue().equals("완료")) {
                                                memberData[3] = (int) memberData[3] + date;  // 완료 추정치 
                                            }
                                        }
                                    }
                                }
                            }

                            // memberData[3]에 totalDate - finishDate 값 설정
                            memberData[3] = (int) memberData[2] - (int) memberData[3];  // 남은 추정치 

                            memberData[0] = dateValue;  // 날짜
                            memberData[1] = uid;  // 멤버 아이디

                            data.add(memberData);
                        }

                        fis.close();

                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                log.error("파일이 없습니다.");
            }
        } else {
            log.error("디렉토리가 존재하지 않습니다.");
        }

        return data;
    }

    
    // 프로젝트 기간 
    public int[] getProjectDate(Long pid) {
        Optional<ProjectEntity> project = projectRepository.findById(pid);
        Date start = project.get().getStart();
        Date end = project.get().getEnd();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMdd");
        int startDate = Integer.parseInt(dateFormat.format(start));  // 시작날짜 
        int endDate = Integer.parseInt(dateFormat.format(end));  // 마감날짜 

        int[] result = {startDate, endDate};

        return result;
    }

}
