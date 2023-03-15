Return-Path: <virtio-dev-return-11639-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A038C61DA4
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 23:25:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 34E19157EEA
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 23:25:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B7F7986432
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 23:25:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1F9C6986259; Wed, 15 Mar 2023 23:25:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E8B798637D;
	Wed, 15 Mar 2023 23:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxZcpA3jVSdVVHac2fQ09h+3Skt98kbZ8/wQR5e5M+97PF3P4MKTNYWDXhSu3GwETJC9pBw5Rq9x326T+4DmDpBGdpD/CzmS75UFQzxYcuf5kZmSpD1gwxoER2cByn6Fzn6zqve32AVDreCkhtmorVgn+2+YiMmTuB16ladvRzrJ8Zr4WgroCRojwW1LNzTK6Je6J+eDbFpW5JkrcBBcqiRRkDN22V8Og6MZVSxM3T7r974HG2glE/FZS0WPaYvVyi2skGQsWsyE1ZPyMxPLEqG8hzoGkNDj8WI4CDhAsDgiHzBAaQ0hV7qYEC6+t8MTbm0BJ3mjEWPJ6dCZTcvZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAhOv/f3IQxCLxVa2Gzsjb1/qsa5n0ARxxLIwVZwPcs=;
 b=TPYXuyMTXcG/oq566qFZ38VPTHYLy1KDLdn/HeTIWUQ10eHkPnP/ABuLSfyNrjlIgBvKTCcp355Snp14ZcTbbnhHRg/fTDX9ZzYDRycnuZDsreNBxbphWUmaXiLAwfrr+kp8u5O3eJBPAOaC2TTVSxnfFhjCS5QrvjF4/gdSjuxVZAF65EyVt/qXExFPnOwHD49jHSICN70/prKBpEwei1J0iQU13B4wD2sKhPS3M9hHwxJHe2F5/Fl9ghC26alT1EqfU+iRoZ5z8IgTOisdvKpMzMLsWm1rtUw1HD3D7i+DYUQwym5c+3BcAIQW8SpAHOktGCwcLjk0kM/WvVnF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <11cce86e-8068-2e83-9fc5-e1b825adde29@nvidia.com>
Date: Wed, 15 Mar 2023 19:24:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
 <20230315075954-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230315075954-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::30) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: 3139ca0e-7bf4-47bc-f9ec-08db25ac7fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	//M9Ximm60bd99vdVpG+Xz/6QENWoVrWjlrpv4HHkk5eYyZ7HX9s6kqDYBPSacIlGzLI+l+3o9nXf6cM7amy/VK8SwiCAGcZXUbbg2Qg3RrUt7IHaAAkimgbhXGwOxsNzNQuCtXMA0y/aply+Ywq3thitiWVnjVpKqGYrc20FPQgqL8cqZokn5iJKGaShO+TiTWDhpf3iZMu4ZATG8jNuf6ZmvwBhtHMRf+vRw/Rg8K//UKkWFwZVFhl1Uj0OxELIA4KMJUbXI30g3BWRDSdTdhSKyx0pidfNclTwpOVtBLuShArEzcEwi4RyebgXcxuhZ3ebHHcZG08iEGK+rRp977V8hdhoHH7OqAKWlzjpiWHdVpeHFgW4LrGDMSzgku3M7b/Uh+MxbkFPb3vMPaWZSAlL6th2R8VBV0FCrkIRJ9F5RZXJ8NHyKlRRP+teTNrSzTnjBtXFmkbGaHVgmgjdr+wKk1IxEGpxqzlxry1TfqLDs6tQLt9D/eaEVuQLm6hEWtJXLUzBPqXEi6jNd5Guwt7QOGJqDa2WR+6lZDOeigEdsmYrNiu31i+e489dq+ePEtk2bwSSVL+mG1/9+yiarhZW8tfdk6E2dndNolGUy9mh6hq212L6BPSKpt360v64YsWLflUBlAFcIcnV05o8QVgHAS0N66EV+uHmiC8vTBChgFHCJPJdP8EgED0aLt5k6FshT83Ul+/kBt1MrCW9jDS25EHGSmh+5mNq7Di2cA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199018)(36756003)(86362001)(31696002)(38100700002)(41300700001)(8936002)(2906002)(5660300002)(26005)(4326008)(2616005)(6512007)(53546011)(6506007)(186003)(316002)(54906003)(66476007)(8676002)(6486002)(66946007)(6666004)(6916009)(478600001)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3QxWnZCUFBmM2p2QTY3ajN0N2kxMWFkUFoweXpEWUxQbVN3NlU2K2d4aXcr?=
 =?utf-8?B?VDdrdzVRUG5OODJkQ1ByQXdRc3ZQS1lHRk5wd01RVlpKZjN6K0xscDZldXVQ?=
 =?utf-8?B?MnBFUUUxclZVQkFPWkljNmVTbjlBbmFwRGxqbG55dXpCaU1wOVREbUI5aUxr?=
 =?utf-8?B?WkUyUzExREg1Q0xPMWFHNFVuV0F3U1c0enpsUzlubUY2T0dQbk5jRUJ2eGt1?=
 =?utf-8?B?Qm5YbzhlaWRWcGplcy9kdmZnSFlxYnhIR2ZxdGpwMmRQbmxEWmtuSzFFOWwr?=
 =?utf-8?B?S2hMdDY3T0NPR3VsSFFlOUV5ZkV1SEVjUkZQSTNoWEtqajFsdlQ0YjRDQUl2?=
 =?utf-8?B?WEJrOTRMVWRCaVhOOXo0MldZYW9wdUFOSzZiSlNIM0grcmh1NUJyOFA1RE83?=
 =?utf-8?B?MkpuNE5lL2IxWlBaMW96Z2dLQks0OVIwQTdVN2twcjh4Mkw1K1JKbHRDeDQy?=
 =?utf-8?B?QzdkNURZRWViU2FTSUFkaU1sVTBOT0JJZW42bEMwZ1k3NnNBcFgrNElnbmc5?=
 =?utf-8?B?TUtUZXpqWld4VEtxOTNRb2VISFpYcFRzc0hEVVRZTjF0MXNMZDN5RVZGVllh?=
 =?utf-8?B?Ky9PYVVsWkRDZVA0ckVRN1hSNjdmWGhCVzNZT2xnVG1veDk1aEhSUVJGVW9w?=
 =?utf-8?B?czdZbG1JYUVOME5lWE5IV1cxTkdpTmtrMjFVaG5YdGVCVzlVSEVoVFlGSzA3?=
 =?utf-8?B?ZThiZXZtWGpNeFNtb0J2L3FyNDQxbGFaOWQ1QUJXc0hKTmJXS2x2UmFabWs0?=
 =?utf-8?B?aStmMHVjeU9xd0ZHUWJuTStyOENwRm5TWU9YTUpVZGFSZUs0NXJnZkljaFFF?=
 =?utf-8?B?L1dReEt3UjlCS0xKREtvMnZRbFEwK2t0NE5BTVlJZE9hakcvSnlGZlRkVkVD?=
 =?utf-8?B?YmdQUXh2WVo5cHQrSnYxOUxvUzg4THdyYkxMZG9hUTNQcm11OVpqVC9nemw2?=
 =?utf-8?B?U1NrdVhnYlVkeDJRcGxTNlBBZE5LazlvVk1Sb3NMRnhVdlMrdytRd21DVCtR?=
 =?utf-8?B?OGIxWUFYelEzTGZPbWVPOHdiY1lrLy95VXhGSkJlY0VYdlRkbkdIMUMrSElU?=
 =?utf-8?B?anY2YlZUWHF2SUkxcCsvVG5ScUd1MEVpWmttOEtrWEI1YWVUZUlqZmZPMFJZ?=
 =?utf-8?B?dnRvSm9iV0JzSVptc3NzVmNEWDBIZVgyZllMNmxKaTNZZngrLzBaN05tTXNw?=
 =?utf-8?B?YWJBYjNnaUhTWkgwV25HMmNVN05TQUNJK0NQYUJuZlY0V3hiY2htL0dTd0k0?=
 =?utf-8?B?Q0UxZmsydk4za1JmK1ErMnFEZnFRK1JhYjQvVFFNNjVwREVNREdvK0FEcm1L?=
 =?utf-8?B?ZHMvOUFzcU9KampzbGZwaEsyWVh1RTRLb3lpMkFJbDJiYSt1VlZuSjhOY0RG?=
 =?utf-8?B?eDRFN3I2emkzRk85TzVjakVlemluWWVFLzFoY0szNkQwU051TG9Cd3A3NzFQ?=
 =?utf-8?B?Vjh6U25RWWF2UkRVTEFvb1B1QkVLcEtCMExtaVJGQ0NLZ0dRdXJvdzNyNElO?=
 =?utf-8?B?eTRyUDd6M2pNblNDSUNCdnVFRFdESzliSm1tVUZtWUN0K1VZaTRpeHRFNTlB?=
 =?utf-8?B?aERjeUNaUlhuV2R3dFA4UCtqK3JJaWRyNzVBTW1SQlplVUk2Tk9vL04vZ2xT?=
 =?utf-8?B?UFRnS1ljNUNNSFVjUEdkbzVhNHJieFBhcG1oaStsVDJsd0VXa0J2bzV3QURE?=
 =?utf-8?B?NFZDRVhNYVphT2pDMExJYnBVdGpVYldJb1FSRnR2eUZObnNPSTBYR0hJMHRV?=
 =?utf-8?B?Ykh6d05uNGRaMW5SRVptak5CYi9sams1V25pVkNzL2ttZjQ4TXVtY2swTitu?=
 =?utf-8?B?eGN5MWllWVpVaGNWYjZqSlRRYTNCWWFVV3E3TDljY1czQW5IbHRQZ2REVkln?=
 =?utf-8?B?aVVGeDJQVG1YT2RIbXdqTUY2c0V4SUFiYTVCSm94bUZ0cW50Vlp3d1ZYOVU0?=
 =?utf-8?B?UXB6Q0xrYnk0ZGJ1MTlpQmtINTJ1UTRuS244aDcxNENkMnIyS2RlSlVIbDJt?=
 =?utf-8?B?c3JHSEJMMFZ4SktqR1VRK1BJMGFTOXVjUXIwcDBYZWRITi9wTkZhM3Q0Z3NO?=
 =?utf-8?B?OWJ3eDc4dmMydmlUYjZFL29ucjh4R3E0WVhLcXFPbitLK2dRYjZKNG11RTcz?=
 =?utf-8?Q?chSH5ICfgs//sKAh58x/BF5Od?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3139ca0e-7bf4-47bc-f9ec-08db25ac7fe0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 23:25:01.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e67Fg2z5AxDAnPQGGksuNhwkYC6fcwFICa2p7UbGExvZjiQb/b7juFUqCNi4zzJ5vQSXKgjONqRZs+hX/AoBZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v10] virtio-net: support inner header
 hash


On 3/15/2023 8:10 AM, Michael S. Tsirkin wrote:
> On Tue, Mar 14, 2023 at 11:23:55PM -0400, Parav Pandit wrote:
>> If not, for now it may be better to skip vxlan and nvegre as they inherently
>> have unique outer header UDP src port based on the inner header.
> 
> So what's left, GRE?  GRE is actually different, in that it's not IP at
> all.
Sorry, I wrongly wrote nvegre above.

IPoIP, GRE and NVGRE are left.

vxlan and geneve has the udp src entropy.

> 
Not sure I understand "its not IP at all".

GRE has outer IP header + GRE header with the key to identify the flow.
The key is effectively the hash for the flow.

> So if we are talking about GRE, hash is indeed not calculated at all at
> the moment, right?  
Hash of the outer IP header of the src and dst IP can be still 
calculated currently for GRE when the optional key is not present.

> And I would say a natural first step for GRE is
> actually adding a hash type that will support this protocol.
>
For GRE and NVGRE GRE_header.key as the flow/hash identifier should work 
without inner header hash.
Older version of the GRE doesn't have key, so inner header hash is useful.

> How about doing that? It seems like this should be a small step
> and completely uncontroversial.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

