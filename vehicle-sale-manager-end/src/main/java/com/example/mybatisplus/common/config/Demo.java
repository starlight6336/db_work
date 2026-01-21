package com.example.mybatisplus.common.config;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Scanner;

public class Demo {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("输入名单目录：");
        String namsPath = scanner.nextLine();
        System.out.println("输入作业目录：");
        String filePath = scanner.nextLine();

        // 获取名单
        List<String> names = getNames(namsPath);
        // 复制名单
        List<String> names1 = new ArrayList<>();
        names1.addAll(names);
        // 已交作业名单
        String[] doneNames = getDoneNames(filePath);

        for(String string:names){
            for(String s:doneNames){
                if(s.indexOf(string)>-1){
                    names1.remove(string);
                    break;
                }
            }
        }
        System.out.println(names1);
    }

    private static String[] getDoneNames(String filePath) {
        File file = new File(filePath);
        return file.list();
    }

    public static List<String> getNames(String namsPath){
        File file = new File(namsPath);
        List<String> names = new ArrayList<>();
        try {
            BufferedReader br = new BufferedReader(new FileReader(file));
            String s;
            while ((s=br.readLine())!=null){
                names.add(s);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return names;
    }
}
