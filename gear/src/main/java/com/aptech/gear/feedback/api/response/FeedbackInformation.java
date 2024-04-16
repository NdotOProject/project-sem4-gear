package com.aptech.gear.feedback.api.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class FeedbackInformation {

    private Long id;

    private String content;

    private Double rating;

    private Boolean updated;

    private Long user;

    private Long product;
}
