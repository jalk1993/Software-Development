package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {

    public static String getRandomEmail() {
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 100) + "@test.com";
        return email;
    }

    public static String getRandomUserName() {
        Faker faker = new Faker();
        String userName = faker.name().username();
        return userName;
    }


    public static JSONObject getRandomArticlesValues() {
        Faker faker = new Faker();
        String title = faker.gameOfThrones().character();
        String body = faker.gameOfThrones().city();
        String description = faker.gameOfThrones().quote();
        JSONObject json = new JSONObject();
        json.put("title", title);
        json.put("body", body);
        json.put("description", description);
        return json;
    }

}