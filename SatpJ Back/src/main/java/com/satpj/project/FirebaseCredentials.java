package com.satpj.project;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@ConfigurationProperties("firebase.credentials")
@Component
@Getter
@Setter
public class FirebaseCredentials {
    /**
     * Path al JSON que contiene las credenciales de la autenticacion
     */
    private String path = "telepsico-1e9c8-firebase-adminsdk-bm2d2-44c5fabd7f.json";
}
