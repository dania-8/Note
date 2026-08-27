import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
static Database? _db;
Future<Database?>get db async{
  if(_db==null){
     _db =await intialDb();
     return _db;
     }
     else{
      return _db;
     }
}


  intialDb() async{
String dbpath =await getDatabasesPath();
 String path=join(dbpath,'letter.db');
 Database mydb=await openDatabase(path,onCreate: _onCreate,version: 3,onUpgrade: _onUpgrade,onConfigure: _onConfigure);

 return mydb;


  }

_onUpgrade(Database db,int oldversion,int newvrsion){
print('onupgrate');
}

Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  _onCreate(Database db,int version)async{

    Batch batch=db.batch();
 batch.execute('''
          CREATE TABLE "PROFILE" (
            "profileid" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
            "profilename" TEXT NOT NULL,
            "profileemail" TEXT NOT NULL,
            "password" TEXT NOT NULL,
            "gender" TEXT NOT NULL,
            "age" INTEGER NOT NULL,
            "image" TEXT
          )
        ''');
        batch.execute('''
          CREATE TABLE "NOTES" (
            id INTEGER PRIMARY KEY AUTOINCREMENT ,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            color TEXT,
            profileid INTEGER,
CONSTRAINT fkprofile
    FOREIGN KEY (profileid)
    REFERENCES PROFILE(profileid)
       ON DELETE CASCADE 
             )
        ''');

    print('creat database');

       await batch.commit();
        print('creat database');


  }
read(String table )async{
  Database? mydb=await db;
  List<Map> response= await mydb!.query(table);
return response;
 }
 
  
 insert(String table ,Map<String, Object?>values)async{
  Database? mydb=await db;
  int response= await mydb!.insert(table,values);
return response;
 }

update(String table ,Map<String, Object?>values,mywhere)async{
  Database? mydb=await db;
  int response= await mydb!.update(table,values,where: mywhere);
return response;
 }
 
  delete(String table ,mywhere)async{
  Database? mydb=await db;
  int response= await mydb!.delete(table , where: mywhere);
return response;
 }
 
  getNotesProfile(String table,mywhere )async{
  Database? mydb=await db;
  List<Map> response= await mydb!.query(table,where: mywhere);
return response;
  }

   
  
}