package utils;

import java.util.Date;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

public class Validator {

    /**
     * Validate the VietNam's phone number format
     *
     * @param phoneNumber user phone number input
     * @return error string OR empty string
     */
    public static String getPhoneNumber(String phoneNumber) {
        String pattern = "^(03|05|07|08|09|01[2|6|8|9])+([0-9]{8})\\b"; //vietnamese phone number pattern
        boolean isMatched = Pattern.matches(pattern, phoneNumber);
        if (!isMatched) {
            //the phone number is invalid
            return " is invalid phone number. Please enter again";
        }
        return "";
    }

    /**
     * Validate the email
     *
     * @param email user email input
     * @return error string OR empty string
     */
    public static String getEmail(String email) {
        Pattern regex = Pattern.compile("\\b[\\w.%-]+@[-.\\w]+\\.[A-Za-z]{2,4}\\b");

        boolean isMatched = regex.matcher(email).matches();
        if (!isMatched) {
            return " is not correct format. Please enter a valid email";
        }

        return "";
    }

    /**
     * Count number of days from start day to end day
     *
     * @param request servlet request
     * @param startDate start date
     * @param endDate end date
     * @return number of days from start day to end day
     */
    public static Integer computeNumberOfDay(HttpServletRequest request, Date startDate, Date endDate) {
        if (startDate != null && endDate != null) {

            if (startDate.after(endDate)) {
                request.setAttribute("errorMessage", "Start day must be before end day!");
                return null;
            } else {
                long diff = endDate.getTime() - startDate.getTime();
                return (int) ((diff / (1000 * 60 * 60 * 24)) + 1);
            }
        }
        return null;
    }

    /**
     *
     *
     * @param dateStartCheck start day range
     * @param dateEndCheck end day range
     * @param dateStartInput start day to be checked
     * @param dateEndInput end day to be checked
     * @return true if input date is in range or false if it not
     */
    public static boolean checkDateInRange(Date dateStartCheck, Date dateEndCheck, Date dateStartInput, Date dateEndInput) {
        if (dateStartCheck.equals(dateStartInput) || dateEndCheck.equals(dateEndInput)) {
            return false;
        }
        if (dateStartCheck.after(dateStartInput) && dateStartCheck.before(dateEndInput)) {
            return false;
        }
        if (dateEndCheck.after(dateStartInput) && dateEndCheck.before(dateEndInput)) {
            return false;
        }
        if (dateStartInput.after(dateStartCheck) && dateStartInput.before(dateEndCheck)) {
            return false;
        }
        if (dateEndInput.after(dateStartCheck) && dateEndInput.before(dateEndCheck)) {
            return false;
        }
        return true;
    }

}