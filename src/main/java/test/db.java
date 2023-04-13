package test;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;

import org.json.JSONArray;
import org.json.JSONObject;

public class db {
	public static final String SAVEFOLDER = "C:/Jsp/movie/src/main/webapp/poster/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;
	private static DBConnectionMgr pool;
	
	public db() {
		pool = DBConnectionMgr.getInstance();
	}
	
    public static void main(String[] args) {
        load();
    }
    
    public static void load() {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
    	try {
            // TMDb API 엔드포인트 URL
            String endpoint = "https://api.themoviedb.org/3/discover/movie?"
            		+ "api_key=e9f48626c4f86f70cc4a49e2602b639c&language=ko&region=KR"
            		+ "&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&year=2022&with_watch_monetization_types=flatrate";
            // TMDb API에서 발급받은 API 키를 입력합니다.
            //String apiKey = "e9f48626c4f86f70cc4a49e2602b639c";
            // URL 생성
            //URL url = new URL(endpoint.replace("YOUR_API_KEY", apiKey));
            URL url = new URL(endpoint);
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
            con = pool.getConnection();
            for (int i = 0; i < results.length(); i++) {
                JSONObject movie = results.getJSONObject(i);
                String title = movie.getString("title");
                String posterPath = movie.getString("poster_path");
                String overview = movie.getString("overview");
                String releaseDate = movie.getString("release_date");
                System.out.println("Title: " + title);
                System.out.println("Release Date: " + releaseDate);
                System.out.println("Overview: " + overview);
                System.out.println("Poster Path: " + posterPath);
                System.out.println("---------------------------");
                // 이미지 파일 저장
                con = pool.getConnection();
    			sql = "insert movie(movieidx, title, content, poster) values(?,?,?,?)";
    			pstmt = con.prepareStatement(sql);
    			pstmt.setInt(1, i);
    			pstmt.setString(2, title);
    			pstmt.setString(3, overview);
    			pstmt.setString(4, posterPath);
    			pstmt.executeUpdate();
    			
                saveImage(posterPath);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
			pool.freeConnection(con, pstmt);
		}
    }
    public static void saveImage(String posterPath) {
        try {
        	
            // TMDb API 이미지 URL
            String imageUrl = "https://image.tmdb.org/t/p/w500" + posterPath;
            // URL 생성
            URL url = new URL(imageUrl);
            // HTTP 연결 생성
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            // 응답 데이터 읽기
            InputStream in = conn.getInputStream();
            // 파일 저장
            String fileName = posterPath.substring(1);
            FileOutputStream out = new FileOutputStream("C:/Jsp/movie/src/main/webapp/poster/" + fileName);
            byte[] buffer = new byte[1024];
            int bytesRead = -1;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
            out.close();
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
