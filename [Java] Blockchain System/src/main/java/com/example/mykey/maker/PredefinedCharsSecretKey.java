package com.example.mykey.maker;

import java.security.Key;
import java.util.Arrays;

import javax.crypto.spec.SecretKeySpec;

public class PredefinedCharsSecretKey {

    // Symmetric algorithm
    private static final String SYMM_ALGORITHM = "AES";

    // Secret Char
    private static final String SECRET_CHAR = "asdfghjkl1234567890";

    public static Key create() {
        int keySize = 16;
        return new SecretKeySpec(Arrays.copyOf(SECRET_CHAR.getBytes(), keySize), SYMM_ALGORITHM);
    }
}
