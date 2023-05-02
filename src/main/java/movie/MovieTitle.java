package movie;

import java.net.*;
import java.io.*;
import org.json.*;

public class MovieTitle {

	public MovieTitle() {
        URL url;
		try {
			url = new URL("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.xml"
					+ "key=" + "a6dc63ca63c3e126d8e08b123741bd5f");
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
	        con.setRequestMethod("GET");
	        
	        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	        String response = in.readLine();
	        in.close();
	        
	        JSONTokener tokener = new JSONTokener(response);
	        JSONObject json = new JSONObject(tokener);
	        String title = json.getString("movieNM");
	        
	        System.out.println("Movie title: " + title);
	        
		} catch (IOException e) {
			e.printStackTrace();
		}
        
        
        
        
	}
	
    public static void main(String[] args) throws Exception {
        MovieTitle movieTitle = new MovieTitle();
    }
}