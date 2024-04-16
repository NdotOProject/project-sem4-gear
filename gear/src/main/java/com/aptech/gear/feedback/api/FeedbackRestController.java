package com.aptech.gear.feedback.api;

import com.aptech.gear.feedback.api.request.CreateFeedbackRequest;
import com.aptech.gear.feedback.api.response.FeedbackInformation;
import com.aptech.gear.feedback.service.FeedbackService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@AllArgsConstructor
public class FeedbackRestController {


    private static final String ENDPOINT_CREATE = "/v1/feedback";

    private final FeedbackService service;

    private static final Map<Long, FeedbackInformation> cached
            = Collections.synchronizedMap(new LinkedHashMap<>());

    @PostMapping(ENDPOINT_CREATE)
    public void create(
            @RequestParam(required = false) String returnTo,
            @RequestBody CreateFeedbackRequest request) {


    }
}
