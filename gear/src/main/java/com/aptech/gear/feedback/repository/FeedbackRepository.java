package com.aptech.gear.feedback.repository;

import com.aptech.gear.feedback.domain.Feedback;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FeedbackRepository
        extends JpaRepository<Feedback, Long> {
}
