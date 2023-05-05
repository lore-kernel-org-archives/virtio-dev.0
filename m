Return-Path: <virtio-dev-return-12596-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322C0C77B75
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:46:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7DAFD3263F
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:46:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74EFD986709
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:46:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 68D9F9866D8; Fri,  5 May 2023 16:46:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5545A9866C5;
	Fri,  5 May 2023 16:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFGgFmb/n7wrYLxQT+hOb6B6tC0beqFzovGCmirqA2oEHeFJYg6E7m4pj2i8coFq413Mzi53XZGCL3SItb1os+d5o8ElQV1tPbiqDFz2zdvTSynmqCOCI/AAXp+H9jVyWtEM7VoZ8BJ3K1badp4YDAgFzbKpm8je3Yzv/ZlsSYjazCcG/fPkToKwkMks5+JY8Y+q25OMaE9hN+wG6bJTUmDKIKnVvSTIuU64Hcnn0sWRlW8X+UW/rl09z8P5y/gVFL3w6l4D0IotX6LBVhh+vTgXRFbLgJor07XzSp7Lm0INpghweI5Enpcj5l3XN8goSPRgmoTCiGvOtz9IKooceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gOIjw+hhboKBnmV5sg8t33Gnjj5rTe9RzP61Z8okI4=;
 b=ev59gaCBq/Z2jH9325ONZfWZZqm4pyNUTTRiFjsscoEFx9u02u8AXrey9SLPWo9Xy+Jm9+uFpAb68Xep1MPy/ymNAeT9FgXVKUsAdWt5nfpM8Pem0LIObcq4yv6A+TDlj7BsRFOrxo0qxa2MTbG6EDhJnF4rwKbme9tuALS2wts506aU45H8SOLpnkrh+2720HCXG5hPWavWORGbsOON046KntO2MIcxZ8cQP/88fGWQkxhd5aALO9DdWkSVldyoTqDJbq1hqEcc01zzEhMKsCwmDuegxAwueYc45xalMsTF3JLlzeWlS3BjRfLqEQuZQR+m9305Us8tDI0aoF9aJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <1d7459f5-9e68-3515-927e-544006718d2f@nvidia.com>
Date: Fri, 5 May 2023 12:46:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1683301091.git.mst@redhat.com>
 <d12263629be44bda17b8e12beea69bc6ef82eeb1.1683301091.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <d12263629be44bda17b8e12beea69bc6ef82eeb1.1683301091.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:806:d3::21) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fd9cbe-1f1d-402a-afe6-08db4d883df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8YR+xjob3aIWOYpzVF76EbiKz20wpIDx8XBnSJVHm3dOyqnetoe/2dWvjxjMs/pikrjkvHL4nXtBlzybQkK69L49e60vCXYS6lGfvUyrFCM5PooPodgDUfUqw10NuxcwqeokGZwk8p261AZTS0YDh4Gw5/xLN5aU59/x7n4UCuRSvNlASI+2BoJxGdYZTJpxvS1DK/aPezrdqGh7NXLf96o7rpjObIoKS39x55/UoSiagOdooOQAfSiGdG0ws6M2lUfUDCDWueiLGjyOo0bagcNnwjHI4G+/sd3q9z5/lxRPRc9NsvwS9YwBt+w4oup+wUnqZBQzqyHZGCRFx/qbY7FFOAE9QrrcA8BzsqSQLCskjUCR2Kd+TY+CR3M4VFWtlulam+FWFToOfKWlYW6+uULj1kroSrfPQCcCCBWhOaBv98rspJ3VjkwgWLxC2P4TUolQT+e62c2H9IbokLMRoRO+Gp+EnWEtNS/7z51iYDCqhAuUc4W3zuDx6lps3Q5R9QpgVY/AmavvdcleIdh8PgC6g0kw9pBBQY8C9G3pmENPesofjwE4+kRpbNnowQNrjrgfC1wY541tF0L6QPIMktiMqSGo3DRLUHW5Jwby238ZxITODNBQd0+RYZ9LflMpcbp5SdlNfL2kzxOWVPIXIY5R7WnNBgIwgg8DI8vVQik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(4326008)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(7416002)(53546011)(6512007)(26005)(6506007)(54906003)(31686004)(478600001)(316002)(6666004)(6486002)(107886003)(2906002)(186003)(2616005)(83380400001)(921005)(86362001)(31696002)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTFHN3lQK3kwYzlKWEJ5aVhVbUQ0ZGtTVnMrMmZER1oya0xNS3NDN2JxejRC?=
 =?utf-8?B?Um8zOUtWT1I0YlNSUUZXV1RPTDZQSzFCcnQ2Q1FDVHFzRTZxbEdjalgzdXJ5?=
 =?utf-8?B?Z1k4SmcydVU1MnFMM2dXS1B1SDFndndsN0k5cWx0dFczZFpaRExoSDlZUmJQ?=
 =?utf-8?B?eGtWVHhHa2plempmZWQ5WTcweDlEWkdma04rTG8vNjBpYnFvY25FUWxDdEpL?=
 =?utf-8?B?UFNpZVBQdFEwcjV6UVJNcmtscWFMWE16bTMzbFBRVDRhajlveGpDa3FISytZ?=
 =?utf-8?B?cnU1cTVqSE9QVjhwbFdiVS9KazByK0FEczlGcmd6WnRJelVEcnBHY3c1WUc3?=
 =?utf-8?B?NFFvcTR5TTAvYkdqdzBzTTJRSFY5K3RRWnYxZ3I0RHZJRTJlNkRHTzhiL3Rw?=
 =?utf-8?B?bGxSQmMxNmhGR2FXWjdBeEdNcFB1c0RRUnBwTlpkTkR2TUZId0pCR2NkYTJR?=
 =?utf-8?B?TEE4MjhNaW5admd6YTA0TngrSXdBSit6ajl5Z2VjUkdGc1VkWUZRaG1VZEtv?=
 =?utf-8?B?NWRaNTY1ZWFMTnk1czJ3dXBTN3UyQzVRMlp0QncycmZObkh5aDcxcTRKOVZz?=
 =?utf-8?B?aW1MdlRpeWF3aFZBNWhvbzFXZXhxZnI4QXYzak1CUVNnWWJLYjd5MWVpN1Zo?=
 =?utf-8?B?Wmx4ZkxSVjN4dzVFV2tPUmxUQUVYV1RZVUR6SkJjakh5cUMzeldCL056ZWl1?=
 =?utf-8?B?MVkrN0EzNjZiTDBxK3dXK0ZVNlJXa2gvT1B3KzhqM0duTjkvTTNHbzJWTWZC?=
 =?utf-8?B?cENFR0ZLQTJ4blJZenU2bmNaMkZPL3BuWUxKeXV5TjBFMzNSUVAyM2p3MzlR?=
 =?utf-8?B?UmYzOUc3dFdOQkw0a0dpL3l6aVdROFo5VzlUZVBzNjlVTGlMd1lMU2NOM21Y?=
 =?utf-8?B?OFZNQy9pRWFYcVgxNmtuSVFlbTA1WTBsbERLVGxKUnNTLzFBTDJqSVhJVTUr?=
 =?utf-8?B?RnI2cTJxNjlieTJDQnFmeVE4UzNKN3hsRCtCdU1yVWZqdzhiSHhvUmYzR3Fo?=
 =?utf-8?B?cThKV2JHWHZEeGt3Y09QdStiTGJSKzNQRFBVZWc5OTNDaEVtdnpSdVJUTGpv?=
 =?utf-8?B?RzlPQ0dEMEp4ZnhIVWppY2YvM2FMQ0I3eGF0TEZLSGtOQW1UYml3L0JGK01C?=
 =?utf-8?B?ZXkyL2syYWh5ZkpSN2hDUXJDOHZacmkvSkpaZm8zL2xxQmRRUm90ZXdld1BX?=
 =?utf-8?B?V1NCWHprc2dwM3dpc0dSUHdTVm44V0NtaHJyQWsrWFBaM0Y4NUE4RFQzUk5K?=
 =?utf-8?B?aHZhN3Zyb0llTlRBWURrRVNMdytzdWdhVHd3Z1RObHMwcEczQkVNVzE5ZlND?=
 =?utf-8?B?Z1dlYkxGejNGUmFiVDROZEtMUlpFTWhqNHhuczBTcGxZV0o1MUFDK0ZCT1Ir?=
 =?utf-8?B?c3JYTE5wcVJVS3RHWVdicGQyWnVrQzgwa2J2ZTRTYytDb0VtdjRYMzJOTXdz?=
 =?utf-8?B?VlRSL2lXRXhZd3JqSXdIWDZIVHZqRFRWMGxWREk3NWNJVDRLQy9GT0kvU0w0?=
 =?utf-8?B?UW5IWXBud1hHLzA2VkNtS1V2MGdodjVrdVpUOWNmSmxHTHZqOTBPcVN3Nmk1?=
 =?utf-8?B?aWJ0cGd3cXpQWWE4Z2U1OUllZ0tES296VVJpM2czeVhFSmxKS2dKM2ptWW5n?=
 =?utf-8?B?SWluQW5JYy9UZlZxMFJJdDVIMXpPblQ4L2cyb25lcGlQQ3ZNbXZtTUJFazh1?=
 =?utf-8?B?WDZNTDFSNmkxVXZYYUFvVDBHaEgza1lwelpNaGdGcm4wcUJ3eTlSTWFmMTg4?=
 =?utf-8?B?a1dmcHAwYUdrYzdnWGdabWpGenJPVktsY2M3VWpsZ3piZklwbUluWUdRTXBH?=
 =?utf-8?B?YWZCajZNMjRPL2VhdU1tbWJMc3ZDc1I3a1l1eEJoL1dRSjZZbEN2S016TkhK?=
 =?utf-8?B?UHEyZG85cmd5VTFDa0kzWUN0Z2gxeTJEM01NaVJQOThlOE5zSUdFaC8rQ3VC?=
 =?utf-8?B?V2dsYmpJejRKQ0N1cHNpZUZWaGNBa09JcTlLWjlrMlhJaEdYTjZwS3lYRVlq?=
 =?utf-8?B?NDhQL3NYKzFFVDN6cysvWjNURHJieE1aMnl0Y2JhS0tMRkFnblN0MVYyZGdT?=
 =?utf-8?B?Um5kOTVuNGRlVTI2Nk1FejM5Wjc3QmRwRm1UVGNhbkpqMVdaV3FjY3YrdHpR?=
 =?utf-8?Q?KommXoMd6KncusBF6Zmw5jRIp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fd9cbe-1f1d-402a-afe6-08db4d883df9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 16:46:15.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jT9QwxeCIsvlvC7cPk7SfVb8hqxYaLbmAmWuiS5/Q3/u40nIH9Jq4LzM6Mv4lArtbeZUGYytVMp6M6WPbc7Ssg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
Subject: [virtio-dev] Re: [PATCH v13 02/10] admin: introduce device group and related
 concepts



On 5/5/2023 11:40 AM, Michael S. Tsirkin wrote:
> Each device group has a type. For now, define one initial group type:
> 
> SR-IOV type - PCI SR-IOV virtual functions (VFs) of a given
> PCI SR-IOV physical function (PF). This group may contain zero or more
> virtio devices according to NumVFs configured.
> 
> Each device within a group has a unique identifier. This identifier
> is the group member identifier.
> 
> Note: one can argue both ways whether the new device group handling
> functionality (this and following patches) is closer
> to a new device type or a new transport type.
> 
> However, it's expected that we will add more features in the near
> future. To facilitate this as much as possible of the text is located in
> the new admin chapter.
> 
> Effort was made to minimize transport-specific text.
> 
> There's a bit of duplication with 0x1 repeated twice and
> no special section for group type identifiers.
> It seems ok to defer adding these until we have more group
> types.
> 
> Based-on-patch-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

