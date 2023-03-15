Return-Path: <virtio-dev-return-11638-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973F2C61DA4
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 23:07:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D0F3187486
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 23:07:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC1B1986434
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 23:07:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C14EC986259; Wed, 15 Mar 2023 23:07:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A85DD98637D;
	Wed, 15 Mar 2023 23:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqBk+OqDX3q+M6Hq+uRuZvKhYnLws5gJlUKacI6ok3ht+uLq6zw2lPCAC8m0s3xaOYsUNWnXwjApbngwSUv49g4mJ83mIGzmZZafYysZwWFy0iakpWz2VyjxQuAbIgNiG/0Dy5kxd1uZmuaVrmTKnfBB7ugkjkFymgvFYIWKJ281OD6tlBg0QCH+oOcNRlKKHc6/uJhS/INDnuAx1gXsyog2MDL0nJnXOIk08RJcB5yLazsDR5MYMD2XuFyka2cnpx6ga5xHzpLITuQq+TPw0LYA/v0pjo0nXsswE3Dh+F/9BiOZa2B4MNKhzFAR6tr6di+RimaaQRPUxYLDgx9vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpsv3awN8mKPjEsoi8VVNapzHW0QiNUHJfztZ07Q1T8=;
 b=XX/gIALD0FqFnEDTzJWEeMzonNymtpD6tkLukD8TRa1rxaX9CSVVzmkPX/Yiz0zP27tollgqjjZmbOMVlgmnsGIJKK9mS3Yoi8JU0A11j0JyEgXkxQuJdmla/ypZqS5yVNLaobxNt8hIKdx5O1PyZ+avSlNaW3vJezuEsJP6r1aT3QkYPj4M3Kbf73zznilYwHv88I6Lj0SywVbIFpGGn0x1UCxpXTdcF1su1B6X4pA09MS2fGGlEVVaHpWzzzVWj22W3VHFlm00NixGDbr3enIo+UH13kTTzaIakSOhAGEq85SODyn82/GtdiIOlj6c1mkdmVdFSeH4OcpL62hsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <9f6286ea-51b2-dcc0-86c9-66509d92d8c2@nvidia.com>
Date: Wed, 15 Mar 2023 19:06:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
 <e573702a-9a2e-d210-f13a-f0b241442991@linux.alibaba.com>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <e573702a-9a2e-d210-f13a-f0b241442991@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:806:27::23) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a51075b-38c2-4b5b-b01d-08db25a9f957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B4xnDaTHImvkjYuitiwd5MGyZ1Rno7USsiJzNojxKvtjrlTDT2GRj0ieZtKzdvMTHH0VkGyAPrBZUaAGN7KZozhdnhOVkhbsGz+kLL3VM7bOia81i8a+DoOBXKLyqFMIhtQkEIaz4213kLMMIrEBXOQaJ/WDRRgG7m3Vc6hb4e4JYx7JwMNsQrqilvqUCvlE/kp0DMYDNx1nIR4X4gxIK+C9wAP1JNxqGVrwngUgXLP3Sivi+oM/2ASPOorJGmM2KKPSfFD6k/DXVLVYkpQ8c/PVF0mahFeWs0yHgr4D6wrtI5b7jlI4wd+Kj9Ak7Mv1DROKPgX4+r0inGWyKt1cPVnar8uhWXP3BAxEAqS6N5/k+gFDAli4O8ub+SuApHSdBYuNbxEipbi3CY56p+Uzn7oKETBnpYkBzMdHBf/9Y+ZXQdqWXUvfahNmRApwE1QlXwNcWzhcUAfyQs6J2SP3cFC14CcwE+H1M0/PEmNnPPPUmoQxCcRlNby4jQs975QLgc/96rdLqhwYzbAkEyfl6p48+4uQ5uDfUkTi0OZwqrsw+YF/K2YOTsBBeppHg1Fb9N5+EC0AZp1JHoYiOeu8mjDH7srmnlfSdmFlp/wY3mnzZk4i4IobU8byawvDWKCG0m0vG4Run+FKUAQONQR/IMai0GBnfm5yBnJQjCSJaSB+kKOXXBw8C+DQsNqsNeIj2mvrvytqC7nLzKUpBB0Ou6r5Bun+uYH3zsvpDo1wynE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66556008)(66476007)(66946007)(4326008)(8676002)(41300700001)(2906002)(38100700002)(5660300002)(8936002)(6666004)(26005)(6486002)(6506007)(86362001)(6512007)(31696002)(53546011)(31686004)(2616005)(186003)(36756003)(316002)(54906003)(83380400001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjdEZ2hhYjFrYWtEdWRHMG5DNk9sZDRvR1plZUh1WURmbnF1VDk4Y3Fwa0Ir?=
 =?utf-8?B?enJUUDNCOHZDelE0bkZDOURydUJvZ3dXYit3Mm94QWMwVFA2MSszUmFia2h4?=
 =?utf-8?B?Nk1sMWdobVhJMEVnVlFVVElsWW5HMlZvUExRYWJ3SWJ5MjFUTVgrUkZTUWtz?=
 =?utf-8?B?RjJwODFoOU5iREVuMHpTd0hpdllZM0xObEZhd2pFN3FJV2Q1UmhWTWJOUmRX?=
 =?utf-8?B?QzBjNHVVaGZMNGtwWms5ZXY2emM0YXlkdVliVzJQcUVzNU9NTUhsTVpRckVB?=
 =?utf-8?B?MUdHdzI0UVpUMU1BK2owSnk3SG1lTzdYZHJjbGFkWDFKOURCQi94SEttWVRG?=
 =?utf-8?B?ajNjQW4wUkNHejFZSEh5eGRpVUw1S2hEbnpOZWZ0T3NKd2UxSFdoQytpZ0FK?=
 =?utf-8?B?OTl1d1lOYnNoUzQxU1BHMGUvY1JqQ3lQRkh5N3g4dXlDV2tidHhjbE9hQWZ0?=
 =?utf-8?B?Qm5FSk40VlowLzFkU3NCL1dRbmlxRnlpazBmOGQyOUp2UjhCcUorRGpzOEVU?=
 =?utf-8?B?REJJdDV1MWRiNVpBNll6N1ZSNWtxQXJGcDNuZzJodFd0S0xqRFNmV1cwS0tJ?=
 =?utf-8?B?QjZZVWdHNml4VlpOV1J6VnVGZURnbVJhWjFKTThCZHRtbW10YlVLeTVyaEFj?=
 =?utf-8?B?dnlHZ0dzNkYzMzRpclRVVjI4aEwzZmRoK0xhZGZVblVyVlE2a2FkL0ZFMFdE?=
 =?utf-8?B?M2tFY09oYk5oSnVIOUVXK0hCaTBvTTBFQmNydGg2ZEdVTTlwSlF2N2RPOWNL?=
 =?utf-8?B?Y09TaXZnS3dtSjZncElrdkgwcVAxeURlajJLSHZydTlOSWJpMzdPZjRMekFO?=
 =?utf-8?B?UGhENUxwQ1EwRVRGRDlJUnlVVVhQR3l3MG1YamZHNXg5VUozejlTN3BQVE9a?=
 =?utf-8?B?eVhPVTk2WXNHZThnWnZGMG5XNS85K3FTVGJ1b1dZeWpnaVNGQThKVUVkV2Yw?=
 =?utf-8?B?Ui9MZ0g4bHI4MmtRTFZYSFhsajliWDNFYXdFa0hBeTYycnJrd043VU0xbWdO?=
 =?utf-8?B?bkZlVkNiVEFSdHAvemRnQWEzdzVHSnFLUTR6Nkg5OWIwVkFKZ0JDK253SjB3?=
 =?utf-8?B?Zzh4TmFMdzFJRnVUMS9maGplbU1aSXp4anpId2hqUGwxYWcwSTNpQnp4bnlw?=
 =?utf-8?B?QWlRZFRyR2dnMGd6WDVzYTd5YTZhcUVndXljY2s1RFRGeUcvNzZyUWhpMjl0?=
 =?utf-8?B?K1IzdzBaUnQ3TGFUUllCQkhiQzN1T2dpcnNnaGlBcTMwc2NJWkZ2ak5ORTM3?=
 =?utf-8?B?Mk1QVDVtMWR6ekN1djZaeG1EN2VIZlAzL1VFQnVUUzJGaStTcHNzbGxpbUV4?=
 =?utf-8?B?YlFUK2EwYmd6TEYwMWNIMjFDQ3B6Z0tWaTVrV3lzcmlUOHBwWWR2bllhMWRo?=
 =?utf-8?B?TmZQUXBMY3lwWnRkVUlBTzY2Q2JLNVc1Y0hVUTJtbkNpMnBFWWM1RDY0OG9F?=
 =?utf-8?B?NnltaUo3bTZOczFZYXM0bVp4OHJMaTZvcXFrQ1E4VWxHMFhpbE5ocUp2U1Q0?=
 =?utf-8?B?dEFXSlp2am9WTklabVpsRzE5MTYzeTl5YmNQSkdQMXhQMm1CUFBIZk9lbDdT?=
 =?utf-8?B?U2U5MWUyYTI5NUd2S1YyMDFFdXEyZHl3VW9nek9KMUU0eUxlQXJWTmFZNngy?=
 =?utf-8?B?dEZ0SDdRWi9IcGNoK0Q3cCtSM0RtQVBFWDM2NUtxOGlDWEQ1enBqVjIvZVU3?=
 =?utf-8?B?SHE5a01JN05zYTNCdVRyajFFakpqNnRQc0JacGQxUW5wTEFtQnlWRktwMEg3?=
 =?utf-8?B?SS81RVdvamY5RE4wbWVZTU5uTE1Nb1RkaGVleXlvSkc4aEZVNGxrT3NId1Bt?=
 =?utf-8?B?TnZWWHI2ZUs4cUxKaFdGNUVVK0d1U2hnekdhRFhUMnp0REhtUCtsN2ZUQUxS?=
 =?utf-8?B?dWNnM215WVloSzFzU1dlQ1poOFNKU2MrSzh1bUpoMEVFK00xVE8xM1pIc2xu?=
 =?utf-8?B?R3pjakQ4RWludmlFa2Y2ZEUzZVEyTGVyeSttYm1tWEZWdTVsWFk3VStJeWJB?=
 =?utf-8?B?d0Z6Vlp1ckJVUDI3L2FVbzYybno5ZEUraVFaWWtFWjR3eVRMTnJUd0JzSTRy?=
 =?utf-8?B?WE5nVjRtZk1nVzRjRVE4a2NZZ1FuSFZ1cDAyNjNWOTk5R05LOGdSTU0xYUJs?=
 =?utf-8?Q?EKMLKgsk8LX2gxtmH0ziEzECf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a51075b-38c2-4b5b-b01d-08db25a9f957
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 23:06:56.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/HDw6bYA7clJZvImwLqLQE0hpJ59OYXxGyKDov3aw85IUtqLrKSxa0jQfYUryesDcnkbIBIpkbsLy8ICxAlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
Subject: [virtio-dev] Re: [PATCH v10] virtio-net: support inner header hash



On 3/15/2023 9:19 AM, Heng Qi wrote:
> 
> 
> 在 2023/3/15 上午11:23, Parav Pandit 写道:
>>
>>
>> On 3/6/2023 10:48 AM, Heng Qi wrote:
>>
[..]
>>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ.
>> I think this should also say that HASH_TUNNEL requires either of the 
>> F_RSS or F_HASH_REPORT.
>> Because without it HASH_TUNNEL is not useful.
> 
> F_HASH_TUNNEL indicates that the hash should be calculated using the 
> inner packet header, even without F_RSS or F_HASH_REPORT,
> we can continue to use the hash value in scenarios such as RPS or ebpf 
> programs.
Yes.
Even for rps or ebpf programs, F_HASH_TUNNEL is fine.
When such feature arrives in future, it above line will have OR 
condition for RPS feature bit.

> 
> 
> I think it's fine to let F_HASH_TUNNEL rely on F_RSS or _F_HASH_REPORT 
> as those are probably important scenarios where inner packet header hash 
> is used.
Yes.

>> If not, for now it may be better to skip vxlan and nvegre as they 
>> inherently have unique outer header UDP src port based on the inner 
>> header.
> 
> Symmetric hashing ignores the order of the five-tuples when calculating 
> the hash, that is, using (a1,a2,p1,p2) and (a2,a1,p2,p1) respectively 
> can calculate the same hash.
> There is a scenario that the two directions client1->client2 and 
> client2->client1 of the same flow may pass through different tunnels.
> In order to allow the data in two directions to be processed by the same 
> CPU, we need to calculate a symmetric hash based on the inner packet 
> header.
I am lost in two directions and two clients above.
When you say two directions, do you mean tx and rx?
and do symmetric hashing between tx and rx between two end points within 
single tunnel?

>>> +\field{hash_tunnel_types} is set to VIRTIO_NET_HASH_TUNNEL_TYPE_NONE 
>>> by the device for the
>>> +unencapsulated packets.
>>> +
I missed this before. unencapsulated is not a term.
s/unencapsulated packets/Non encapsulated packets or non tunneled packets

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

