//: **Machine Learning with Core ML 2 and Swift** - Source Code
//:
//: Get the course **[on Udemy using this discounted coupon](https://www.udemy.com/machine-learning-with-core-ml2-and-swift/?couponCode=GITHUB)**
//:
//: The book version is available **[on Amazon](https://www.amazon.com/dp/B07F2NYDTH)**
//:
//: _ _ _
//: ## Who’s from where?
//: This smart little demo can recognize names, places and organizations in natural text.
//:
//: - Callout(Interested in Swift programming?):
//: Check out my **[Youtube channel](https://www.youtube.com/c/swiftprogrammingtutorials)**
//: my courses on **[Udemy](https://www.udemy.com/user/karolynyisztor/)**, **[Lynda](https://www.lynda.com/Karoly-Nyisztor/9655357-1.html)** and **[Pluralsight](https://www.pluralsight.com/profile/author/karoly-nyisztor)**.
//: Website **[www.leakka.com](http://www.leakka.com)**
//: ---
import NaturalLanguage

//let text = "If today were the last of your life, would you do what you were going to do today?"
//let text = "אין עשן בלי אש"
//let text = "读书须用意，一字值千金"
let text = "Steve Jobs, Steve Wozniak, and Ronald Wayne founded Apple Computer in the garage of Steve Jobs's Los Altos home."

let tagger = NLTagger(tagSchemes: [NLTagScheme.nameTypeOrLexicalClass])
tagger.string = text

tagger.enumerateTags(in: text.startIndex..<text.endIndex,
                     unit: NLTokenUnit.word,
                     scheme: NLTagScheme.nameTypeOrLexicalClass,
                     options: [.omitPunctuation, .omitWhitespace, NLTagger.Options.joinNames]) { (tag, range) -> Bool in
                        print(text[range])
                        print(tag?.rawValue ?? "unknown")
                        return true
}
