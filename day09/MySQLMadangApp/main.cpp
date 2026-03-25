// MySQLMadangApp.cpp : 이 파일에는 'main' 함수가 포함됩니다. 거기서 프로그램 실행이 시작되고 종료됩니다.
//

#include <iostream>
#include <mysql.h>
#include <windows.h> // 콘솔 처리
#include <clocale> // 국가 언어 관련

using namespace std;
int main()
{
    // 콘소를 UTF-8로 설정
    SetConsoleOutputCP(CP_UTF8);
    SetConsoleCP(CP_UTF8);
    setlocale(LC_ALL, ".UTF8");
    // 필요 변수 선언
    MYSQL Conn; // DB연결을 위한 구좇[
    MYSQL* ConnPtr = NULL; // 연결 이후 사용할 포인터 변수
    MYSQL_RES* Result = NULL;
    MYSQL_ROW Row; // 한행을 담는 변수

    int Stat; // 상태값
    // 클라이언트 정보 확인

   cout << mysql_get_client_info() << "\n";
    //MYSQL 초기화
   mysql_init(&Conn); // 연결 객체를 초기화
   ConnPtr = mysql_real_connect(&Conn,"127.0.0.1","madang","madang","madangdb",3306,NULL,0); 
   // 위 코드로 mysql 서버에 접속 시도
   // 접속이 실패하면
   if (ConnPtr == NULL)
   {
       cerr << "MySQL 연결 실패: " << mysql_error(&Conn) << '\n';
       return 1;
   }
   cout << "MySQL 연결 성공" << '\n';

   // madangDB의 Book 테이블 select 

   //MySQL 서버쪽 문자셋 UTF-8로 설정
   if (mysql_set_character_set(ConnPtr, "utf8mb4") != 0)
   {
       cerr << "MySQL 연결 실패: " << mysql_error(ConnPtr) << '\n';
       mysql_close(ConnPtr); // 접속 종료
       return 1; // mysql에서 utf-8로 설정 되어 있기 때문에 작동 안한다.
   }


   const char* Query = "SELECT bookid, bookname, publisher, price "
                      "   FROM Book"; // 공백 중요!!
   Stat = mysql_query(ConnPtr, Query);

   // 쿼리가 오류 나면 Stat이 0이외 값이 들어감
   if (Stat != 0)
   {
       cerr << "MySQL 연결 실패: " << mysql_error(ConnPtr) << '\n';
       mysql_close(ConnPtr); // 접속 종료
       return 1;
   }
   // Result SELECT문 결과를 메모리로 가져 오는 작업

   Result = mysql_store_result(ConnPtr);

   if (Result == NULL)
   {
       cerr << "MySQL 연결 실패: " << mysql_error(ConnPtr) << '\n';
       mysql_close(ConnPtr); // 접속 종료
       return 1;
   }

   cout << "MYSQL 쿼리 성공" << '\n';
   // 커서중 Fetch만 사용해서 데이터 로드
   // Row[0] - bookid, Row[1] - bookname, Row[2] - publisher, Row[3] - price
   while ( ( Row = mysql_fetch_row(Result) ) != NULL ) {
       cout << Row[0] <<", " << (Row[1] ? Row[1] : "NULL") <<", "<< Row[2] <<", "<< (Row[3] ? Row[3]:"NULL") << endl;
   }
   mysql_free_result(Result); // 포인터 메모리 해제
   
   mysql_close(ConnPtr); // 서버 연결 끊기
   cout << "MySQL 연결 종료!!" << '\n';
}


