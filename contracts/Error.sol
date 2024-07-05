// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.17 and less than 0.9.0
pragma solidity ^0.8.17;

contract Error {
    // keep track of the latest article number
    uint latestArticleNumber = 0;

    // create mappings (articles/titles/bodies/categories)
    mapping(uint => address) public articles;
    mapping(uint => string) public titles;
    mapping(uint => string) public bodies;
    mapping(uint => uint) public categories;

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
}