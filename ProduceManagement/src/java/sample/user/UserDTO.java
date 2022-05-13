/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.user;

import java.util.Date;

/**
 *
 * @author giama
 */
public class UserDTO {
    private String userID;
    private String fullName;
    private String roleID;
    private String password;
    private String address;
    private Date   birthday;
    private String phone;
    private String email;
    

    public UserDTO() {
        this.userID = "";
        this.fullName = "";
        this.roleID = "";
        this.password = "";
        this.address = "";
        this.birthday = null;
        this.phone = "";
        this.email = "";
    }

    public UserDTO(String userID, String fullName, String roleID, String email) {
        this.userID = userID;
        this.fullName = fullName;
        this.roleID = roleID;
        this.email = email;
    }

    public UserDTO(String userID, String fullName, String roleID, String password, String address, Date birthday, String phone, String email) {
        this.userID = userID;
        this.fullName = fullName;
        this.roleID = roleID;
        this.password = password;
        this.address = address;
        this.birthday = birthday;
        this.phone = phone;
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUserID() {
        return userID;
    }

    public String getFullName() {
        return fullName;
    }

    public String getRoleID() {
        return roleID;
    }

    public String getPassword() {
        return password;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
}
