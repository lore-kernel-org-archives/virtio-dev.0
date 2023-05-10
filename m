Return-Path: <virtio-dev-return-12632-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFA9C7EE23
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:13:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8DC661462D1
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:13:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 862AE9865D0
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:13:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7BB1F986590; Wed, 10 May 2023 16:13:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 683BF986591;
	Wed, 10 May 2023 16:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h55UnbjdHKV/LznuVR9zEHBtLdcp1ZrCA5b6UeO3L1DigNnwQeBnRTCfE5BFIl7vEjp9vjmHU8HHB/Q6dx1mqjgO4gK1yhn2cTvygd1Jl3VDk0Pq11SppEWqpR+8BWDM1jANQB7eZMCPBYlZ29Zgl3WLdi00W3xU+oHbwyN5jWTQIDngj5siAHvE/e2xeJns2nRYXKGJFCpIVlpBveWjtTdAeJQ8D8foekSWR9bGkmiifY6M3KbXfqBwQqyIxlaxDMHjdhY8ZsIgaF+U5dOtei/6RBoUN66iBjzzcB6dEioYSN3nFfYb//XrlUVb00Kl0gnLn/YvVZA2KorsdX8Q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woE4ajJHxKTMkOI1XCkmGXZaZbaDRvS/f5Xr2aj29Q8=;
 b=ghjONG/GiFEMFnGB3tjreSwNIoIbqFodGOs60hwss4j4BTAQ6jWGj3ZzlF08ZyUIFoOiq+xjbK+By1adkqEIWFdX/57zyBEqkkdt4F9rDgFMvEtZywRxHGroxYcsgB9XZrGd50pJ+kyLn9DDl1nfs803yx2z3S/cOZRH42tcJKtTfOh2VZIb4oUTYykBqgDevgldV9BjOsXMqaWv9wMsyYFCa9JB+QdFa6f3qCySzNrHMBkWEyf/6+lOlvx3mFUSZ13lgvcSVwgpE2pn03LfjRzmlumSYdthnMsKGlt8nus5H8rA3AmjcSiYPyIGkeWl9vZqP28NgYAstu+TfJV5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <ccde4c12-93e6-b7ea-db68-b59056c9d81c@nvidia.com>
Date: Wed, 10 May 2023 12:13:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 david.edmondson@oracle.com, sburla@marvell.com, yishaih@nvidia.com,
 maorg@nvidia.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230510033812-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::6) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: d03369a7-d547-4fa4-87ce-08db5171842b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MyWXJHSH3Oof+H62yZDFe8sxCZ6pRj3YKjaTnis5C/RneqsznGP1IeRiR5MRvnWbhemnohbGnnGUhScj/fmZLxwmkWtPIZW/ROLKSD9Np/ZPo38YMOeHu0anXorsydIiQF54I0PF3DJQSAvksrxEtrajwCMF11GZJK3RaJlpIaMVtq7bdAt9pHYpsyrFaPL6gOBt4W7RyEEZ/9/GMOqMMIY3Wh5rARvYzNSEm1aGci2W9ZoIm6eyabUy+uX8Vb4oTtmK4Cyd11ttpPKlBLYcNRyb6SYQ9Cl2zTQchGaOG01ljne0LnagEG16rwfwvuWIOOYeQpv3M1LFrQAyVHVepNB8CqDXE8VtIBy4fi3lWp0BZnqkwT2WSr8eerQFjiQleRAN1X3gz3K0XVn8pfopwlaRz00dTse+z6q+/gGtLY7g7O4hwEi2KC+8VEyHuDKO2+kjtKnwmTsCu25AgmS32BzWGZ9i1Sn8MZJ0TKJIo9BTlE0Yda/ceVc9oq61MzkR+Vr+0T6JpaZQjYLQiXzpmOlLY824yeSVKsL/Z7Di9uVKiIkGJ7+3T4wXHJH1uILWoo5VdaJEHQWQRKFe07n2hBoTWn+lc3JblbdTCnwiuUyCvLwz6VF2PnuAO6XaxZkkKidHmNytHQDtIz4io35Mgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199021)(31696002)(36756003)(66476007)(86362001)(4326008)(110136005)(66556008)(316002)(66946007)(478600001)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(186003)(38100700002)(6512007)(107886003)(2616005)(6506007)(53546011)(83380400001)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDFLNWN1aExoa29wZmsyWWQ2b084aHZ2NStvSldZQXlWWHdlclFrb2RhNXFR?=
 =?utf-8?B?M0hhaWdRWjlRMHp1em5pU2gxNUk4QkNXWUdkOGdSRFVUS3NmVUgrb056TVY3?=
 =?utf-8?B?R2tKbE1jVVBJcDJ4MGhuU2M3M2dmTkllVDdwOXc5K0xBNnNnSHFzbm9ROUtE?=
 =?utf-8?B?Z2pOa1g5N2sxZ2xXZjJxK1pvZU5FVUFtZGxKWVQyRm9sRUljeFhVY1owRWNT?=
 =?utf-8?B?MXRWcjgvSkRBckszUkZFa2pVcHJjdG96M05VY2prYjh5bncxRFVwZjRDRVMw?=
 =?utf-8?B?aSs2VEZEVjR5UTN3aHM5bGMweCs0bVErMlI1cUhUbndLRUhrMHhoY0xQYXZs?=
 =?utf-8?B?T3ZSUXVTTHNQV1JPVkFkWHNDdEhrWk55MWsyUTZQdjFTdzFpNWY4Tys0U3lm?=
 =?utf-8?B?ak4zMlZaQ2RNUW85TlVncW9GOFVBOGd1OEhlMEZMM1hxQU8yOXhYemlpcS8w?=
 =?utf-8?B?akxtNXBleVVCWGJOQVVDNmg0K0ovMXlKUVBTbmJwam9hV3pvMHpDQ2RPd2xZ?=
 =?utf-8?B?SGhxL2k4WmFGR2M5NmIzZlYzOXorbWhNcFhveDJteGU1VGNzNGRzb3lua3Yv?=
 =?utf-8?B?QjV4eHlkSVlXRjZqSVB6T3hIcklYbkZXK0xCbTZFS1V4NC9LM2VTWmlyNGJ4?=
 =?utf-8?B?UGVXTUJWOU1oNU14Q2tMdWJIN2Z6aUJDZCtrSkRFMGRranJvclluU3Vaalov?=
 =?utf-8?B?eUZHMC85UE5uN0gzRkp3WG1VaVVhYmJXWjlzcnhZbENNazFWUWMralcwR0cz?=
 =?utf-8?B?eTlXL1Y4d0svbnU5RWt3N3ZURXNCOS9LVXlWbzJpN0QwM21KUnFnT01Qd1hp?=
 =?utf-8?B?dHpNWjNvNWlQcDBPdzlSb0FzWkNxVlhweTJFeTAxanIxcmxQQkE1QjB2Qnhp?=
 =?utf-8?B?TDdWVzlOdHhXRGE0SWVQZE1hSjJyYU1XNDV4TUM1VWx4NTZOaEw2OVJxVE5t?=
 =?utf-8?B?WWxIdEFUR3QvV2dGSTFKRHhGMEpYbFh5N0RocG5CcHNSTk5keDFLRVVSZTE0?=
 =?utf-8?B?endUcFdPWnVTR3BPMitJQXhmekFTK2RGTkgzMUd1VXBPNXVXS1QrTitrKzBE?=
 =?utf-8?B?OEFSY05KTHozSEVjMEtrV2FPb05oUXlZK2MxNzZzR1U5b2x6aHVRRVpDSWxB?=
 =?utf-8?B?bmhOVmRDb0V6UFBrb2RXMkk4ZmdBSk1MdEZpeVlZcFp5R25hMXl5TVI1OVpK?=
 =?utf-8?B?S2k1UkdseWZjZVBqZ2kxWW00dmY4RTF3L0lqVkJEWjUyeDhIakJqOGZOa1Bn?=
 =?utf-8?B?WWp6QWt5WmJBUXNQYTJTY3hsbUVJay9NZE5kWHVzenF0N2lGcXZhSG5obXhx?=
 =?utf-8?B?K3p3cjdMUmVtYXJ1amNKTGtvbGovSG5ieGRSclJ6SDlKbmVUOFdZakdZT09a?=
 =?utf-8?B?N1Q0Y0ZodTQrMWVBQ0F0UVNZRmx1ZVpJclQySE5SaWErMnY5LzMwWmVDS1J6?=
 =?utf-8?B?UkU3Q1Ywd01mcldNNGJKd0piZVRyMDVVWmNpQ0d0S0RTNFVSdE5QLzBDTEhU?=
 =?utf-8?B?TDl1T1NyK0VTcUlVeEVrbzU3Z3MyU0o5M2hNdzFvQkt2blBnT3NlMXUwRTB6?=
 =?utf-8?B?THhSMGI3VlkwVzlVdEpEWlZZeXVWcGRrdzRmRWlEMmxnNnBjVjNQZUtGWDZx?=
 =?utf-8?B?VWdsdFd5aXVBalhKdTJXeFIxRENkUzdxYjY3T0xGc05uTzYvVXJRQ0FYNTZu?=
 =?utf-8?B?UGNOOUVtZnc5Z24xNlRwZ3NOL0dFWFpadjNsWVo4QldoRyt4TVpicitOVWly?=
 =?utf-8?B?bzUzbWFGOHZyT2htaHpVS3NwTXR3TERmRzcxTlRnTzNBNGRsVlN6c1ZDVlBr?=
 =?utf-8?B?OXgxejN6M3NzN3cvczRFRFhVUXZ2NkRlTnM1b2lJVVlseVdQVlIya0ZZSkVH?=
 =?utf-8?B?VlJkVUdTQUFBV2NUYVdCRjRTREx6bituZ0dHNVNUQkRZL0tTYkNTajY1QnF1?=
 =?utf-8?B?Y2hOcFZWU1BQUG9lb3JERnB3bDhkOFVjUThZcW1nYWFMcG16aWNBb29qTUdx?=
 =?utf-8?B?RVpBTFJYbzZIOVpzaVhaM1Z1NUVVWWFydkI2UmxUTzRmU2MzaEFEMk1vQThE?=
 =?utf-8?B?YUtvaUVMaGJZeW15RXAvcHg5eTZ2R2RjN1RvMmFOWFpDaXZRSmMvbTZ2ZDd2?=
 =?utf-8?B?SzhuWGVLbjkzdEpET1JRV0hZbDZ1d0lnL04waWxZdFF6cHBIQ2hKZFQ4cEVS?=
 =?utf-8?Q?Si5EA13lkWcJKaDZkP09uFab/vSMuRfg8TP68YF6ne7F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03369a7-d547-4fa4-87ce-08db5171842b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 16:13:39.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00dGw0Bskj92hY0sw/xcPGJAoNmM3a9K/0krtCb8aVwLKps/dtTdHs6v7wtBkbEvQp8QM60tRkyztuLMUMKk7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6193
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ



On 5/10/2023 3:43 AM, Michael S. Tsirkin wrote:
> On Wed, May 10, 2023 at 03:01:25PM +0800, Jason Wang wrote:
>> On Wed, May 10, 2023 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
>>>>> I thought so too originally. Unfortunately I now think that no, legacy is not
>>>>> going to be a byproduct of transport virtqueue for modern -
>>>>> it is different enough that it needs dedicated commands.
>>>>
>>>> If you mean the transport virtqueue, I think some dedicated commands
>>>> for legacy are needed. Then it would be a transport that supports
>>>> transitional devices. It would be much better than having commands for
>>>> a partial transport like this patch did.
>>>
>>> OK I am beginning to get what you are saying.  So your criticism is
>>> this: what if device supports vq transport for modern, and we want to
>>> build a transitional device on top.  how will that look. yes?
>>
>> Yes. I think it needs to be done through the transport virtqueue
>> otherwise the transport is not self-contained.
> 
> I mean, any feature can be done over transport vq.
> 
> But there is value in adding legacy commands to an otherwise
> modern device without reworking it completely to
> switch to a different transport.
> 
Yes.

> 
>>> A reasonable thing to include at least in the commit log. Parav?
>>>
>>> You are also asking what if the device uses transport vq,
>>> and we want transitional on top of that.
>>> It's a fair question but I don't exactly get why would
>>> this legacy support feature be wanted for the vq transport
>>> and not for other transports.
>>
>> Not sure I get the question, but all the existing transport support
>> legacy, if we want to have another, should the legacy support be a
>> must or not?
> 
> This specific proposal is for tunneling legacy over admin vq.
> It can live alongside a normal modern VF, with hypervisor
> combining these to create a transitional device.
> 
True.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

