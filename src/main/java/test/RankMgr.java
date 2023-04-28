package test;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


public class RankMgr {
	private DBConnectionMgr pool;
	
	
	public RankMgr() {
		pool = DBConnectionMgr.getInstance();		
	}
	public List<MovieBean> rankingMovie(){
		String posterUrl = "https://image.tmdb.org/t/p/w500";
		String poster="";
		List<MovieBean> vlist = new ArrayList<MovieBean>();
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1); // 오늘 날짜에서 -1을 뺀다.
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd"); // 날짜 포맷을 지정한다.
		String day = dateFormat.format(cal.getTime()); // 포맷에 맞게 문자열로 변환한다.
	    
		String url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt="+day; // HTTP 요청할 URL
		  try {
			  URL obj = new URL(url);
		    	HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		    	con.setRequestMethod("GET");
		    	
		    	while(con.getResponseCode() == 200) {
		    		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		            String inputLine;
		            StringBuilder res = new StringBuilder();
		             while ((inputLine = in.readLine()) != null) {
		                res.append(inputLine);
		            	}
		            in.close();
		            
		            JSONParser parser = new JSONParser();
		            JSONObject json = (JSONObject) parser.parse(res.toString());		            
		            JSONArray dailyBoxOfficeList = (JSONArray) ((JSONObject)json.get("boxOfficeResult")).get("dailyBoxOfficeList");
		            // 필요한 데이터 추출
		            for(int i =0; i<dailyBoxOfficeList.size();i++) {
		            	JSONObject movieData = (JSONObject) dailyBoxOfficeList.get(i);
		            	MovieBean bean = new MovieBean(); 
		            	String movieNm = (String) movieData.get("movieNm");
		            	 poster = getImg(movieNm);
		            	 bean.setTitle(movieNm);
		            	 bean.setPoster(poster);
		            	 vlist.add(bean);
		            }
		    		}
		    	}catch (Exception e) {
				
			}
		return vlist;
	}
	//포스터 src받는 함수
	public String getImg(String movieNm)  {
		
		String moviename = movieNm;
		String apiKey = "31c1c74c73134061b245226b9f27511d";
		String posterUrl = "https://image.tmdb.org/t/p/w500";

		moviename = moviename.replaceAll(" ", "%20");
		String poster="";
		String url="https://api.themoviedb.org/3/search/movie?api_key="
				+apiKey+"&&language=ko-KR&query="+moviename;
		URL obj;

	    try {
	    	obj = new URL(url);
	    	HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	    	con.setRequestMethod("GET");
	    	
	    	while(con.getResponseCode() == 200) {
	    		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            String inputLine;
	            StringBuilder res = new StringBuilder();
	             while ((inputLine = in.readLine()) != null) {
	                res.append(inputLine);
	            	}
	            in.close();
	            
	            JSONParser parser = new JSONParser();
	            JSONObject json = (JSONObject) parser.parse(res.toString());
	            
	            JSONArray dailyBoxOfficeList =  (JSONArray)json.get("results");
	            
	            // 필요한 데이터 추출
	                JSONObject movieData = (JSONObject) dailyBoxOfficeList.get(0);
	                if(movieData.get("poster_path")==null) {
	                	poster = "img/no_image.jpg";
	                }else {
	                poster = posterUrl + (String) movieData.get("poster_path");
	                }
	           
	    		}
	    	}catch (Exception e) {
			
		}
	    if(poster.equals("")&&poster.length()==0) {
        	poster = "img/no_image.jpg";
        }
	    return poster;
	}
	//해당 영화의 장르 가져오는 함수
	public String getGenres(String movieNm) {
		String moviename = movieNm;
		String apiKey = "31c1c74c73134061b245226b9f27511d";
		String posterUrl = "https://image.tmdb.org/t/p/w500";

		moviename = moviename.replaceAll(" ", "%20");
		String genre="";
		String url="https://api.themoviedb.org/3/search/movie?api_key="
				+apiKey+"&&language=ko-KR&query="+moviename;
		URL obj;

	    try {
	    	obj = new URL(url);
	    	HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	    	con.setRequestMethod("GET");
	    	
	    	while(con.getResponseCode() == 200) {
	    		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            String inputLine;
	            StringBuilder res = new StringBuilder();
	             while ((inputLine = in.readLine()) != null) {
	                res.append(inputLine);
	            	}
	            in.close();
	            
	            JSONParser parser = new JSONParser();
	            JSONObject json = (JSONObject) parser.parse(res.toString());
	            
	            JSONArray dailyBoxOfficeList =  (JSONArray)json.get("results");
	            
	            // 필요한 데이터 추출
	                JSONObject movieData = (JSONObject) dailyBoxOfficeList.get(0);
	                JSONArray arrayId = (JSONArray) movieData.get("genre_ids");
	                for(int i=0; i<arrayId.size(); i++) {
	                	String genreId = arrayId.get(i).toString();
	                	genre = genre + Genres(genreId);
	                	if(i != arrayId.size()-1) {
	                		genre = genre + ",";
	                	}
	                }

	    		}
	    	}catch (Exception e) {
			
		}
	    return genre;
	}
	//장르 데이터 
	public String Genres(String genreId) {
		String genres="";
		String apiKey = "31c1c74c73134061b245226b9f27511d";
		String url="https://api.themoviedb.org/3/genre/movie/list?api_key="
		+apiKey+"&language=ko-KR";
		String id = ""; //장르 번호
		String name="" ; //장르 이름 
		Map<String, String> map = new HashMap<String, String>();
		URL obj;
		try {
	    	obj = new URL(url);
	    	HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	    	con.setRequestMethod("GET");
	    	
	    	while(con.getResponseCode() == 200) {
	    		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            String inputLine;
	            StringBuilder res = new StringBuilder();
	            while ((inputLine = in.readLine()) != null) {
	                res.append(inputLine);
	            	}
	            in.close();
	            
	            JSONParser parser = new JSONParser();
	            JSONObject json = (JSONObject) parser.parse(res.toString());
	            
	          JSONArray genreList =  (JSONArray)json.get("genres");
	            
	            // 필요한 데이터 추출
	            for(int i=0;i<genreList.size();i++) {
	            	
	            	JSONObject movieData = (JSONObject) genreList.get(i);
	            	id =  movieData.get("id").toString();
	            	name =  (String) movieData.get("name");
	            	map.put(id, name);

	            }
	              
	                genres = map.get(genreId);
	                if(genres==null) {
	                	genres="장르가 없습니다.";
	                }
	    		}
	    	}catch (Exception e) {
			
		}
		
		return genres;
	}
	public String getActor(String id) {
		String actor = "";
		String url="https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd="
				+ id;
		
		URL obj;
		try {
	    	obj = new URL(url);
	    	HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	    	con.setRequestMethod("GET");
	    	
	    	while(con.getResponseCode() == 200) {
	    		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            String inputLine;
	            StringBuilder res = new StringBuilder();
	             while ((inputLine = in.readLine()) != null) {
	                res.append(inputLine);
	            	}
	            in.close();
	            
	            JSONParser parser = new JSONParser();
	            JSONObject json = (JSONObject) parser.parse(res.toString());
	            
	           JSONObject movinfo =  (JSONObject)((JSONObject)json.get("movieInfoResult")).get("movieInfo");
	            JSONArray actorList = (JSONArray)movinfo.get("actors");
	            // 필요한 데이터 추출
	            if(actorList.size()!=0) {
	            	
	            	for(int i=0;i<actorList.size();i++) {
	            		JSONObject movieData = (JSONObject) actorList.get(i);
	            		actor = actor + (String)movieData.get("peopleNm");
	            		if(i!=actorList.size()-1 && i<2) {
	            			actor = actor + ",";
	            		}
	            		else  {
	            			break;
	            		}
	            	}
	            }
	            else {
	                	actor="";
	                }
	           
	    		}
	    	}catch (Exception e) {
			
		}
		return actor;
	}
	//db에서 해당 장르 영화 가져오기
	public List<MovieBean> getMovie(String genre){
		String posterUrl = "https://image.tmdb.org/t/p/w500";
		List<MovieBean> movieList = new ArrayList<MovieBean>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "select title, poster from movie "
					+ " where genre like ? LIMIT 7 ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,"%"+ genre + "%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieBean bean = new MovieBean();
				//bean.setMovieidx(rs.getInt("movieidx"));
				bean.setTitle(rs.getString("title"));
				String poster = posterUrl + rs.getString("poster");
				bean.setPoster(poster);
				movieList.add(bean);
			}

		} catch (Exception e) {
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return movieList;
	}
	//넷플릭스 탑 10 영화
	public List<String> getNetflixTop(){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1); // 오늘 날짜에서 -1을 뺀다.
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
		String day = dateFormat.format(cal.getTime());
		List<String> list = new ArrayList<String>();
		try {
			Document doc = Jsoup.connect("https://flixpatrol.com/top10/netflix/south-korea/"+day+"/").get();
			Elements elem = doc.getElementsByClass("tabular-nums");
			Elements file = elem.select("tr");

			  int cnt=0;
				for(Element e : file){
					if(cnt==10) {
						break;
					}
					list.add(e.select(".table-td a").text());
		        	cnt++;
				}
			
			}catch (Exception e) {
			}
		return list;
	}
	public List<String> getDisneyTop(){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1); // 오늘 날짜에서 -1을 뺀다.
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
		String day = dateFormat.format(cal.getTime());
		List<String> list = new ArrayList<String>();
		try {
			Document doc = Jsoup.connect("https://flixpatrol.com/top10/disney/south-korea/"+day+"/").get();
			Elements elem = doc.getElementsByClass("tabular-nums");
			Elements file = elem.select("tr");

			  int cnt=0;
				for(Element e : file){
					if(cnt==10) {
						break;
					}
					list.add(e.select(".table-td a").text());
		        	cnt++;
				}
			
			}catch (Exception e) {
			}
		return list;
	}
	//ott 영화 탑 10 이름과 포스터
	public MovieBean getOttTop(String ottList){
		MovieBean bean = new MovieBean();

		String moviename = ottList;
		String apiKey = "31c1c74c73134061b245226b9f27511d";
		String posterUrl = "https://image.tmdb.org/t/p/w500";
		String title = "";
		moviename = moviename.replaceAll(" ", "%20");
		String poster="";
		String url="https://api.themoviedb.org/3/search/movie?api_key="
				+apiKey+"&&language=ko-KR&query="+moviename;
		URL obj;

	    try {
	    	obj = new URL(url);
	    	HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	    	con.setRequestMethod("GET");
	    	
	    	while(con.getResponseCode() == 200) {
	    		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            String inputLine;
	            StringBuilder res = new StringBuilder();
	             while ((inputLine = in.readLine()) != null) {
	                res.append(inputLine);
	            	}
	            in.close();
	            
	            JSONParser parser = new JSONParser();
	            JSONObject json = (JSONObject) parser.parse(res.toString());
	            
	            JSONArray dailyBoxOfficeList =  (JSONArray)json.get("results");
	            
	            // 필요한 데이터 추출
	            for(int i=0; i<dailyBoxOfficeList.size();i++) {
	               JSONObject movieData = (JSONObject) dailyBoxOfficeList.get(i);
	               if(ottList.indexOf("’")!=-1) {
	                	title = (String) movieData.get("title");
               		bean.setTitle(title);
               		 poster = posterUrl + (String) movieData.get("poster_path");
               		bean.setPoster(poster);
               		 break;
	                } 
	               else if("ko".equals((String) movieData.get("original_language"))!=true) {
	                	if(ottList.equals(movieData.get("original_title"))) {
	                		title = (String) movieData.get("title");
	                		bean.setTitle(title);
	                		 poster = posterUrl + (String) movieData.get("poster_path");
	                		bean.setPoster(poster);
	                		 break;
	                	}
	                }
	                else {
	                	title = (String) movieData.get("title");
                		bean.setTitle(title);
                		 poster = posterUrl + (String) movieData.get("poster_path");
                		bean.setPoster(poster);
                		break;
	                }
	                }
	           
	    		}
	    	}catch (Exception e) {
			
		}
	    if(poster.equals("https://image.tmdb.org/t/p/w500null")) {
        	poster = "img/no_image.jpg";
        	bean.setPoster(poster);
        }
		return bean;
	}
}