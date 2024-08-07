# Error Handling

This is a Solidity program that provides the functionality of saving information about news articles. It is backed up by error handling mechanisms in Solidity. This is my submission for the ETH + AVAX Proof: Intermediate EVM Course.

## Description

It is a program written in Solidity. It has the main functionality of creating, modifying, and deleting news articles.

### Smart Contract Modifiers & Functions

```javascript

    modifier onlyWriter(address writer, uint articleNumber) {
        require(writer == articles[articleNumber], "Only the writer can modify their articles.");
        _;
    }

    function getLatestArticleNumber() external view returns(uint) {
        return latestArticleNumber;
    }

    // create article
    function createArticle(address writer, string memory title, string memory body, uint category) external payable {
        bytes memory byteTitle = bytes(title);
        bytes memory byteBody = bytes(body);
        uint prevLatestArticleNumber = latestArticleNumber;

        // make sure that title/body is not empty
        if (byteTitle.length == 0) {
            revert("Title is empty.");
        } else if (byteBody.length == 0) {
            revert("Body is empty.");
        } else if (category <= 0 || category > 3) {
            // category is only 1,2,3
            revert("Category does not exist.");
        }

        // increment latest article number
        latestArticleNumber += 1;

        // save article info
        articles[latestArticleNumber] = writer;
        titles[latestArticleNumber] = title;
        bodies[latestArticleNumber] = body;
        categories[latestArticleNumber] = category;

        // make sure that article number was incremented correctly
        assert(latestArticleNumber == prevLatestArticleNumber + 1);
    }

    // modify article
    function modifyArticle(address writer, uint articleNumber, string memory title, string memory body, uint category) external payable onlyWriter(writer, articleNumber) {
        // modify article info 
        titles[articleNumber] = title;
        bodies[articleNumber] = body;
        categories[articleNumber] = category;
    }

    // delete article
    function deleteArticle(address writer, uint articleNumber) external payable onlyWriter(writer, articleNumber) {
        titles[articleNumber] = "";
        bodies[articleNumber] = "";
        categories[articleNumber] = 0;
    }

```

The modifier onlyWriter enforces the restriction on certain functions that take in an address wherein only the original writer can modify the information about an article.

The createArticle() function creates an article by storing the information within the mappings.

Both the modifyArticle() and deleteArticle() functions use the onlyWriter modifier. The modifyArticle() function updates the titles, bodies, and categories of previously written articles. While the deleteArticle() removes any article information for a particular article number, but retains the original writer address.

## Authors

Andre A. Aquino 

