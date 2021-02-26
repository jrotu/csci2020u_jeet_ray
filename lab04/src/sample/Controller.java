package sample;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.DatePicker;
import javafx.scene.control.TextField;
import javafx.util.StringConverter;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.text.MessageFormat;

public class Controller {
    @FXML
    private TextField userNameField;
    @FXML
    private TextField passwordField;
    @FXML
    private TextField fullNameField;
    @FXML
    private TextField emailField;
    @FXML
    private TextField phoneNumberField;
    @FXML
    private DatePicker datePicker;
    @FXML
    private Button registerBtn;

    private DateTimeFormatter dateTimeFormatter;

    @FXML
    public void initialize() {
        System.out.println("App is running...");

        final String datePattern = "M/dd/yyyy";
        dateTimeFormatter = DateTimeFormatter.ofPattern(datePattern);
        datePicker.setConverter(new StringConverter<LocalDate>() {
            @Override
            public String toString(LocalDate date) {
                String finalDate = null;
                if (date != null)
                    finalDate = dateTimeFormatter.format(date);
                return finalDate;
            }

            @Override
            public LocalDate fromString(String string) {
                LocalDate date = null;
                if (string != null)
                    date = LocalDate.parse(string, dateTimeFormatter);
                return date;
            }
        });
    }

    @FXML
    public void btnOnPress(ActionEvent event) {
        if (userNameField.getText().length() > 0 &&
                passwordField.getText().length() > 0 &&
                fullNameField.getText().length() > 0 &&
                emailField.getText().length() > 0 &&
                phoneNumberField.getText().length() > 0) {
            System.out.println(MessageFormat.format("Username: {0}", userNameField.getText()));
            System.out.println(MessageFormat.format("Password: {0}", passwordField.getText()));
            System.out.println(MessageFormat.format("Full Name: {0}", fullNameField.getText()));
            System.out.println(MessageFormat.format("E-Mail: {0}", emailField.getText()));
            System.out.println(MessageFormat.format("Phone #: {0}", phoneNumberField.getText()));
            System.out.println(datePicker.getEditor().getText());
        }
    }
}
