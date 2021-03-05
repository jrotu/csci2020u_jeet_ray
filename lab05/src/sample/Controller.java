package sample;

import javafx.fxml.FXML;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

public class Controller {
    @FXML
    private TableView tableView;
    @FXML
    private TableColumn studentID;
    @FXML
    private TableColumn assignments;
    @FXML
    private TableColumn midterm;
    @FXML
    private TableColumn finalExam;
    @FXML
    private TableColumn finalMark;
    @FXML
    private TableColumn letterGrade;

    private TableView<StudentRecord> students;

    @FXML
    public void initialize() {
        studentID.setCellValueFactory(new PropertyValueFactory<>("studentID"));
        assignments.setCellValueFactory(new PropertyValueFactory<>("assignments"));
        midterm.setCellValueFactory(new PropertyValueFactory<>("midterm"));
        finalExam.setCellValueFactory(new PropertyValueFactory<>("finalExam"));
        finalMark.setCellValueFactory(new PropertyValueFactory<>("finalMark"));
        letterGrade.setCellValueFactory(new PropertyValueFactory<>("letterGrade"));
        tableView.setItems(DataSource.getAllMarks());
    }
}
