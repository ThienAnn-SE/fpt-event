/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import constant.Routers;
import dtos.GoogleDTO;
import java.io.IOException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;


/**
 *
 * @author thien
 */
public class GoogleHelpers {
    public static String getToken(final String code) throws ClientProtocolException,IOException{
    String response = Request.Post(Routers.GOOGLE_GET_TOKEN_LINK)
        .bodyForm(Form.form().add("client_id", Routers.GOOGLE_CLIENT_ID)
            .add("client_secret", Routers.GOOGLE_CLIENT_SECRET)
            .add("redirect_uri",Routers.GOOGLE_REDIRECT_URI).add("code", code)
            .add("grant_type", Routers.GOOGLE_GRANT_TYPE).build())
        .execute().returnContent().asString();
        
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"","");
        return accessToken;
    }
    
    public static GoogleDTO getUserInfo(final String accessToken) 
            throws ClientProtocolException, IOException{
        String link = Routers.GOOGLE_GET_USER_INFO_LINK + accessToken;
        String respone = Request.Get(link).execute().returnContent().asString();
        GoogleDTO googleDao = new Gson().fromJson(respone, GoogleDTO.class);
        System.out.println(googleDao.toString());
        return googleDao;
    }
}
