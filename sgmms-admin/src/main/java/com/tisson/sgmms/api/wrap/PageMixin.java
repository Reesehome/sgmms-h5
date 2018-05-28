package com.tisson.sgmms.api.wrap;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(value = {"first", "last", "sort"})
@JsonAutoDetect(fieldVisibility = JsonAutoDetect.Visibility.NONE)
public interface PageMixin<T> {

    @JsonProperty("page")
    int getNumber();

    @JsonProperty("page_size")
    int getSize();

    @JsonIgnore
    int getNumberOfElements();
}
