package com.example.personal.models;

import java.util.Date;
import java.util.Random;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="cards")
public class Card {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	private String number;
	
	private String expDate;
	
	@NotNull
	private Integer red;
	
	@NotNull
	private Integer green;
	
	@NotNull
	private Integer blue;

	@NotNull(message="Please pick a color for the text!")
	private String textColor;

	@Min(value = 0)
	@Max(value = 100)
	private double alpha;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	private User user;
	
	@Column(updatable=false)
	@DateTimeFormat(pattern="dd/MM/yyyy")
	private Date createdAt;
	
	@DateTimeFormat(pattern="dd/MM/yyyy")
	private Date updatedAt;
	
	

	public Card(String text, Integer red, Integer green, Integer blue, double alpha, String textColor) {
		this.red = red;
		this.alpha = alpha;
		this.green = green;
		this.blue = blue;
		this.textColor = textColor;
		
	}

	public Card() {

	}

	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public void setNumber(String number) {
		this.number = number;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public void setNumAndDate() {
		this.number = generateNumber();
		this.expDate = new Date().toString().substring(4, 7) + "/" + (Integer.parseInt(new Date().toString().substring(new Date().toString().length() - 4, new Date().toString().length())) + 6);
	}
	
	
	public String generateNumber() {
		Random r = new Random();
		String temp = String.format("%04d", Integer.valueOf(r.nextInt(9999)));
        String newNum = new String();
		int counter = 0;
		for (int i = 0; i < 16; i++) {
			if (i % 4 == 0) {
			    temp = String.format("%04d", Integer.valueOf(r.nextInt(9999)));
			    counter=0;
				newNum += " " + temp.charAt(counter);
			} else {
				newNum += temp.charAt(counter);
			}
			counter++;
		}
		return newNum;
	}
	
	public String getTextColor() {
		return textColor;
	}

	public void setTextColor(String textColor) {
		this.textColor = textColor;
	}

	public String getNumber() {
		return this.number;
	}

	public String getExpDate() {
		return expDate;
	}
	public Integer getRed() {
		return red;
	}

	public void setRed(Integer red) {
		this.red = red;
	}

	public Integer getGreen() {
		return green;
	}

	public void setGreen(Integer green) {
		this.green = green;
	}

	public Integer getBlue() {
		return blue;
	}

	public void setBlue(Integer blue) {
		this.blue = blue;
	}

	public double getAlpha() {
		return alpha;
	}

	public void setAlpha(double transparency) {
		this.alpha = transparency;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Date getUpdatedAt() {
		return updatedAt;
	}
		
	public Date getCreatedAt() {
		return createdAt;
	}
	
	@PrePersist
	protected void onCreate() {
		setNumAndDate();
		this.createdAt = new Date();
	}

	@PreUpdate
	protected void OnUpdate() {
		this.updatedAt = new Date();
	}

}
