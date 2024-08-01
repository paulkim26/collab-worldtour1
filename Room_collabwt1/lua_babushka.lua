if callType == LuaCallType.Init then
    for index, model in pairs(matryoshka) do
        model.transform.GetChild(1).transform.parent = matryoshkaLid[index].transform
    end
end