resource "aws_db_instance" "db" {
    allocated_storage = 20
    engine = "mysql"
    instance_class = "db.t3.micro"

    db_name = "appdb"
    username = "admin"
    password = "Abc123+-"

    skip_final_snapshot = true
  
}