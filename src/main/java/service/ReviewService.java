package service;

import dao.ReviewDAO;

public class ReviewService {
    ReviewDAO dao = new ReviewDAO();

    public int addReview(String pid, String uid, String rating, String comment, String img) {
        int newReviewId = dao.saveReview(pid, uid, rating, comment);

        if (newReviewId != -1) {
            boolean isSave = dao.saveReviewImages(newReviewId, img);
            boolean isUpdateAvg = dao.updateProductAvgRating(pid);

            if (isSave && isUpdateAvg) {
                return newReviewId;
            }
        }
        return -1;
    }
}