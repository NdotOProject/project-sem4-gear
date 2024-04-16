package com.aptech.gear.feedback.service.impl;

import com.aptech.gear.feedback.domain.Feedback;
import com.aptech.gear.feedback.repository.FeedbackRepository;
import com.aptech.gear.feedback.service.FeedbackService;
import com.aptech.gear.service.impl.CrudServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class FeedbackServiceImpl
        extends CrudServiceImpl<Feedback, Long>
        implements FeedbackService {

    public FeedbackServiceImpl(FeedbackRepository repository) {
        super(repository);
    }
}
