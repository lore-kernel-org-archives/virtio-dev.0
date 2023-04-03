Return-Path: <virtio-dev-return-11913-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F1BC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 16:00:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E5823F552
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 16:00:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4614A9865B2
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 16:00:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3711A986418; Mon,  3 Apr 2023 16:00:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A9FB9863DE;
	Mon,  3 Apr 2023 15:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxgFJykt9UaoV5F8CM5nuM7z4iP3Jka2h2ZeogeHa5T3d/DwHRUkXHOmLZXWl6bbcC6LEy+zSG0Iz6sH9H/zSqMcCZC9zjeTekLj1df4IMi3KJQm0WFLmuW9EKUwqTMgJW7CcP0zP9BJviz0ZbgMMb5rojhaq+HVxfpcVWpCx4TWoZmVNHqTELcVYl9T93QGeG5LwB3KHdLA9FdznjV6zXCZOqTQ2hM59rdFpp/7G+LADFfEowT5yjE0ymGJWdBX78rD+R+b970MgmI4vZ5PmrewBfFnf77C6WBcvaKz/d3dZi0XBRBgBySZ4PbSWeG4L8xeRx03I4unLI0fzS7HuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iYtGv07cugoEmosgneHLfea7E21QaGZUitVLQ7AFwI=;
 b=bAitdyUZUgQgheLOt2iOGX6gDBqGvV6WGs3pHTIRSwZCvBx8ehLFMNatVgj5BEXRzkba0Rjlq6dd3zCexv9KB/dpLLD4IM3QeJlwHh3zjR84RZhJaTBwdjwJfWSc51oWpW+OTdwUQb109BSAFGI/mTL9TpCFj1r88qv2B3ivc39ahmMGq1xPYXhm/Tl4o4REZVKOZHvhdEVYd8X8OD4C3vNINb1sw4S8J6TeL5x8kV6y+QXRc82pL4bbIu/1u/PQCI4TVfkN7C7Tx56RXTZx50AHPUBxlIkBr41heX1TAqlKLjnmZlEWiGQ4XYCPiG74qW3lfpDGUX2T6oHk/lV7SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <cd24071a-59a9-b2ae-2bdc-882f1ebc5eac@nvidia.com>
Date: Mon, 3 Apr 2023 11:59:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
 stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
 hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
 Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <cover.1680533760.git.mst@redhat.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <cover.1680533760.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:806:121::11) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 52eb7694-5965-4605-473d-08db345c77f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q/k5iQYRmc1PgEpMfCAex8MJbt76XvZMe0TPQcsmDyrnPQJzukdJTV3szcHMDZ5N95Q1Avdd6+7dUb0SOJnCGjD6S7Td3LEf1ArWcgzN+wBThKOdYMVg4g4pkZq0XL+aNAm8HrgfzBP72Qd0niZA5Zq57mvtLmdJGYDeoeBmIwaDWleQLhQSdWy8b6VKfBW1qrT5iiTu+PeJXCSl9WLHOu5NW8qZS++kLiL/urnXiz0Oj9BtQ6BASGNiwJUhE0TwwE1g2d1xroe/NnNkv/+oetx7J5TUmdTVED/tuD6Ge2W7AlcJJh5dyQGJd3ytg02+g73RJ2xDwydnwGCIpvkDPSfxS+9HnOie5XGEzkwC2c9R3yj+yvhx4ei4PQMQOPj3CAv+kGnRmD2UtRV6l7Bvc6l6ftgbKwd6Lb+tlZGEtf+2SplLIFLDLuuKxjbCoJM3icvr+rARpJLHySt6tu9niM6zy7qztv28bpeX0kC+PtaKyJ5aNdUoGnjX4PViFH3HneNan0MbgjWuH6NzHXVEbBnlE7TTqMo5PG40vh/2WvJaRiM+Om4TF4SappRnw2tU2OE2DkLi/t/3XoDo0pgbS6mvW7hApvPy5VcOf3dxpmxWDtS3XT0a6WPzjPhf3HyXxfdCEK1jxlNAmFPjfbZ/XC7vV+/IeY2HIVPNNgqugPQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(107886003)(6506007)(26005)(6512007)(53546011)(6486002)(2616005)(186003)(4326008)(66476007)(7416002)(8936002)(66946007)(8676002)(66556008)(41300700001)(6666004)(478600001)(2906002)(316002)(54906003)(4744005)(5660300002)(36756003)(86362001)(921005)(31696002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEM0bVhCQjUwQ3R6bkhwRjZRSmxOUlFlQ3hBS2JWTlJuRnZHbTRDSjY4bHEr?=
 =?utf-8?B?emdvOWkvSjFBSTlSTUlWOXFjMEdzbFMwWlVKVDU1U3VsVy84TVFKS3d4MFFv?=
 =?utf-8?B?ajlJV1o4SG1iOElQdlhjVGlYby9wRjBKY2t0RzZDK1c3b0FrNysrZ0d1V25w?=
 =?utf-8?B?dW96RS8xUmJtRVNoT25uckU2S1pqdmVQVWdFZWhDVUkvRGxQNEJBZFJ3QUFV?=
 =?utf-8?B?RHA0MkNSZXZ4azJTU2R6MU54VEpmYitzS3JCOHkwY0RKY3I1bjdSeXFraGJt?=
 =?utf-8?B?SFIvS0ZFRkxHWVlqUmVFMXFGNWhZTGpDSmx1Y0dCQUxqWXJYQkYwRmlpWEly?=
 =?utf-8?B?RzhsWjNtY2pnVmdUODRwd1l5anM0RzVuQlZrdnZDVmsvUXFmamg4NmpTdHFE?=
 =?utf-8?B?ZHhvQnBvRVcvbWhXM3NYZTFROHlxTUFwMXZkMTR2VUtkY1JzVkhjRTJ5UkFQ?=
 =?utf-8?B?Q2hqOUI3N0t4L3FHaE9vb1huL0o4RmExL2pyakdBS3hBR2RZajF4OG1mWG9l?=
 =?utf-8?B?aVcyL2tqMUJHRkVrV1JLaUo3V3VNL2NqQUdFSTJmYlg0RGRNZmVaMVhjeVRy?=
 =?utf-8?B?Ny9DTWJWZzFWUUpRT3dwdEZXQitBdXR1VVlicnUycEFucUx3M3pKK2NZNUdn?=
 =?utf-8?B?MGNJNWFpalFJenVKNUp4UmtDOUtzRWdtUFVmU0RMZkFhTVNwYk5Ga290VGta?=
 =?utf-8?B?eWxjQTczelRQSTliSDdkcUVPRWRlUWRPcnhiVEIxcFJ1dVBtUXBMMHB4d0JY?=
 =?utf-8?B?aHFGTzUwT3RwSGdGY1JYdGdiNmpPd2tDNngrVkExK3YzMEFZWG1sdGVWVlJY?=
 =?utf-8?B?YkZFTUxqdEt2ZVJ4M1o1V3R2c1NEUHphMy9QVGRPSnV6eFJYQVFqNmFmUmZ6?=
 =?utf-8?B?MVB3S0ZwWmJyQnVNNDFqeU13bFN6azFEUGtnSklEdDBzSkIwRHdCOTh6WGt1?=
 =?utf-8?B?bGRaUGEyNk92bnptMHlUY3RtMlM3MFllcDd4YUVSRDlZeG95S2ZQbC9RVmpB?=
 =?utf-8?B?ZG5vc1ZrMlZlLzc2ait4MGtBYU9CVDJvd1VRbitpdGJMT2pqMFRxTGtKMHlU?=
 =?utf-8?B?M1FSajVwNG42Mm9lcS9RMWpLZ1A0U2YzQ2FNWFNLcys5R0NWTWhQblNzUXVt?=
 =?utf-8?B?RytPMmJkVXYwL1V2dzd4NjBKeTlmRkVLY2RyeG0xa3JPdTdlaWZEWTRjVGlR?=
 =?utf-8?B?dzlPd0t3TzJoMkFlTGlSWjNXS0EwL01VVTJQQTd2ZXBzd2RWOTdBTFE4YVdZ?=
 =?utf-8?B?bnRzSHlyVTc4Qm0yQzhlcWJQMWI4aWVxK3kvT29lb2F4OGFKd0txcjdJUjVT?=
 =?utf-8?B?a2U5WnFWamVJSUcyM280YnRmUWtMZUxZU2cvR2RZMnk0QUk4NERGSVphVnd1?=
 =?utf-8?B?UHZndjNqYTVJMVhaYThucFpNVk5TVCtLNkVhMWxnVzRCbFhIQ2RyV1VvbE9W?=
 =?utf-8?B?cXNoODdNTDE2ajkvZE1RemxSVWd6dGFEVVdHUm05SVRoTTFwaU5LNVZuS3Jl?=
 =?utf-8?B?akVGam1UbS9XNUc3TDg0c1Qwc1c0UmRtV0FEK1RsNFBmQktOamFJVlNKdERF?=
 =?utf-8?B?VTZTc29iaWdENDVJTVVrZGFyQkVwYVozbGRaV084Vk9vbGJQdWtWQ2c1ZzUv?=
 =?utf-8?B?MlEvNmQ1ZWNicVp5YURnQytnQWdURU5Walc2eTZuTW1PZy9Dcm9FU3dtcE1q?=
 =?utf-8?B?REQwazNBb3F4TlNpS0VOcFNMUE0yZTBkSjBKVG1UT1NSRWI2UUpmbE9OeUpr?=
 =?utf-8?B?c0xObVVreEtrQUlDdzVVRkpKbFZVN1NhZm9pck9UMTZOZk40bURwY1E5WWRV?=
 =?utf-8?B?WWIrOGw5Ny9KQTcyNmpvMDJIRFNvbHJ5VHU5bzBsOUk3cnBSSzB4WS9COFUr?=
 =?utf-8?B?a2k2aHhKOVQ4Vk1VUUN3bnViZmNYYmxQYWpoUkFqcFlBbk9xZnhjZU9BcFVC?=
 =?utf-8?B?RExhRy9ZRnVST2FRa1ppL3ErVk5TZWxYdDJqTUt5ZDgveE9hL3d4Z2p6THVh?=
 =?utf-8?B?dEdsNVF4TkpTTXJDbEVHZDRFZWdmekRvRGlpWjFoZ0tXajZ1MkNhcDVJRWkr?=
 =?utf-8?B?ZU1LVVpaUXVQTldMMG5RNVFQK3NZUzNPY1lpNEM5ZGM3MUdnNmtUZkc5Uk5G?=
 =?utf-8?Q?nhijYvma54uh8IcChbsmHHvhk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52eb7694-5965-4605-473d-08db345c77f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:59:55.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvXYLI1sZqXdd9555hPrUTehmXYcDUp1c28qznEnkpa/txypLhZ2FR0cnrlfFb1+k89p+ebqlm5pAUjDKsoKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
Subject: [virtio-dev] Re: [PATCH v11 00/10] Introduce device group and device management



On 4/3/2023 11:02 AM, Michael S. Tsirkin wrote:
> 
> Change log:
> 
> since v10:
> 	addressed lots of comments by Jiri, Stefan. Cornelia, Lngshan, Parav, Max
> 	Cornelia, do you want to pick up 10/10 separately?
>
structuring prep patches as 7/10, 10/10 as first patches followed by 
6/10 is more clear as it builds the framework first for existing items.

But not a must item for me.

I am ok with the current patch sequence as the change in 10/10 is really 
small and issue number is already listed in commit log of it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

