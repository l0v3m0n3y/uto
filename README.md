# uto
web-api u.to Shorten Your Link. U.TO — a link shortening service. Allows instant shortening of any link to the minimum length.
# main
```swift
import Foundation
let client = Uto()

do {
    let res = try await client.getShortLink(link: "http://tvs.tv")
    print(res)
} catch {
    print("Error: \(error)")
}
```

# Launch (your script)
```
swift run
```
