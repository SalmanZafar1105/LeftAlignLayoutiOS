# LeftAlignLayoutiOS
Align items in UICollectionView to the left.

WARNING:

1. If one of your item's width is larger then the content's width, this code will fail. Make sure the size of your items are in the bounds of the content.
2. Supplementary views like header and footer are not supported as of now.

ABOUT:

By default the UICollectionView will equally space all items in a row, which leads to them being centrally aligned. In this project, the items are aligned to the left, with equal distance between them. 

As to why I chose to start with this project is because throughout my iOS application development career, I saw many solutions to this problem and all of them were just crazy manipulations of the existing UICollectionView's flow layout. The worse being where some would treat every row as a different section, and then align it using the sectionInsets.

To know more about the solution in this project, refer to https://developer.apple.com/documentation/uikit/uicollectionview/customizing_collection_view_layouts.
In the above link you can find a project explaining how to program complex UICollectionView layouts.

This project is not on cocoapods as of now.

This is a hobby project to keep on updating my iOS programming skills, as now I am back in education pursuing my Masters. Thus, don't expect regular updates or answers.

Any suggestions on any future project are welcome.

P.S. - The implementation of layoutAttributesForElementsInRect is not the best and I am still working on a better solution.
