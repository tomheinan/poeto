//
//  Database.swift
//  Klavaro
//
//  Created by Tom Heinan on 2023-12-28.
//

import Foundation

struct Lexicon {
    
    static let databaseFilename = "poeto.db"
    
    private static let columns = ["word", "hint_en"]
    private static let limit = 3
    
    static func search(word: String) -> [Item] {
        guard let db = try? openDatabase() else { return [] }
        defer { closeDatabase(database: db) }
        
        let queryString = "SELECT \(columns.joined(separator: ", ")) FROM words WHERE word LIKE \"\(word)%\" LIMIT \(limit)"
        var candidateWords: [Item] = []
        
        guard let statement = try? openStatement(dbPointer: db, queryString: queryString) else { return [] }
        defer { closeStatement(statement: statement) }
            
        while SQLiteStatusCode(rawValue: sqlite3_step(statement)) == .row {
            if let queryResultCol0 = sqlite3_column_text(statement, 0) {
                let candidateWord = String(cString: queryResultCol0)
                var hintEnglish: String?
                if let queryResultCol1 = sqlite3_column_text(statement, 1) {
                    hintEnglish = String(cString: queryResultCol1)
                }
                
                let item = Item(word: (word.isCapitalized ? candidateWord.capitalized : candidateWord), hintEnglish: hintEnglish)
                candidateWords.append(item)
            }
        }
        
        return candidateWords
    }
    
    static func wordCount() -> Int {
        guard let db = try? openDatabase() else { return 0 }
        defer { closeDatabase(database: db) }
        
        let queryString = "SELECT COUNT(word) FROM words"
        guard let statement = try? openStatement(dbPointer: db, queryString: queryString) else { return 0 }
        defer { closeStatement(statement: statement) }
        
        if SQLiteStatusCode(rawValue: sqlite3_step(statement)) == .row {
            let queryResultCol0 = sqlite3_column_int(statement, 0)
            return Int(queryResultCol0)
        }
        
        return 0
    }
    
    static func setup() {
        guard let resPath = Bundle.main.resourcePath, let bundleContents = try? FileManager.default.contentsOfDirectory(atPath: resPath) else { return }
        
        let filteredFiles = bundleContents.filter{ $0.contains(databaseFilename) }
        for fileName in filteredFiles {
            let sourceURL = Bundle.main.bundleURL.appending(component: fileName)
            let destURL = Constants.AppGroup.sharedFolderURL.appending(component: fileName)
            do {
                try? FileManager.default.removeItem(at: destURL)
                try FileManager.default.copyItem(at: sourceURL, to: destURL)
            } catch {
                print("Unable to copy database from application bundle to app group directory")
            }
        }
    }
    
    typealias QueryStatement = OpaquePointer
    
    private static func openStatement(dbPointer: OpaquePointer, queryString: String) throws -> QueryStatement {
        var queryStatement: QueryStatement?
        let statusCode = SQLiteStatusCode(rawValue: sqlite3_prepare_v2(dbPointer, queryString, -1, &queryStatement, nil))
        if statusCode == .ok, let queryStatement = queryStatement {
            return queryStatement
        } else {
            if let statusCode = statusCode {
                throw statusCode
            } else {
                throw SQLiteStatusCode.error
            }
        }
    }
    
    private static func closeStatement(statement: QueryStatement) {
        sqlite3_finalize(statement)
    }
    
    typealias Database = OpaquePointer
    
    private static func openDatabase() throws -> Database {
        var db: Database?
        
        let statusCode = SQLiteStatusCode(rawValue: sqlite3_open(Constants.AppGroup.sharedDBPath, &db))
        if statusCode == .ok, let db = db {
            return db
        } else {
            if let statusCode = statusCode {
                throw statusCode
            } else {
                throw SQLiteStatusCode.error
            }
        }
    }
    
    private static func closeDatabase(database: Database) {
        sqlite3_close(database)
    }
    
}

extension Lexicon {
    
    struct Item: Equatable {
        let word: String
        let hintEnglish: String?
        
        init(word: String, hintEnglish: String? = nil) {
            self.word = word
            self.hintEnglish = hintEnglish
        }
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.word == rhs.word
        }
    }
    
}

extension Lexicon {
    
    enum SQLiteStatusCode: CInt, Error {
        case ok  = 0
        case error = 1   /* Generic error */
        case `internal` = 2   /* Internal logic error in SQLite */
        case perm = 3   /* Access permission denied */
        case abort = 4   /* Callback routine requested an abort */
        case busy = 5   /* The database file is locked */
        case locked = 6   /* A table in the database is locked */
        case nomem = 7   /* A malloc() failed */
        case readonly = 8   /* Attempt to write a readonly database */
        case interrupt = 9   /* Operation terminated by sqlite3_interrupt()*/
        case ioerr = 10   /* Some kind of disk I/O error occurred */
        case corrupt = 11   /* The database disk image is malformed */
        case notfound = 12   /* Unknown opcode in sqlite3_file_control() */
        case full = 13   /* Insertion failed because database is full */
        case cantopen = 14   /* Unable to open the database file */
        case `protocol` = 15   /* Database lock protocol error */
        case empty = 16 /* Internal use only */
        case schema = 17   /* The database schema changed */
        case toobig = 18   /* String or BLOB exceeds size limit */
        case constraint = 19   /* Abort due to constraint violation */
        case mismatch = 20   /* Data type mismatch */
        case misuse = 21   /* Library used incorrectly */
        case nolfs = 22   /* Uses OS features not supported on host */
        case auth = 23   /* Authorization denied */
        case format = 24   /* Not used */
        case range = 25   /* 2nd parameter to sqlite3_bind out of range */
        case notadb = 26   /* File opened that is not a database file */
        case notice = 27   /* Notifications from sqlite3_log() */
        case warning = 28   /* Warnings from sqlite3_log() */
        case row = 100  /* sqlite3_step() has another row ready */
        case done = 101  /* sqlite3_step() has finished executing */
    }
    
}
