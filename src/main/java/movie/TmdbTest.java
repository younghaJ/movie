package movie;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

public class TmdbTest {
    public static void main(String[] args) {
        try {
            // TMDb API 엔드포인트 URL
            String endpoint = "https://api.themoviedb.org/3/discover/movie?api_key=YOUR_API_KEY&watch_region=KR&language=ko&sort_by=popularity.desc";
            // TMDb API에서 발급받은 API 키를 입력합니다.
            String apiKey = "e9f48626c4f86f70cc4a49e2602b639c";
            // URL 생성
            URL url = new URL(endpoint.replace("YOUR_API_KEY", apiKey));
            // HTTP 연결 생성
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            // 응답 데이터 읽기
            BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            // JSON 파싱
            JSONObject json = new JSONObject(sb.toString());
            JSONArray results = json.getJSONArray("results");
            // 결과 출력
            for (int i = 0; i < results.length(); i++) {
                JSONObject movie = results.getJSONObject(i);
                System.out.println("Title: " + movie.getString("title"));
                System.out.println("Release Date: " + movie.getString("release_date"));
                System.out.println("Overview: " + movie.getString("overview"));
                System.out.println("---------------------------");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
