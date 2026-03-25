// MYSQL CRUD

#define NOMINMAX
#include <iostream>
#include <mysql.h>
#include <windows.h>
#include <clocale>
#include <string>
#include <limits>
using namespace std;

void print_Menu()
{
	cout << "============================================\n";
	cout << "            MySQL CRUD 예제\n";
	cout << "============================================\n";
	cout << "1. 조회\n";
	cout << "2.  추가\n";
	cout << "3.  수정\n";
	cout << "4.  삭제\n";
	cout << "5.  종료\n";
	cout << "    선택 > ";

}

void clearInput()
{
	cin.clear();
	cin.ignore(numeric_limits<streamsize>::max(), '\n');
}

//MYSQL 접속
MYSQL* connectDB() {
	MYSQL* conn = mysql_init(NULL); //초기화 할때 인자 필요

	if (conn == NULL)
	{
		cerr << "MySQL 초기화 실패" << endl;
		return NULL; // 함수 탈출
 	}
	// 접속 시도
	conn = mysql_real_connect(
		conn,
		"127.0.0.1",
		"madang",
		"madang",
		"madangdb",
		3306,
		NULL,
		0

	);

	if (conn == NULL)
	{
		cerr << "MySQL 접속 실패" << mysql_error(conn) << endl;
		return NULL;
 	}
	// MySQL 서버 문자 셋 생략
	return conn;
}



//seelct  조회 함수
void selectBook(MYSQL* conn) {
	const char* query = "SELECT bookid, bookname, publisher, price FROM Book";

	// 쿼리 실행
	if (mysql_query(conn, query) != 0) {
		cerr << "SELECT 에러 : " << mysql_error(conn) << endl;
		return;
	}

	// 결과 저장
	MYSQL_RES* result = mysql_store_result(conn);
	if (result == NULL) {
		cerr << "Result 에러 : " << mysql_error(conn) << endl;
		return;
	}
	MYSQL_ROW row;

	// 출력 헤더
	cout << "\n========================================\n";
	cout << "             도서 정보\n";
	cout << "========================================\n";
	cout << "bookid\tbookname\tpublisher\tprice\n";
	cout << "========================================\n";
	
	// 조회에만 아래 로직
	while ((row = mysql_fetch_row(result)) != NULL) {
		cout << row[0] << '\t' << row[1] << '\t'
			<< row[2] << '\t' << (row[3] ? row[3] : "0") << '\n';
	}

	cout << '\n';
	mysql_free_result(result);
}

void insertBook(MYSQL* conn) {
	string bookid; // PK Autoincrement면 필요없음
	string bookname;
	string publisher;
	string price;

	clearInput();

	cout << "\nbookid > ";
	getline(cin, bookid);

	cout << "bookname > ";
	getline(cin, bookname);

	cout << "publisher > ";
	getline(cin, publisher);

	cout << "price > ";
	getline(cin,price);

	// bookid, price, int형 to_string()으로 형변환
	string query = "INSERT INTO Book VALUES (" 
		+ bookid + ", '" 
		+ bookname + "', '" 
		+ publisher + "', " 
		+ price + ")";
	
	if (mysql_query(conn, query.c_str()) != 0)
	{
		cerr << "INSERT 에러: " << mysql_error(conn) << endl;
		return;
	}
	cout << mysql_affected_rows(conn) << "건 INSERT 완료\n\n";
}

//update 실행 함수

void updateBook(MYSQL* conn)
{
	string bookid;
	string bookname;
	string publisher;
	string price;
	clearInput();

	cout << "\nbookid > ";
	getline(cin, bookid);

	cout << "bookname > ";
	getline(cin, bookname);

	cout << "publisher > ";
	getline(cin, publisher);

	cout << "price > ";
	getline(cin, price);

	string query = "UPDATE Book SET bookname = '"
		+ bookname
		+ "', publisher = '"
		+ publisher
		+ "', price = " + price
		+ " WHERE bookid  =  "
		+ bookid;

	if (mysql_query(conn, query.c_str()) != 0)
	{
		cerr << "update 에러: " << mysql_error(conn) << endl;
		return;
	}
	uint64_t count = mysql_affected_rows(conn); 
	
	if (count == 0)
	{
		cout << "해당 bookid가 없습니다.\n\n";
	}
	else {
		cout << count << "건 update 완료" << endl;
	}
}

void deleteBook(MYSQL* conn)
{

	string bookid;

	clearInput();
	cout << "\nbookid > ";
	getline(cin, bookid);

	string query = "DELETE FROM Book WHERE bookid = " + bookid;
	if (mysql_query(conn, query.c_str()) != 0)
	{

		cerr << "DELETE 에러: " << mysql_error(conn) << endl;
		return;
		uint64_t count = mysql_affected_rows(conn);

		if (count == 0)
		{
			cout << "해당 bookid가 없습니다.\n\n";
		}
		else {
			cout << count << "건 update 완료" << endl;
		}
	}
}


int main(void)

{
	// 콘솔 utf-8설정
	SetConsoleOutputCP(CP_UTF8);
	SetConsoleCP(CP_UTF8);;
	setlocale(LC_ALL, "UTF8");

	MYSQL* conn = connectDB();

	if (conn == NULL)
	{
		return 1;
	}

	cout << "MySQL 연결 성공\n";

	while (true)
	{
		int menu = 0;
		print_Menu();
		cin >> menu;
		// 숫자 이외에 잘못된 입력
		if (cin.fail())
		{
			cout << "메뉴는 숫자로 입력\n\n";
			clearInput();
			continue; // 여기 빠져 나간다는 의미
		}
		switch (menu)
		{
		case 1:
			//cout << "조회 실행" << endl;
			selectBook(conn);
			break; // select

		case 2:
			insertBook(conn);
			break; // insert

		case 3:
			//cout << "수정 실행" << endl;
			updateBook(conn);
			break; // update

		case 4:
			//cout << "삭제 실행" << endl;
			deleteBook(conn);
			break; // delete

		case 5:  // 프로그램 종료
			cout << "프로그램 종료" << endl;
			mysql_close(conn);
			return 0;


		default:
			cout << "잘못된 메뉴\n\n";
			break;
		}
	}
	// 연결 종료
	mysql_close(conn);
	return 0;
}