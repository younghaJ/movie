package movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MovieGradeMgr {

	private DBConnectionMgr pool;
	
	public MovieGradeMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	private void insertGrade(int movieidx, boolean flag) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			if(flag == true) {
				sql = "INSERT INTO moviegrade\r\n"
						+ "(movieidx, movielike, moviedislike)\r\n"
						+ "VALUES(?, 1, 0);";
			} else {
				sql = "INSERT INTO moviegrade\r\n"
						+ "(movieidx, movielike, moviedislike)\r\n"
						+ "VALUES(?, 0, 1);";
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieidx);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	private boolean checkGrade(int movieidx) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from moviegrade where movieidx = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieidx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	private void updateGrade(int movieidx, boolean btncheck, boolean flag) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			if(flag == true) {	// 좋아요 버튼
				if(btncheck == false) {	// 버튼 눌림 유무, 안눌림
					if(checkGrade(movieidx) == true) {	// db에 저장된 값인지 아닌지, 저장된 경우
						sql = "UPDATE moviegrade\r\n"
								+ "SET movielike=movielike+1\r\n"
								+ "WHERE movieidx=?";
					}else {
						insertGrade(movieidx, true);
					}
				} else {	// 버튼 눌림
					sql = "UPDATE moviegrade\r\n"
							+ "SET movielike=movielike-1\r\n"
							+ "WHERE movieidx=?";
				}
			} else {	// 싫어요 버튼
				if(btncheck == false) {	// 버튼 눌림 유무, 안눌림
					if(checkGrade(movieidx) == true) {	// db에 저장된 값인지 아닌지, 저장된 경우
						sql = "UPDATE moviegrade\r\n"
								+ "SET moviedislike=moviedislike+1\r\n"
								+ "WHERE movieidx=?";
					}else {
						insertGrade(movieidx, true);
					}
				} else {	// 버튼 눌림
					sql = "UPDATE moviegrade\r\n"
							+ "SET moviedislike=moviedislike-1\r\n"
							+ "WHERE movieidx=?";
				}
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, movieidx);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
