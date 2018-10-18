//: **Machine Learning with Core ML 2 and Swift** - Source Code
//:
//: Get the course **[on Udemy using this discounted coupon](https://www.udemy.com/machine-learning-with-core-ml2-and-swift/?couponCode=GITHUB)**
//:
//: The book version is available **[on Amazon](https://www.amazon.com/dp/B07F2NYDTH)**
//:
//: _ _ _
//: ## Language Recognizer
//: There is no smoke without fire.
//: Cool, but what language is that?
//: How about this sentence: 空穴来风,未必无因 ? Is it Japanese? Or maybe Chinese?
//: Let’s build an NLP app to answer these questions!
//:
//: - Callout(Interested in Swift programming?):
//: Check out my **[Youtube channel](https://www.youtube.com/c/swiftprogrammingtutorials)**
//: my courses on **[Udemy](https://www.udemy.com/user/karolynyisztor/)**, **[Lynda](https://www.lynda.com/Karoly-Nyisztor/9655357-1.html)** and **[Pluralsight](https://www.pluralsight.com/profile/author/karoly-nyisztor)**.
//: Website **[www.leakka.com](http://www.leakka.com)**
//: ---
import NaturalLanguage

// אין עשן בלי אש
//let string = "אין עשן בלי אש"
//let string = "Ich wünsche dir einen guten Morgen!"
let string = "空穴來風，未必無因"
if let language = NLLanguageRecognizer.dominantLanguage(for: string) {
    print("Detected \(language.rawValue.uppercased()) as dominant language for: \n\"\(string)\"")
} else {
    print("Could not recognize language for: \(string)")
}

let languageRecognizer = NLLanguageRecognizer()
//languageRecognizer.languageConstraints = [.english, .spanish, .simplifiedChinese]
languageRecognizer.processString(string)
let languagesWithProbabilities = languageRecognizer.languageHypotheses(withMaximum: 3)
for (language, probability) in languagesWithProbabilities {
    print("Detected \(language.rawValue.uppercased()), probability \(probability)")
}
languageRecognizer.reset()
