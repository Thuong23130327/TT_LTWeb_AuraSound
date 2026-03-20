package model.entity;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.sql.Timestamp;

public class Banner {
	private int id;

	private String imageUrl;

	private String targetUrl;

	private String title;
	private String description;

	private int sortOrder;

	private boolean isActive;

	private Timestamp createdAt;

//    Getter - setter
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getTargetUrl() {
		return targetUrl;
	}

	public void setTargetUrl(String targetUrl) {
		this.targetUrl = targetUrl;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	@Override
	public String toString() {
		return "Banner [ id=" + id + ", imageUrl=" + imageUrl + ", targetUrl=" + targetUrl + ", title=" + title
				+ ", description=" + description + ", sortOrder=" + sortOrder + ", isActive=" + isActive
				+ ", createdAt=" + createdAt + " ]\n";
	}

}
