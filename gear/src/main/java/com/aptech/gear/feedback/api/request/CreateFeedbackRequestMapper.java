package com.aptech.gear.feedback.api.request;

import com.aptech.gear.feedback.domain.Feedback;
import com.aptech.gear.util.Mapper;

import java.util.function.Supplier;

public class CreateFeedbackRequestMapper
        extends Mapper<Feedback, CreateFeedbackRequest> {

    protected CreateFeedbackRequestMapper() {
        super(Feedback.class, CreateFeedbackRequest::new);
    }
}
