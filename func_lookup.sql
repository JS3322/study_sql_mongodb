{
	$lookup: {
		from: "TB_LAYER1_PROJECT_CUP",							//look up target collection
		localField: "MetadataLocal.ProjectId",			//현재 부모 컬렉션에서 lookup할 검색 필드
		foreignField: "spaceId",										//lookup target collection에서 lookup할 검색 필드
		as: "projectInfo"														//별칭
	}
}