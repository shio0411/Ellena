

# Release Summary 
***Changes since last push from 20/6/2022 10:123PM***

***Release date: 21/6/2022 12:06AM***

## Milestones
- 

## New files:
- about-us.jsp
- faq.jsp

## Changes in code:
- `AuthenFilter`
    - Add uri for none login user:
        ```java
            (
            (...)
                || uri.contains("about-us.jsp") || uri.contains("faq.jsp") ) 
            (...)
        ```

- footer.jsp
    - fix hyperlink to the correct pages
    - add more comments

- `project.properties`
    - Clean duy's merge conflict messages

## Discovered possible issues:
 1. 

## Note for later version:
- 

## Note considering for later version:
- [Ternary conditional operators into if-else statements](https://converter.website-dev.eu/)

