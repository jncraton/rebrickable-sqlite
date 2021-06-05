import sqlite3

with sqlite3.connect('dist/bricks.db') as con:
    con.row_factory = sqlite3.Row
    
    cur = con.cursor()

    cur.execute(open('examples/new_parts.sql').read())

    with open('new_parts.html', 'w') as html:
        html.write('<table><thead><tr><td>Part</td><td>Year</td><td>Sets</td><td>Set Parts</td><td>Image</td></thead><tbody>')
        
        for part in cur.fetchall():
            html.write('<tr>'
                  f'<td><a href="{part["part_url"]}">{part["name"]}</a></td>'
                  f'<td>{part["year_from"]}</td>'
                  f'<td>{part["num_sets"]}</td>'
                  f'<td>{part["num_set_parts"]}</td>'
                  f'<td><img src="{part["part_img_url"]}" /></td>'
                  '</tr>'
            )

        html.write('</tbody></table>')

        