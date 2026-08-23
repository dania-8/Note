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
 Database mydb=await openDatabase(path,onCreate: _onCreate,version: 1,onUpgrade: _onUpgrade);

 return mydb;


  }

_onUpgrade(Database db,int oldversion,int newvrsion){
print('onupgrate');
}


  _onCreate(Database db,int version)async{

    Batch batch=db.batch();

        batch.execute('''
          CREATE TABLE "NOTES" (
            id INTEGER PRIMARY KEY AUTOINCREMENT ,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            color TEXT, )
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
 
  

   deleteData(String sql)async{
    Database? mydb=await db;
int response= await mydb!.rawDelete(sql);
return response;
  }
}