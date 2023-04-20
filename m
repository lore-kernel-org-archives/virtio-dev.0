Return-Path: <virtio-dev-return-12325-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A78DC77B72
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 18:09:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A4CFD1EDF2
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 18:09:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 977CB986652
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 18:09:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8CC47986631; Thu, 20 Apr 2023 18:09:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 76EBB986634;
	Thu, 20 Apr 2023 18:08:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jN3a3HINM8KIPfsMSUgm9jrWp1WXka2NVNTb8VkAaGaCcUtVnJ6HT29IOMGmdbhXYiWB/DXHAQrlUsCRDQMrdrvtO6y8Ub9h9UBj1+c1gK0Yf7fu/lVZP3cDacUqYv0oDMHpFojgiOPTIxk9gg6RMTXgS5RNDN41ziogB/d30EgwEUmtguCIvzpVq/dBqR1aGWBD6QYMHPeiGYwszeXDJxCDiu0zv98vk3kZ8x/U0iNPggyz8A2j0vzho6U61/Go/BBjEieWBdQvUusozihBVjDm2leKcd+4UY0EEO4Nd+XtYNqd1N4Kt7ololSWxUgr9jgYgOb15+PRpnQl+pgQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKyRBRdsljsucQ2TBpgg1Wp+Ru6B25pB00Mv1w+av/s=;
 b=OXVvlwIImFd+UpMWK30sj0iG9nt/gHIH8XuwPQAU4TWbY+34+75eBazbY6J/S5ZLk1HlEOxhc2SEV1ZDm5VAHL2iEhWDRQrudstoEE+LpJZlHPnKEysLlCWBNgVdt/2VWOxSJJgn90tEUHDeT+rg0ZQTQWmnJ2vFj1FXRmRIKKnd0cP3TqVUTYvm09itJRvUKjNeKL6M6cjYPmSUMlocxwqZlydqhZ25d/nsjrhWzkee+BkBwxc1BTMRRsrB2LQZmaRciLMw6nMiYlSizBMld5I4SVAr3djH7xzBgRT5Y9Lke4dQ18PkAXeBR2pXY94v+KnZn8E0LhXrCXM/xGqnUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <c03df840-80b4-18c9-c539-96796b027b1e@nvidia.com>
Date: Thu, 20 Apr 2023 14:08:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: David Edmondson <david.edmondson@oracle.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
References: <20230420124647.58488-1-david.edmondson@oracle.com>
 <20230420124647.58488-2-david.edmondson@oracle.com>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230420124647.58488-2-david.edmondson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:408:60::18) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ca47b0-f74e-41f9-c932-08db41ca4f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9tq74ru22v32bQ7KJyTX8/aqQ32e3Wk74LEE5S+WYxFVhgqgMcbGrsISeRLiUqxn4FW0X6nKfET7OkQX7gHk1NKWvcVE6rNU1wi9VDpSHW4EuQ3xVD2SsaG+2w/dKfshuzmuk70ApS2GJ18xncbUSOclUNTcJwkwjJzsUJxcrM8ZJm4V4pmJymnM+Nqicex0AAacAdI3v6pbEBOjkYUMEcMqn+siJeWLhvk8NC60PETRlxAN6FdOD9K8e2q8gUA3YdxMexr7ooH6zo4HXV9ARJSNyCjsQ6R6XB5/Tpm2xGsH7KRjnm6ICqFXlNiEC+QdnCiPs8d32mZ2JcnzDFzk76FbAUFowgz/1f0RBL6dblBD43Fgm2HsfZ5a9lAhQsw4FQMgvRyu8W911RNpTKKmxpgmbmX5RqypUAtqdAQJjptOI+zUTsS4I56eHBThnpXTObhIg7FXKNmlw1ygOy92hKUAWu1EUo1tVNjv+x5XbJgRJ08ge5ejbru6NOannL8RJV+lIDWJPTB1Z11myGSR4C6qQ/e0OcwJAOc0QFSvIZxofiXZG3pSR+T+ZHeoTzx1F1PqbeCaDozA9KUq+HK41ZBk0C2vK8lPsZKF1Y3axQIG9ALs+JzrmW5tmmZV/jjHC9/txwXGEsX2jAU/pA1w8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(31686004)(66556008)(66946007)(66476007)(2906002)(2616005)(86362001)(5660300002)(8676002)(8936002)(316002)(41300700001)(36756003)(478600001)(6666004)(6486002)(186003)(53546011)(6506007)(6512007)(31696002)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YytGaDdCL3RpLy9qSkhqaW5EVVdoazBHUEI2MkdVSHhmNEk5WjFtVlVnb0Ja?=
 =?utf-8?B?Q2k2Y2JBL3JNaWpvcFV4QWE4Z0dUenZlWitDVk5xQmZLb3dNeEFmUmdxZS81?=
 =?utf-8?B?NDlCa0pqMjY3UFZPbzU1Q0VNbHVsaXQzWjFYYys2Uyt0K3kvUm1qS2JlUUNq?=
 =?utf-8?B?ZjFBUW91YjRMdnc0T2pPZklvdHlFaEdURW9SclQ0Y0c1bmZlR0tPWTI4TmJY?=
 =?utf-8?B?SkxORGw4SS92ZjE2YmhtMy85YU9yVGNOOFZnaEhtV3lNckkva3pyajN0R2xT?=
 =?utf-8?B?bHNzQUZrYkdmYWVrWWFrSU5hTWRXYUJ5dWI4UGRxYVZTYWFDbVhCTDBRQWww?=
 =?utf-8?B?Q1pZRFVUOS9nbEg0SU9yTUt5clpqV1o4K2xBaEg1ajVnR2tYdWlsbHZoMHJi?=
 =?utf-8?B?bWNEaDg1NXEveXZFU0xrNUhYdGRzd0VJN0tRUzZKMCszRkpJYm1UK0R0ZzZi?=
 =?utf-8?B?dVhtUktvVlFzRC9jbGU2eGVqWWpkdmdsM2tPU2NzdkpsMWJTM1Y2RVZaMmVu?=
 =?utf-8?B?aGV4a1RyVlJKNzEyR2dwakZsMFpWS1BtaTI1UG50RStQbW5XY1k0QnllV0hF?=
 =?utf-8?B?WWFMSHEzNVlMbUdPUVFjdW1ad0twSVYwVVhhT1Y3K0t6OVZhRXZKZnBDOURN?=
 =?utf-8?B?c1dvZkx1UG9jVlNWNkF4OG1GbEplQTd6NFJKSkZPaStaaHAwRitrTDd6MGFK?=
 =?utf-8?B?NnIxVkNMUWZ0dDNKVkRMSytXN2xhUFByS2pES3ZoMmI4S1J2T284b1RlWWI4?=
 =?utf-8?B?NGd3cmg4Ylp0angyTW4wZUxKc2J0dllodldwdHNUNFYwWnJEU1MwcVRNdnYr?=
 =?utf-8?B?MlpSZUE1M2J2OHpnSXBDdTVYcituNjlxWmlyOEEyVUxnK1N1L1dIVW5zbjBk?=
 =?utf-8?B?SGZOS2pmWWJwcGVwR1Z0QTRKVUVVd2hCQjJVY1N6LzlQWTgvK1NmQTE4SUZl?=
 =?utf-8?B?U2tqb3RLTGdYWE9QWHo4a3oySWc1cVNKQlFvMTRDU3laeWtISHRqMlVLSFk0?=
 =?utf-8?B?YUhHTFp2K2xWd0FuLzljVHRlNVp0ZnNHWXNXL0xTUVpBaW9oL1BFOVNGMzJo?=
 =?utf-8?B?VlRXMkJFTHhQWndOaExkcWRUSG5JRTRXSkc0WnppbWgxQVU1VFp2RVNmN2ky?=
 =?utf-8?B?NU82dmRpaVd4bVUwT3NIdVVKTWE4bUtzc09KZlF0eEhRU0dFaHdGbFNuSmx4?=
 =?utf-8?B?QnBTV0ZUdVFvY0x3cTluckFtMXEybW5ST3MvbVd1aTVvWTZINmxTTGk0UnNi?=
 =?utf-8?B?Mm5PZWNXZ055d3hZM2x0aXcwTUVhVnVwZ2d6OHV4VVlGRGJ4bkdnQkNrc2lM?=
 =?utf-8?B?bGwxandIaWtWMzBLSHEzSm1IUXZhcVlvMSt5YW9aem9ab21GTkh2VkRHa2hL?=
 =?utf-8?B?cS9xaDlVaDFUTlhzdFEvaDgyR1FxS2dSc1piZEh6cEF3emZ0UEtKWnZOQnF6?=
 =?utf-8?B?cndTeDFHdWxNVXBZTUE1eDM2eWZIZ3owbnBLaUNXcHVlL3JZZjYzS0hXSHRV?=
 =?utf-8?B?SWJwK0txUjhkdDh0aytTUkxzMWttT2R0SFFRV1N5QUUzU2czN2owcXl1OWNY?=
 =?utf-8?B?ZlMwYjZib2VnTk9ScmNhbjAzcUlEb3pWdkd1SHN2TGV4dStha2JlSHdWbU1h?=
 =?utf-8?B?cUJJQkg2RU9lblV3anZURENkK1ZpbnQxL0w5anV1c3hKeGYvWDQyWHBxV0Vx?=
 =?utf-8?B?Rkp6Wm4wMStiNUZpVXZNVXd2d0d3amRaWlVmVDFUN0VtK3IxTElSUHVYcEF5?=
 =?utf-8?B?cXdFZ0hjVTFvV1NDUjg3d2draG5DNkhPMTM1dHlTL0JqRVduRm5SUStBTHdJ?=
 =?utf-8?B?dVZWQTFGRnlCbllhRHFHWUZkYUozTHlFS3p2U1RaWDhQQUI0dDVtKzJUMVNU?=
 =?utf-8?B?V0pabUdYNGhPclhqNFY0d3pHN2xmR0ZjN1RTNDdRSUF1cmhZaVVoOU0xdGxR?=
 =?utf-8?B?bmthVEVLYnZmaVI3K0VrZDF0a1djQlFXV1JIaGVJUjZKUXlZa0RGMVJjYW1U?=
 =?utf-8?B?TndoZFd6SU9GOU1xUUpEQTZhVjZQRnZkUGRFWFhvZjVFRVcvOXBDYjZIcVRI?=
 =?utf-8?B?ZGNWc3FpK20vWGg2Y1NESGw4VjdvWGlzTEJKd29GTEtHbVBaK3lCd3o5MnM3?=
 =?utf-8?B?WG92K0RWVzkvYTgvZmZ4eXlHUE4xZ2pMT2hjbmV2b3RqTk9HQUpFb0NlY3Zs?=
 =?utf-8?Q?ojlDVViUHqLlbHVOHZdZa86b1h22KHMmRp9Pngbv8/m+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ca47b0-f74e-41f9-c932-08db41ca4f1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:08:57.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUpmZix8bpUeFLRx3XUzR5zuXP7h/XUVe57tiu8q+e6dnR9JkYIcN2BQbAyKAh9H3gbJXDHxNyvLGWTjDPAAKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 1/2] virtio-net: Minor wording
 improvement



On 4/20/2023 8:46 AM, David Edmondson wrote:
> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
> ---
>   device-types/net/description.tex | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 875c4e6..8aa7953 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -815,7 +815,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>   
>   If \field{gso_type} differs from VIRTIO_NET_HDR_GSO_NONE, then
>   the device MUST also set the VIRTIO_NET_HDR_F_NEEDS_CSUM bit in
> -\field{flags} MUST set \field{gso_size} to indicate the desired MSS.
> +\field{flags} and MUST set \field{gso_size} to indicate the desired MSS.
>   If VIRTIO_NET_F_RSC_EXT was negotiated, the device MUST also
>   set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags},
>   set \field{csum_start} to number of coalesced TCP segments and

Reviewed-by: Parav Pandit <parav@nvidia.com>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

