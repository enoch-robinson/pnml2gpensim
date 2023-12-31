% ----- Subfunction PARSECHILDNODES -----
function children = parsePNMLNodes(theNode)
% Recurse over node children.
children = [];
if theNode.hasChildNodes
   childNodes = theNode.getChildNodes;
   numChildNodes = childNodes.getLength;
   allocCell = cell(1, numChildNodes);

   children = struct(             ...
      'Name', allocCell, 'Attributes', allocCell,    ...
      'Data', allocCell, 'Children', allocCell);

    for count = 1:numChildNodes
        theChild = childNodes.item(count-1);
        if strcmp(theChild.getNodeName, 'pnml')
            children = makeStructFromNode(theChild);
        end
    end
end