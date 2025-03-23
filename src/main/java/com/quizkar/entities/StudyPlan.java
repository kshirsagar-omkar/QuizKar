package com.quizkar.entities;

public class StudyPlan {
	
	//@Id
	private Integer studyPlanId;
	
	//@Columns
	private String name;
	private String status;
	private String createdAt; //date
	private Integer createdBy; // Reference com.quizkar.entities -> Users.userId
	private String link;
	
	
	
	
	
	
	
	
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public Integer getStudyPlanId() {
		return studyPlanId;
	}
	public void setStudyPlanId(Integer studyPlanId) {
		this.studyPlanId = studyPlanId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public Integer getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}
	
	
}
