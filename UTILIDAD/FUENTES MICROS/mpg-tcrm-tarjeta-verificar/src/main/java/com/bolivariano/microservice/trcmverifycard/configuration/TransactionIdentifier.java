package com.bolivariano.microservice.trcmverifycard.configuration;

import jakarta.servlet.*;
import org.apache.logging.log4j.ThreadContext;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.UUID;

@Component
public class TransactionIdentifier implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        String transactionId = UUID.randomUUID().toString().replace("-", "").substring(0, 16);
        ThreadContext.put("transactionId", transactionId);
        try {
            chain.doFilter(request, response);
        } finally {
            ThreadContext.remove("transactionId");
        }
    }
}