//
//  Singleton.swift
//  Langman
//
//  Created by Patrick Chaca on 5/20/20.
//  Copyright © 2020 Patrick Chaca. All rights reserved.
//

import Foundation
class API{
    static let shared = API()
    private init(){}
    func ParseJson(){
        let headers = [
                   "x-rapidapi-host": "wordsapiv1.p.rapidapi.com",
                   "x-rapidapi-key": "249f202f0cmsh380333100bffcb1p1bd0f0jsnab16020f490b"
               ]
           var char: String
           var temp: String = ""
           var counter = 0;
           while(counter < word.count-1){
               char = String(word[word.index(word.startIndex, offsetBy: counter)])
               temp = temp + char
               counter += 1
           }
           let url = URL(string: "https://wordsapiv1.p.rapidapi.com/words/" + temp + "/definitions")
           guard url != nil else{
               print("Error creating url oject")
               return
           }
           
           var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
               request.httpMethod = "GET"
               request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                   if (error != nil) {
                    print(error as Any)
                       return
                   } else {
                    _ = response as? HTTPURLResponse
                       
                       //print(httpResponse)
                    var result: Response?
                      do{
                          result = try JSONDecoder().decode(Response.self, from: data!)
                      }
                      catch{
                          print(error)
                      }
                      guard let json = result else {
                           return
                      }
                       if (json.definitions.count) <= 0 {
                           print("No definitions found")
                        return
                       }
                        DispatchQueue.main.async {
                            Return_Definition = json.definitions[0].definition
                            self.TranslateDefinition()
                        }
                   }
               })
        dataTask.resume()
    }
    func TranslateDefinition() -> Void {

        let headers = [
            "x-rapidapi-host": "google-translate1.p.rapidapi.com",
            "x-rapidapi-key": "249f202f0cmsh380333100bffcb1p1bd0f0jsnab16020f490b",
            "accept-encoding": "application/gzip",
            "content-type": "application/x-www-form-urlencoded"
        ]
        print(Return_Definition)
        let string_append = "&q=" + Return_Definition
        let postData = NSMutableData(data: "source=en".data(using: String.Encoding.utf8)!)
        postData.append(string_append.data(using: String.Encoding.utf8)!)
        postData.append("&target=es".data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask1 = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                _ = response as? HTTPURLResponse
                   
                   //print(httpResponse)
                var result: translated?
                  do{
                      result = try JSONDecoder().decode(translated.self, from: data!)
                  }
                  catch{
                      print(error)
                  }
                  guard let json = result else {
                       return
                  }
                    DispatchQueue.main.async {
                        translated_Definition = json.data.translations[0].translatedText
                    }
                print(json.data.translations[0].translatedText)
               // print(httpResponse)
            }
        })

        dataTask1.resume()
    }
    //Class for JSON file - WORDAPI
    struct Response: Codable{
        let word: String?
        let definitions: Array<InDef>
        
    }
    //Class for JSON file Array - WORDAPI
    struct InDef: Codable{
        let definition: String
        let partOfSpeech: String
    }
    //Class for JSON file - GOOGLETRANSLATE API
    struct translated: Codable{
        let data: textholder
    }

    struct textholder: Codable{
        let translations: Array<actual_text>
    }
    struct actual_text: Codable{
        let translatedText: String
    }
}
