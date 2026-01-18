import sys
import sqlite3

if len(sys.argv) != 3:
    print("Usage: gen_html.py {SQL script} {out.html}")

# Read supplied SQL script
query = open(sys.argv[1]).read()

with sqlite3.connect("dist/bricks.db") as con:
    con.row_factory = sqlite3.Row

    cur = con.cursor()

    cur.execute(query)

    with open(sys.argv[2], "w") as html:
        needs_headers = True
        for i, part in enumerate(cur.fetchall()):
            if needs_headers:
                headers = "</th><th>".join(part.keys())
                html.write(f"<table><thead><tr><th>Row</th><th>{headers}</th></thead><tbody>")
                needs_headers = False

            html.write(f"<tr><td>{i}</td>")
            for key in part.keys():
                if "https" in str(part[key]):
                    html.write(f'<td><a href="{part[key]}">{part[key]}</a></td>')
                else:
                    html.write(f"<td>{part[key]}</td>")
            html.write("</tr>")

        html.write("</tbody></table>")
