package test;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;

import org.json.JSONArray;
import org.json.JSONObject;

public class db {
	public static final String SAVEFOLDER = "C:/Jsp/movie/src/main/webapp/poster/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;
	private DBConnectionMgr pool;
	
	public db() {
		pool = DBConnectionMgr.getInstance();
	}
	
    public void main(String[] args) {
        //load();
    }
    
    public String load(int page) {
    	Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		String endpoint = "https://api.themoviedb.org/3/discover/movie?"
        		+ "api_key=e9f48626c4f86f70cc4a49e2602b639c&language=ko&region=KR"
        		+ "&sort_by=popularity.desc&include_adult=false&include_video=false&page=" + page
        		+ "&year=2022&with_watch_monetization_types=flatrate";
		
    	try {
            
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
                JSONArray genre = movie.getJSONArray("genre_ids");
                String genrecode = "";
                for (int j = 0; j < genre.length(); j++) {
                    int genreId = genre.getInt(j);
                    
                    //System.out.println("장르 : " + genreId);
                    if(j==genre.length()-1)
                    	genrecode += genre(genreId);
                    else
                    	genrecode += genre(genreId) + ",";
                }
                String movieCd = koMoviekey(title);
                
                MovieBean bean = searchetc(movieCd);
                String playtime = bean.getPlaytime();
                String director = bean.getDirector();
                String actors = bean.getActor();
                
                System.out.println("Title: " + title);
                System.out.println("Release Date: " + releaseDate);
                System.out.println("Overview: " + overview);
                System.out.println("Poster Path: " + posterPath);
                System.out.println("장르 : " + genrecode);
                System.out.println("playtime : " + playtime);
                System.out.println("movieCd=" + movieCd);
                System.out.println("Director : " + director);
                System.out.println("배우들 : " + actors);
                System.out.println("---------------------------");
                // 이미지 파일 저장
                con = pool.getConnection();
    			sql = "INSERT movie(TITLE, CONTENT, POSTER, GENRE, DIRECTOR, ACTOR, PLAYTIME, AGE, TRAILER, WATCHOTT, MAKER)"
                + "VALUES(?,?,?,?,?,?,?,'a','a','a','a')";
                
    			pstmt = con.prepareStatement(sql);
    			pstmt.setString(1, title);
    			pstmt.setString(2, overview);
    			pstmt.setString(3, posterPath);
    			pstmt.setString(4, genrecode);
    			pstmt.setString(5, director);
    			pstmt.setString(6, actors);
    			pstmt.setString(7, playtime);
    			pstmt.executeUpdate();
    			
                //saveImage(posterPath);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
			pool.freeConnection(con, pstmt);
		}
		return endpoint;
    }
    
    // 장르 코드 받아서 장르 문자로 반환
    // TMDB
    public String genre(int genreId) throws IOException {
    	String genre = "";
    	String genreurl = "https://api.themoviedb.org/3/genre/movie/list?"
    			+ "api_key=e9f48626c4f86f70cc4a49e2602b639c&language=ko&id=12";
    	URL url;
		try {
			url = new URL(genreurl);
			
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        
	        BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        StringBuilder sb = new StringBuilder();
	        String line;
	        
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        
	        JSONObject json = new JSONObject(sb.toString());
	        JSONArray results = json.getJSONArray("genres");
	        
	        for (int i = 0; i < results.length(); i++) {
	        	JSONObject genres = results.getJSONObject(i);
				int id = genres.getInt("id");
				if(id==genreId) {
					genre = genres.getString("name");
				}
			}
	        
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
        
    	return genre;
    }
    
    // TMDB에서 영화 이름을 받아 영화진흥위원회 movieCd를 찾는다
    public String koMoviekey(String title) {
    	String movieCd = "";
    	String title1 = title.replace(" ", "%20");
    	String ko_url = "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?"
    			+ "key=f5eef3421c602c6cb7ea224104795888&movieNm="+title1;
    	URL url;
		try {
			url = new URL(ko_url);
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
	        JSONObject movieListResult = json.getJSONObject("movieListResult");
	        JSONArray movieList = movieListResult.getJSONArray("movieList");
	        movieCd = movieList.getJSONObject(0).getString("movieCd");
	        
		} catch (Exception e) {
			e.printStackTrace();
		}
        
    	return movieCd;
    }
    
    // 영화 감독, 배우 등 기타 정보
    // 영화진흥위원회
    public MovieBean searchetc(String movieCd) {
    	MovieBean bean = new MovieBean();
    	String uri = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?"
    			+ "key=f5eef3421c602c6cb7ea224104795888&movieCd=" + movieCd;
    	
		try {
			URL url = new URL(uri);
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
	        JSONObject movieInfoResult = json.getJSONObject("movieInfoResult");
	        JSONObject movieInfo = movieInfoResult.getJSONObject("movieInfo");
	        bean.setPlaytime(movieInfo.getString("showTm"));
	        
	        String director_str = "";
	        JSONArray directors = movieInfo.getJSONArray("directors");
	        for (int i = 0; i < directors.length(); i++) {
	            if (director_str.length() > 0) {
	                director_str += ",";
	            }
	            director_str += directors.getJSONObject(i).getString("peopleNm");
	        }
	        bean.setDirector(director_str);
	        
	        String actor_str = "";
	        JSONArray actors = movieInfo.getJSONArray("actors");
	        for (int i = 0; i < actors.length(); i++) {
	            if (actor_str.length() > 0) {
	            	actor_str += ",";
	            }
	            actor_str += actors.getJSONObject(i).getString("peopleNm");
	        }
	        bean.setActor(actor_str);
	        
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return bean;
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
