package com.example.myBlockchain;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.LinkedList;

import com.google.gson.GsonBuilder;

public class Blockchain {
    private static LinkedList<Block> db = new LinkedList<>();

    private static Blockchain _instance;

    private String ledgerFile;
    private String chainFile;

    private Blockchain(String chainFile) {
        super();
        this.chainFile = chainFile + ".bin";
        this.ledgerFile = "myledger.txt";

        System.out.println(this.chainFile);
        System.out.println(this.ledgerFile);

    }

    public static Blockchain getInstance(String chainFile) {
        if (_instance == null)
            _instance = new Blockchain(chainFile);
        return _instance;
    }

    public void genesis() {
        Block genesis = new Block("0");
        db.add(genesis);
        persist();
        distribute();
    }

    // Next Block Method
    public void nextBlock(Block newBlock) {
        // Create Merkle Root
        MerkleTree mt = MerkleTree.getInstance(newBlock.getTranx().getTranxLst());
        mt.build();
        String merkleRoot = mt.getRoot();
        newBlock.getTranx().setMerkleRoot(merkleRoot);

        db = get();
        newBlock.getHeader().setIndex(db.getLast().getHeader().getIndex() + 1);
        db.add(newBlock);
        persist();
    }

    public LinkedList<Block> get() {
        try (
                FileInputStream fin = new FileInputStream(this.chainFile);
                ObjectInputStream in = new ObjectInputStream(fin);) {
            return (LinkedList<Block>) in.readObject();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private void persist() {
        try (
                FileOutputStream fout = new FileOutputStream(this.chainFile);
                ObjectOutputStream out = new ObjectOutputStream(fout);) {
            out.writeObject(db);
            System.out.println(">> Master file updated!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void distribute() {
        // Convert the chain to String using API
        String chain = new GsonBuilder().setPrettyPrinting().create().toJson(db);
        System.out.println(chain);
        try {
            Files.write(
                    Paths.get(this.ledgerFile), // targeted file
                    chain.getBytes(), // content
                    StandardOpenOption.CREATE // file mode
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
