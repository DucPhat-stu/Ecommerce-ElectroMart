package com.store.electro.Models;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@JsonPropertyOrder({ "Id", "Name", "Age", "Email" })
@Entity
@Table(name = "users")
public class User {

    @Id
    @Column(name = "Id")
    private Integer Id;
    @Column(name = "Name")
    private String Name;
    @Column(name = "Age")
    private Integer Age;
    @Column(name = "Email")
    private String Email;

    public User(Integer Age, String Email, Integer Id, String Name) {
        this.Age = Age;
        this.Email = Email;
        this.Id = Id;
        this.Name = Name;
    }

    public User() {
    }

    public Integer getId() {
        return Id;
    }

    public void setId(Integer id) {
        Id = id;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public Integer getAge() {
        return Age;
    }

    public void setAge(Integer age) {
        Age = age;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    @Override
    public String toString() {
        return "User [Id=" + Id + ", Name=" + Name + ", Age=" + Age + ", Email=" + Email + ", getId()=" + getId()
                + ", getName()=" + getName() + ", getAge()=" + getAge() + ", getEmail()=" + getEmail() + ", getClass()="
                + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
    }

}
