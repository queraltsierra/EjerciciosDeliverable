#include <stdio.h>
#include <libpq-fe.h>

int main() {
    PGconn *conn = PQconnectdb("user=youruser dbname=yourdb password=yourpassword");

    if (PQstatus(conn) == CONNECTION_BAD) {
        printf("Connection to database failed.\n");
        return 1;
    }

    PGresult *res = PQexec(conn, "SELECT username, match_finish_time, duration FROM player "
                                 "JOIN match_player ON player.player_id = match_player.player_id "
                                 "JOIN match ON match_player.match_id = match.match_id;");

    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        printf("Query failed.\n");
        PQclear(res);
        PQfinish(conn);
        return 1;
    }

    int rows = PQntuples(res);
    for (int i = 0; i < rows; i++) {
        printf("Player: %s, Finish Time: %s, Duration: %s minutes\n", 
               PQgetvalue(res, i, 0), PQgetvalue(res, i, 1), PQgetvalue(res, i, 2));
    }

    PQclear(res);
    PQfinish(conn);
    return 0;
}
