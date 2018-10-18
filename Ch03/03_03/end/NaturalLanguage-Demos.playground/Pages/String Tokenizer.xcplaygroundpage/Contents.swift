//: **Machine Learning with Core ML 2 and Swift** - Source Code
//:
//: Get the course **[on Udemy using this discounted coupon](https://www.udemy.com/machine-learning-with-core-ml2-and-swift/?couponCode=GITHUB)**
//:
//: The book version is available **[on Amazon](https://www.amazon.com/dp/B07F2NYDTH)**
//:
//: _ _ _
//: ## String Tokenizer
//: This playground project shows how to use NLP to dissect a text into semantic units.
//: Tokenization stands at the core of most other features, so this is an important exercise.
//:
//: - Callout(Interested in Swift programming?):
//: Check out my **[Youtube channel](https://www.youtube.com/c/swiftprogrammingtutorials)**
//: my courses on **[Udemy](https://www.udemy.com/user/karolynyisztor/)**, **[Lynda](https://www.lynda.com/Karoly-Nyisztor/9655357-1.html)** and **[Pluralsight](https://www.pluralsight.com/profile/author/karoly-nyisztor)**.
//: Website **[www.leakka.com](http://www.leakka.com)**
//: ---
import NaturalLanguage

let text = "Knowledge will give you power, but character respect."
//let text = "אין עשן בלי אש"
//let text = "读书须用意，一字值千金"

let tagger = NLTagger(tagSchemes: [NLTagScheme.tokenType])
tagger.string = text

tagger.enumerateTags(in: text.startIndex..<text.endIndex,
                     unit: NLTokenUnit.word,
                     scheme: NLTagScheme.tokenType,
                     options: [.omitPunctuation, .omitWhitespace]) { (tag, range) -> Bool in
    print(text[range])    
    return true
}

//: [Next](@next)
