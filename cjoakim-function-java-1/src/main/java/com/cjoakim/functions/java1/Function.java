package com.cjoakim.functions.java1;

import java.util.*;

import com.microsoft.azure.functions.annotation.*;
import com.microsoft.azure.functions.*;

import com.fasterxml.jackson.databind.ObjectMapper;

import com.github.javafaker.*;  // <-- generates random Address values

/**
 * Sample Azure Function with a HTTP Trigger, using a 3rd party Maven Central jar.
 * Generates a random Address, or parts thereof, given a 'type' HTTP parameter.
 * See https://docs.microsoft.com/en-us/java/api/com.microsoft.azure.functions?view=azure-java-stable
 * Chris Joakim, Microsoft, 2019/11/08
 */
public class Function {

    @FunctionName("HttpTrigger-Java")
    public HttpResponseMessage run(
            @HttpTrigger(
                name = "req",
                methods = {HttpMethod.GET, HttpMethod.POST},
                authLevel = AuthorizationLevel.FUNCTION) HttpRequestMessage<Optional<String>> request,
            final ExecutionContext context) {
        context.getLogger().info("Java HTTP trigger processed a request.");

        // Just an example of including and using a Maven Central jar in a Function
        Faker faker = new Faker();

        // Parse query parameter
        String query  = request.getQueryParameters().get("type");
        String type   = ("" + request.getBody().orElse(query)).toLowerCase();
        Map<String, String> data = new HashMap<String, String>();
        data.put("type", type);
        data.put("result", "");

        switch (type) {
            case "city":
                data.put("result", faker.address().city());
                break; 
            case "number":
                data.put("result", faker.address().buildingNumber());
                break; 
            case "street":
                data.put("result", faker.address().streetName());
                break; 
            case "country":
                data.put("result", faker.address().country());
                break;
            case "address":
                StringBuffer sb = new StringBuffer();
                sb.append(faker.address().buildingNumber() + " ");
                sb.append(faker.address().streetName() + ", ");
                sb.append(faker.address().city() + ", ");
                sb.append(faker.address().country());
                data.put("result",  sb.toString());
                break;
            default :
        }
        data.put("version", "2019/11/08 11:08 EST");

        if (data.get("result").length() < 1) {
            data.put("error", "please pass a 'type' on the query string or in the request body");
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST)
                .body(createJsonBody(data))
                .header("Content-Type", "application/json")
                .build();
        }
        else {
            return request.createResponseBuilder(HttpStatus.OK)
                .body(createJsonBody(data))
                .header("Content-Type", "application/json")
                .build();
        }
    }

    private String createJsonBody(Map<String, String> data) {

        try {
            ObjectMapper mapper = new ObjectMapper();
            return mapper.writeValueAsString(data);
        }
        catch (Exception e) {
            System.err.println(e.toString());
            return "{}";
        }
    }
}
