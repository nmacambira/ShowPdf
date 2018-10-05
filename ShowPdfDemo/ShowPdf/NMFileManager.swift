//
//  NMFileManager.swift
//  NMFileManager
//
//  Created by Natalia Macambira on 23/09/17.
//  Copyright © 2017 Natalia Macambira. All rights reserved.
//

import Foundation

class NMFileManager {
    
    // MARK: - Save file from Bundle on disk
    
    /// Save file from app's folder on disk
    ///
    /// - Parameter name: File's name string
    static func saveFile(_ fileName: String) {
        let nameArray = fileName.components(separatedBy: ".")
        if let bundleFileUrl = Bundle.main.url(forResource: nameArray[0], withExtension: nameArray[1]) {
            
            if let documentDirectoryFileUrl = getFileLocation(fileName) {
                if !FileManager.default.fileExists(atPath: documentDirectoryFileUrl.path) {
                    do {
                        try FileManager.default.copyItem(at: bundleFileUrl, to: documentDirectoryFileUrl)
                        print("Copy file succcess: ", fileName)
                        print("File location: \(documentDirectoryFileUrl.path)")
                    } catch (let error) {
                        print("Could not copy file to disk: \(error.localizedDescription)")
                    }
                } else {
                    print("File already exists in File Manager Directory!")
                }
            }
            
        } else {
            print("File don't exist in Bundle")
        }
    }
    
    // MARK: - Get file from directory
    
    /// Get a specific file from File Manager Directory
    ///
    /// - Parameter fileName: The string of the name of the file
    /// - Returns: URL The url with the location of the file, if it exists.
    static func getFile(_ fileName: String) -> URL? {
        if let documentDirectoryFileUrl = getFileLocation(fileName) {
            if FileManager.default.fileExists(atPath: documentDirectoryFileUrl.path) {
                return documentDirectoryFileUrl
            }
        }
        return nil
    }
    
    // MARK: - Get file location in documents Directory
    
    /// Get file location in File Manager Directory
    ///
    /// - Parameter fileName: The string of the name of the file
    /// - Returns: URL The url of the file.
    private static func getFileLocation(_ fileName : String) -> URL? {
        let fileManager = FileManager.default
        if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileUrl = documentDirectory.appendingPathComponent(fileName)
            //print("Get file from: ", fileUrl)
            return fileUrl
        }
        return nil
    }
}
