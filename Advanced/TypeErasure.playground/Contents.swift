import UIKit

protocol ObjectMapper {
    associatedtype SourceType
    associatedtype ResultType
    
    func map(_ object: SourceType) -> ResultType
}

//Uncommenting this class will next error:
// Protocol 'ObjectMapper' can only be used as a generic constraint because it has Self or associated type requirements
//class ArticleService {
//    var mapper: ObjectMapper!
//}

//Type Erasure can help solving this problem.

//First we create private abstraction class
//It takes generics and conforms to protocol ObjectMapper

private class _AnyMapperBox<SourceType, ResultType>: ObjectMapper {
    func map(_ object: SourceType) -> ResultType {
        fatalError("This is an abstraction method, must be overriden")
    }
}

//Now we create another private class that
//inherits from _AnyMapperBox

private class _MapperBox<Base: ObjectMapper>: _AnyMapperBox<Base.SourceType, Base.ResultType> {
    
    private let _base: Base
    
    init(_ base: Base) {
        _base = base
    }
    
    override func map(_ object: Base.SourceType) -> Base.ResultType {
        return _base.map(object)
    }
}

//Now we create the AnyObjectMapper
//It conforms to ObjectMapper
struct AnyObjectMapper<SourceType, ResultType>: ObjectMapper {
    
    private let _box: _AnyMapperBox<SourceType, ResultType>
    
    init<MapperType: ObjectMapper>(_ mapper: MapperType) where MapperType.SourceType == SourceType, MapperType.ResultType == ResultType {
        _box = _MapperBox(mapper)
    }
    
    //we use this method through calss _MapperBox
    func map(_ object: SourceType) -> ResultType {
        return _box.map(object)
    }
}

//We can test our TypeErasure now.
struct Article {
    var title: String
    var text: String
    
    func printInfo() {
        print("\(title)\n\(text)")
    }
}

typealias ArticleDict = [AnyHashable: Any]

class ArticleService {
    var mapper: AnyObjectMapper<ArticleDict, Article>!
}

class ArticleSimpleMapper: ObjectMapper {
    func map(_ object: ArticleDict) -> Article {
        let title = object["title"] as! String
        let text = object["text"] as! String
        
        return Article(title: title, text: text)
    }
}

class ArticleSpecialMapper: ObjectMapper {
    func map(_ object: ArticleDict) -> Article {
        let title = object["title"] as! String
        let text = object["text"] as! String
        
        return Article(title: "SpecialNews\n" + title, text: text)
    }
}

let articleDict = ["title": "Here is the news:",
                   "text": "Winter is comming"]

let service = ArticleService()

let simpleMapper = ArticleSimpleMapper()
let specialMapper = ArticleSpecialMapper()

service.mapper = AnyObjectMapper(simpleMapper)

let simpleArticle = service.mapper.map(articleDict)

service.mapper = AnyObjectMapper(specialMapper)

let specialArticle = service.mapper.map(articleDict)

print("Simple:")
simpleArticle.printInfo()
print("\nSpecial:")
specialArticle.printInfo()
