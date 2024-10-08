Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577E21859D
	for <virtio-dev@lists.linux.dev>; Tue,  8 Oct 2024 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427588; cv=fail; b=iUOGiaLruu4l+Y79rnJwn7Dfw/VYZ9ryrjGU0FyYeE6NYXoRAj6S72rwZxeXuW7k4zUByVnuBU70Ah8IQAcbDavpmPiAejTyCdk5YpIw0xjjMRVP+d3hQ5yex7SO6BkBdDQDJ7YLq1EJ5ec1yVhgWT2cLm1JufMdkCkHOfqqdzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427588; c=relaxed/simple;
	bh=wjqr5B6eJPnywIzIg6bl5GTyHa3VAOXUbpQDZ/UeFZM=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=l3o12AOi0ClHw9gILkqnox2QFEgD3Y+e/gkFr8vP1WgVPbbwGJXZIs2fTmjlrQCbqti+hgGxw2gaiwbTZbkS6C2Fdmiog1ZQIqkMm6M7CkISwJIIkagS3kAoxHFoEhfOSnYJe//B/NDJNzF28ikiLY2tuYPHld9Cng22d+7vfd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P3iBx0S8; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P3iBx0S8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jH5PeClceR1u5nuET4frMKcNQMWUZTJJldTlf03ZC0l+26FYzGt+X3cmk/gJ7GuVxZPwyYEBuh9zx9xI9z2z5tg5JqiEpyo+EgH5jfpK6IYW1SKWm9PD5eHZmwBKjixvI1pS6kbdVbwVTL7FZas/QmEOkC1lSeEc/dX7bOi42sk9dyPn6iwyCYAJSY1y9zznS0N6U3vjAz5xe3i0vfPVyL/R9WVTjtV3hqoBPuGStJ2BFZ8oGBblUZ36nyNsVx83seB0g1MAVpD9xkssq7TUM7hAWy57MkW2A69q5otllCGYGm24AhfAaeIKV1/EFdN0mLfn8JEstsyl7PoGKWE7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ky+PocQ3e+YsDRg2Ds3B3A23ZlMjj9JvwhAoDfvc3E=;
 b=wyz+o9RJYO2TvaRImoIQhKjAhQl0U3qfEgp2e7MS+/AuObFH51WeAoJNiyuMSljh5M2VuYJXSHVZF4wAD5VY7yrtO16eOjnhzzvMNBlW9rdfSoG42AcjTSkBSnVRm0ybxax5tf4VsIh+Uq/KX5+AB9bQ7JXFrOyejJWS5CQUoWW+jJjY0MkiOnetXgJhwwL7iPBUa5awm8+QUomcusBgTcSzrY+vePJvzVEyW+WoeRY0K13Y7JeeREWLpdXPvWSLPRKdUd/AajtPJNxcnutZ0emv4mDo/eTQ1g58JEyklp0FOLIpE04QURvmMfzQdxJx0M8r2K2psAjw5nzX/Z1EFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ky+PocQ3e+YsDRg2Ds3B3A23ZlMjj9JvwhAoDfvc3E=;
 b=P3iBx0S8iBxebSm11lEhWTwe/beH6WPl31Qvt4pvOO0yRAcNRKqZzu6QN7KJfdlqba4cc3I0IEeoE4Fn6iVhXxtnJA408X3OPOU/SsC46uG0q9RXmBfb7DIgM3UAXNgsE2a9uM0P8Yq+ZnQFKCQsYQQZ0pyVJ4D1sM9Q9QY7E3QpsuN8cqtWN1uuRjaHERwhjpkS9RJqRVLu15QHKIRK3wSNyyXRjIpgm5f4h2MEhSHz70rxD0D8VIErgfPzuDiTI19H4HtCys6u6nRo4J5Jez6UgzfRu8TYMsfMHaZ5oU7yO972uhz0H4bVzA75ZK3pIYqUlAXnmpaUBq/IMwHa4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:46:23 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 22:46:22 +0000
Content-Type: multipart/alternative;
 boundary="------------aETCX4PWR0qD0mV24fdG9b3P"
Message-ID: <1389ad0b-89b0-4e50-b07d-02bd6141fc7d@nvidia.com>
Date: Wed, 9 Oct 2024 01:46:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] virtio-blk: Add description for blk_size field
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: dverkamp@chromium.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.linux.dev,
 oren@nvidia.com, parav@nvidia.com
References: <20241006165609.34953-1-mgurtovoy@nvidia.com>
 <20241008201502.GB22682@fedora.redhat.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20241008201502.GB22682@fedora.redhat.com>
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 95880cdb-14ac-49ec-c2ca-08dce7eb0872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGJZcjJMWHhjMHVHY21pRUtSNU5NNmJFMXdZdnlkRi9ibXZnMkFJQUlWY2dJ?=
 =?utf-8?B?S1RJWjNBYk9ZWVU1azBXSjVTcmxiZlNLNEluVjNQanZCZFNHT0JMNkJVQTJq?=
 =?utf-8?B?bWRtYUd2MXkxZW1FNlpWN2NCQUxiYnpyQ3F3Ny8rYVZVTHVLVytEeEtQVHZx?=
 =?utf-8?B?bmhWWmRuNTNKckc5T1BuU3Y1VGZkS3JvMjlEV1gyQXRGQTR0cTNEUDFYNjZT?=
 =?utf-8?B?c3FHYkIzWm5Jei9IWXltd0dBdCs0Y3dnTXVxRmNKQ0I4MHdvSkJ4QTRkSXMx?=
 =?utf-8?B?ZWpUYXZVOFJQUlNwTkxXZWVIWnVTMkgvVzBCUHArb21sU2VXcENjT2NVR2V0?=
 =?utf-8?B?NER6ckJOZldpZjM3WkpNWTJscTZBczRxT0pGM3dDRU9WTUhyRllFZUpTaFBG?=
 =?utf-8?B?V2xpUEZXZFRSQ201ajQrcUFqbnE5aGFkQnJ6bHpONEs5VWdsM2xBZkViUWkw?=
 =?utf-8?B?Nk9vT3BtK0dFWDdVOEk1T0h2NUw1UzhVVmVENWRhMldxMzE0cHVSMEMzZi9J?=
 =?utf-8?B?Z2tYYTJzdUY5WXZBWm9TSUE2MHJtNHpTRE5DY1FhWG9LTSsvUCs5SDRLNEs2?=
 =?utf-8?B?U3pqcHU1OUlzUThGUlhoOVZ5Qm9JZXdOOE9EN09zRDVIaFdQUEZtdzJjOFFF?=
 =?utf-8?B?NzBFRE1JNWgwZzNmMTJLNmJBV2JnU0h5YjlwQzV2R0VzbUw5NU0xVHdzcE4r?=
 =?utf-8?B?empNODh0dXRjM0NybU5vd3ZjN1NOdTRRZldxTm1QVFdsaEw0WncwUnYraTBW?=
 =?utf-8?B?dlJEdmgyeGtLNGV4bnMxajhRS05NdWdqa2tDd01ZbzcwVCswR21maVgxSmRm?=
 =?utf-8?B?dmQ2TmFhUFZ6bGFSL05IT0RhaW9lcGx5K1lIYzFMSEhIQlpXQ0x3MHNJK0J6?=
 =?utf-8?B?NTNSeUFvUFlyYTJUbUJIZW5xMVVueUlqQ05mMTFOVmw1Z3M4QXRxSlVMaEhQ?=
 =?utf-8?B?b200NkNiWTFNVWF0ZkZ1aVRYWjY1ZEJYR0pLUEd4ZExwOGNLWkJWeHMrT2RQ?=
 =?utf-8?B?Q3R1bGF0ZXppWDhwUll4Y2Q1ckJ3WGZvZ1lJUFk5REwxY3U3Y2dROHhvUDNr?=
 =?utf-8?B?VUxzMXFKeUNub3hTdUxCbXdmaG85M3pwdDRyWGZvWUE1N0YvZFBTT2pDdzlZ?=
 =?utf-8?B?WlBsemw4Nmk2YkZkdktCak92QkdYWEtmZGs1QTk5SWF1UVZrWk4wSXNjOEpW?=
 =?utf-8?B?NU01alVJdy95VTBqUjBiMUdIWXdpZmpudisrVzBES0RqSWtDQ0VIaWVjK3hK?=
 =?utf-8?B?NHFieHBNY1JBUURkSCtaU3pid25mUHBiNVZDNlEwaWJOMys3eEJ5emg1YVpt?=
 =?utf-8?B?UHlVeVlENm96aTQxRWtocFk3RUQ2UmJrQ2ZLTE5FbW5aM2JjWEZCMWM5MlIx?=
 =?utf-8?B?eWZVSXVkdzlSSHNyY2JvZTNUaXJJYWVlczFWNTg0RHNMZG9aQVJYS1kzRDVP?=
 =?utf-8?B?WSs1aUJyWGVaVVV5SXlXRWlNRjE1eFJXY1VabVllZUxUdFJ2TU9kTTlnRUFj?=
 =?utf-8?B?UjdhVmhQdXpIcTJlTGF3NTdYWG50SWRxbU1BcFlSdm5EV1lIcDFEZkRQalRB?=
 =?utf-8?B?NTk2Ump2N3lKL1V2NWc3V3A4QWtBN1NyQUtMaHJlaGszWHJyNzF2NzZIcjZ5?=
 =?utf-8?B?cmdGVFdLRm9TZFRoR1NaVEtveXp0NXJvc1FBVk00cWZKd2RDYUFyNUtiNTVE?=
 =?utf-8?B?aVV0WitYSGVwSXh2SjJLNTl5NGcydjZISUU2NmNJVW43elBsSHhYZ2tBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T29McFJaZDJ4NWVRdnRGTTh2TkRpRTB0RWRaMzN6WGpjeWszS3VQNmt2Q0VI?=
 =?utf-8?B?V2J1YnQxbStNQ1p6UVhZdDN2YTl2aW9icWR4RGcrZ3hZclMxVGJHZGxDYnYr?=
 =?utf-8?B?QTB1a2hpelNJL3ZXUFR2RlFjOGhxd2VtOXNOaXBKZW5Ub3VRczQrbXFvbEto?=
 =?utf-8?B?aGpoWEtqZlVJMHdHUGEza29MQXlVbyt2MGZyM25hVzhLbHZjbjRTUEtWUGxW?=
 =?utf-8?B?N1pvcVdLem5xQmNPS0ZETCs1UDc3OGdkRldvVklQdGN4Y2Nma3JJSGllbXZN?=
 =?utf-8?B?RkU2eXduZ0VydHRLREhPZy9IdXN2aWhLak4zUFlUNmpPSytleGxKMDR6RDdR?=
 =?utf-8?B?M0t2TUxrSnhmSGkxVFpvcDMwQUo1TzdFbTlCLzNQbXhyd3c0WDA0TGMwclcr?=
 =?utf-8?B?cUkzREZjZitnbmdITWhCZnJtZ2x1YUtjNEh1dWxMNkw2SmxVWmY4anZSMngv?=
 =?utf-8?B?S0k5QTFMWFptODVFSVFBSXM0UTNMNlFqZDBia1pNeHZFdDY4Q3h0Yzc1cit5?=
 =?utf-8?B?dHA5ejQ0RnhqR0VYN3prMnNRYnpFSmhja0YveUlmRTZzMWpuVVY4aVRQeU0v?=
 =?utf-8?B?czNtaFpieU9VbXVHYmRQRFkrdUZPaGd2aUYvME83NnFpOWI5STVrNk9jK2Jl?=
 =?utf-8?B?VS9od0JTNTlZRGNNWGJ4THpiaGg2SXkrZlovTU94L1AvVGxxQ3V4QnZhcWxB?=
 =?utf-8?B?bVo2YWlLQTlTcS9DK29HTFNOSm4yUVE0QVZpVHU2L0p2YnlMdnZQamNOdE5h?=
 =?utf-8?B?cUh6Q3l0UnFFR3RsSk9sVGswczBRaWZqeGM5UUVzdmxXVktKMmpTbHpISkhS?=
 =?utf-8?B?akwwQUlBaVk1eGw5c1JQN1NBL2tuQWNXcmdaazZ2TE02Q09ZNDhhYml5c0Vx?=
 =?utf-8?B?Q2pPOWtMeVVlRTNUbEYzMGQ4RlpweWovMnlIVG9TKy9BQ0hxUGQ4MVltVEZT?=
 =?utf-8?B?SEpWajRTVmRtb2c3R0ZrdFVIRE8vRlNNRGZxekVXMm5FMjU2ejhSc0FjdDdK?=
 =?utf-8?B?aXY0c0E1eEdrWVNWRDd6S04xdFdVdENocWRSb2hGaldWclYyMEY4b3ZNbEJu?=
 =?utf-8?B?cmdQcVZ6MVFwNnJzck5kR2tEYzdXWjdzWDRqMmQ4Q2puMmFjWDNFdVU5eFVH?=
 =?utf-8?B?TzhkbGJ2TVMzSWlCdGprY3RRS05PZW02NC85Y0tWRVBqelVnWWV2cGV2TUJ0?=
 =?utf-8?B?VGtsdXlRTWYxK0ZiOXBMTzlodUppaVgzR2d3aUtuNkxJZmxGK0YydWhIc0xj?=
 =?utf-8?B?Z1lRWVltczE0Q250RXBDSWo1OFpDZUF0di8vclRLWTBiaXdDUUpOeUJTZFFU?=
 =?utf-8?B?bVlpZng3QXc3NXo0TzJaNnZDNFZHaGt1dUd1T0lTYUNqamxiZE1Wcnc0Yksz?=
 =?utf-8?B?L3JOY2xFcTZXeS9WT3RmNVRoL3A3Nm5ibStTdjdlT0ZVT0dpSnFOb0FqcjhS?=
 =?utf-8?B?OXVzTWxFMFBsNzJTdkloc094T1BRMzFUK0tlNXN0M0FFL09HNndTRmxTdVdJ?=
 =?utf-8?B?bEtlMmYxNTIxZ0dnVzF0Q1J0S05HTFdSbXpCNVYwSUs3bzF6QWdPMVVFeGNl?=
 =?utf-8?B?LzNPZS9Cdkw4VVMvcnl1MG5LTUlHYWw4bXQrcjEwc2dCaFlxZGZ4Zk5SOFBk?=
 =?utf-8?B?dUlpc25McUxVUkpaa0VtY1RiNFJNZUYrUHFDTTViai9kaWRsSFllMWZSVTY1?=
 =?utf-8?B?dDhSblNRZ0RZU1h0T2xxRGNwa2RCbnUyMU5NdlZBM0lCY0IxQm5kS2hTOGRl?=
 =?utf-8?B?cFk1Um4yWllXcURtNlJLalpBY3JleXMzRFFyQjNsSG4xUUlrRS9DNmVqdGJ1?=
 =?utf-8?B?dVlVbmhXN0UycG94TDQ4ZFlpMHJFUENCUVUycWtxTjdBWEVMSUlhS29LNDBZ?=
 =?utf-8?B?anRMZEJXa1p6RldlVE9pZVhUV0VMaVVQbSsyRDRmbjkwK0UvbFl1N0xhbktn?=
 =?utf-8?B?UGNVU2lDWEhFOTJFTFRKLzdQNmh1MENzSEhMWnBBZHd0RHdXdnJZVG01c3c3?=
 =?utf-8?B?TVJKUDZreEo3Yk1QZ3REK2szS2FHNnkza2JWZXpJNExVVkxTZDZTNWtFUU9t?=
 =?utf-8?B?dGtJQXluR1BWYUVFVlJsSHBRVm0wWXp2dWNsenQwZ3Zua0dLV0N1a1I1TENu?=
 =?utf-8?Q?QCUWnWMd+xDHC70lGm70CbP9i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95880cdb-14ac-49ec-c2ca-08dce7eb0872
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:46:22.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxB8lE8koydQe7eum0xmkwKmz1jIhJ+hhJsS/bmoRTpyiWLZf84VQS4RXDlpuTXzlPqaD/T6qUGBhTFFSTd9pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

--------------aETCX4PWR0qD0mV24fdG9b3P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/10/2024 23:15, Stefan Hajnoczi wrote:
> On Sun, Oct 06, 2024 at 07:56:09PM +0300, Max Gurtovoy wrote:
>> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
>> offered by the device.
>>
>> The blk_size field actually represents the logical block size of the
>> device. It is always a power of two and typically ranges from 512 bytes
>> to larger values such as 4 KB.
>>
>> Add description for this field to provide clarity on its constraints.
>>
>> Signed-off-by: Max Gurtovoy<mgurtovoy@nvidia.com>
>> ---
>>
>> changes from V1:
>>   - Addressed Stefan's and Daniel's comments:
>>         1. use SHOULD instead of MUST
>>         2. Add a note that devices may return IOERR upon misaligned IO
>>   - Add a note that devices may return IOERR if IO size is not following
>>     the block size granularity.
>> ---
>>   device-types/blk/description.tex | 34 ++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
> Reviewed-by: Stefan Hajnoczi<stefanha@redhat.com>

I'll add both yours and Daniel's Reviewed-by signatures and fix a small 
comment from Daniel.

Can you please remind me the next step I should do ?

Should I open an issue at the oasis github and mention it as "Fixes: " 
in the commit message ?

--------------aETCX4PWR0qD0mV24fdG9b3P
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 08/10/2024 23:15, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241008201502.GB22682@fedora.redhat.com">
      <pre wrap="" class="moz-quote-pre">On Sun, Oct 06, 2024 at 07:56:09PM +0300, Max Gurtovoy wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
offered by the device.

The blk_size field actually represents the logical block size of the
device. It is always a power of two and typically ranges from 512 bytes
to larger values such as 4 KB.

Add description for this field to provide clarity on its constraints.

Signed-off-by: Max Gurtovoy <a class="moz-txt-link-rfc2396E" href="mailto:mgurtovoy@nvidia.com">&lt;mgurtovoy@nvidia.com&gt;</a>
---

changes from V1:
 - Addressed Stefan's and Daniel's comments:
       1. use SHOULD instead of MUST
       2. Add a note that devices may return IOERR upon misaligned IO
 - Add a note that devices may return IOERR if IO size is not following
   the block size granularity.
---
 device-types/blk/description.tex | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Reviewed-by: Stefan Hajnoczi <a class="moz-txt-link-rfc2396E" href="mailto:stefanha@redhat.com">&lt;stefanha@redhat.com&gt;</a></pre>
    </blockquote>
    <p>I'll add both yours and Daniel's <span style="white-space: pre-wrap">Reviewed-by signatures and fix a small comment from Daniel.</span></p>
    <p><span style="white-space: pre-wrap">Can you please remind me the next step I should do ?</span></p>
    <p><span style="white-space: pre-wrap">Should I open an issue at the oasis github and mention it as &quot;Fixes: &quot; in the commit message ?
</span></p>
    <blockquote type="cite" cite="mid:20241008201502.GB22682@fedora.redhat.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------aETCX4PWR0qD0mV24fdG9b3P--
