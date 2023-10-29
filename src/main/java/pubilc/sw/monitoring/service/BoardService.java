/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pubilc.sw.monitoring.service;

import java.io.File;
import java.time.format.DateTimeFormatter;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import pubilc.sw.monitoring.dto.BoardDTO;
import pubilc.sw.monitoring.entity.BoardEntity;
import pubilc.sw.monitoring.repository.BoardRepository;

/**
 *
 * @author qntjd
 */
@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardRepository boardRepository;
    private final FileService fileService;

    @Value("${board.folder}")
    private String boardFolderPath; // meeting안 회의록 첨부 파일 폴더 명
    @Value("${date.output.format}")
    private String dateOutputFormatter;
    @Value("${page.limit}")
    private int pageLimit;

    public Page<BoardDTO> getProjectCategoryBoards(Long pid, String category, int nowPage) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateOutputFormatter);
        Page<BoardDTO> boardDTOList;
        Page<BoardEntity> boardEntityList = boardRepository.findByPidAndCategory(pid, category, PageRequest.of(nowPage - 1, pageLimit, Sort.by(Sort.Direction.DESC, "date")));
        return boardEntityList.map(entity -> BoardDTO.builder()
                .bid(entity.getBid())
                .title(entity.getTitle())
                .writer(entity.getWriter())
                .date(entity.getDate().format(formatter))
                .category(entity.getCategory())
                .build());
    }

    public boolean addBoard(BoardDTO boardDTO, List<MultipartFile> files) {
        BoardEntity newEntity = boardRepository.save(BoardEntity.builder()
                .pid(boardDTO.getPid())
                .title(boardDTO.getTitle())
                .writer(boardDTO.getWriter())
                .content(boardDTO.getContent())
                .category(boardDTO.getCategory())
                .fileCheck(files.get(0).isEmpty() ? 0 : 1)
                .build());
        if (newEntity != null) {
            if (newEntity.getFileCheck() == 1) {
                fileService.saveFile(boardFolderPath, Long.toString(newEntity.getBid()), files);
            }
        }
        return true;
    }

    public BoardDTO getBoard(Long pid) {
        if (boardRepository.existsById(pid)) {
            BoardEntity boardEntity = boardRepository.findById(pid).get();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern(dateOutputFormatter);
            return BoardDTO.builder()
                    .bid(boardEntity.getBid())
                    .writer(boardEntity.getWriter())
                    .title(boardEntity.getTitle())
                    .content(boardEntity.getContent())
                    .date(boardEntity.getDate().format(formatter))
                    .category(boardEntity.getCategory())
                    .files(boardEntity.getFileCheck() == 1 ? fileService.searchFile(boardFolderPath, Long.toString(boardEntity.getBid())) : null)
                    .build();
        } else {
            return null;
        }
    }

    public boolean deleteBoard(Long bid) {
        if (boardRepository.existsById(bid)) {
            boardRepository.deleteById(bid);
            fileService.deleteFile(boardFolderPath, bid.toString());
            return true;
        } else {
            return false;
        }
    }

    public BoardDTO updateBoard(BoardDTO boardDTO, List<MultipartFile> files, String dellist, int fileExist) {
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern(dateOutputFormatter);
        BoardEntity oldBoard = boardRepository.findById(boardDTO.getBid()).get();
        oldBoard.setTitle(boardDTO.getTitle());
        oldBoard.setWriter(boardDTO.getWriter());
        oldBoard.setContent(boardDTO.getContent());
        oldBoard.setCategory(boardDTO.getCategory());
        oldBoard.setFileCheck(!files.get(0).isEmpty() ? 1 : fileExist);
        BoardEntity newEntity = boardRepository.save(oldBoard);
        if (newEntity != null) {
            if (!dellist.equals("")) { // 삭제할 파일이 있으면 삭제를 진행
                fileService.deleteFile(boardFolderPath, boardDTO.getBid().toString(), dellist);
            }
            if (newEntity.getFileCheck() == 1) {
                if (!files.get(0).isEmpty()) { // 새로 추가할 파일이 있다면 추가
                    fileService.saveFile(boardFolderPath, Long.toString(newEntity.getBid()), files);
                }
            }
        }

        return BoardDTO.builder()
                .bid(newEntity.getBid())
                .title(newEntity.getTitle())
                .writer(newEntity.getWriter())
                .content(newEntity.getContent())
                .files(newEntity.getFileCheck() == 1 ? fileService.searchFile(boardFolderPath, Long.toString(newEntity.getBid())) : null)
                .date(newEntity.getDate().format(outputFormatter))
                .build();
    }

    public ResponseEntity<Resource> downloadFile(String filename, String mid) {
        return fileService.downloadFile(boardFolderPath + File.separator + mid, filename);
    }
}
