package com.example.myHash;

import java.security.MessageDigest;

import org.apache.commons.codec.binary.Hex;

public class Hasher {
    static public String sha256(byte[] blockBytes) {
        try {
            byte[] hashBytes = MessageDigest.getInstance("SHA-256").digest(blockBytes);
            return Hex.encodeHexString(hashBytes);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    static public String md5(String input) {
        return hash(input, "MD5");
    }

    static public String md5(String input, byte[] salt) {
        return hash(input, salt, "MD5");
    }

    static public String sha256(String input) {
        return hash(input, "SHA-256");
    }

    static public String sha256(String input, byte[] salt) {
        return hash(input, "SHA-256");
    }

    static public String sha384(String input) {
        return hash(input, "SHA-384");
    }

    static public String sha384(String input, byte[] salt) {
        return hash(input, "SHA-384");
    }

    static public String sha512(String input) {
        return hash(input, "SHA-512");
    }

    static public String sha512(String input, byte[] salt) {
        return hash(input, "SHA-512");
    }

    // Hash Method without salt
    private static String hash(String input, String algorithm) {
        MessageDigest md;
        try {
            // Instantiate the MD object
            md = MessageDigest.getInstance(algorithm);
            // Fetch input to MD
            md.update(input.getBytes());

            // digest it
            byte[] hashBytes = md.digest();
            // convert to Hex format with Hex API from Apache common
            return String.valueOf(Hex.encodeHex(hashBytes));
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Hash Method with salt
    private static String hash(String input, byte[] salt, String algorithm) {
        MessageDigest md;
        try {
            // Instantiate the MD object
            md = MessageDigest.getInstance(algorithm);
            // fetch input to MD
            md.update(input.getBytes());
            md.update(salt);

            // Digest the MD object
            byte[] hashBytes = md.digest();
            // convert to Hex format with Hex API from Apache common
            return String.valueOf(Hex.encodeHex(hashBytes));
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
