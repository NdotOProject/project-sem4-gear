package com.aptech.gear.feedback.api.request;

import com.aptech.gear.util.FieldMapping;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class CreateFeedbackRequest {
    private Long user;

    private Long product;

    @FieldMapping(reverse = true)
    private String content;

    @FieldMapping(reverse = true)
    private Double rating;
}
