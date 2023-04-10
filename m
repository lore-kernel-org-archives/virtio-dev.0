Return-Path: <virtio-dev-return-12095-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB4FC77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 17:54:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 136C72AC56
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 17:54:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 061FF9863C9
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 17:54:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F089F98631E; Mon, 10 Apr 2023 17:54:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC41F986321;
	Mon, 10 Apr 2023 17:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKgbTHRQ+lWnZUWfaZE4UQ5D+SrOEImKpQ42cG98V6YXEbIxeVSAoxwb590y+dq0LWJs+naQWWr/kYcSLiey+j4wiqYjDqvX6U/Eo7nHhpuq3YdD9OyKyw6vgYZ/J+Po3lcls3vbs1WNQ2/2NaKgwaM5hDZ5jPTVoLBne8hhFxLWltElH209nRHH0Teb0tFb6ymV8wqNleG7Ls/WJel+Mq3xu5n7edEtGKzW2hCqjEBr7HEiPWdCYT85YT2iKGynhIeEnti0Iu4KoELyh1nn4xp63747Ax6vDzwNF/OXs0R56Jb/8TH2TegC/zhlQpdurXKgY3MKjtDOWauekgYbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTJ2ZRZuX8pmaodX1K1tt8vBV+U0+u1QhopZQVPAh0I=;
 b=G2GNJyfVxZk8b5go8w/eoOKjiCLo3QSZ9s0G+9gToav73CB9/rR9LdcL5y7sSam64fkX99Ox5OHd5ImQYHCYSkHhdQBcVnXy1y32GdheeHSPPe7pOXy/s8rxbdaCgP6uwrv7fuJT7ci6VUHzqvcvRuQ64zwUn7Do5uTmRT27x8awrPgbu/uOU9mgUsQgNTmTySiSiYelYY5PrIEEYW5qQr4IvFbiE0Y6Q6Da2fuTDt9hXWlJFcx2oSPuiXVTMfCm7/RalXaqqUFvAYKruN1zqqiRQtMG5GXUpOZQcqMrtBfVsecRqcGPrnE5rRXT2Lgu+jO9vDFWGfMe7N98cDaevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Message-ID: <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
Date: Mon, 10 Apr 2023 13:54:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
 Satananda Burla <sburla@marvell.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:806:d1::8) To PH0PR12MB5481.namprd12.prod.outlook.com
 (2603:10b6:510:d4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5481:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: 537e6c53-d604-4c79-3dd3-08db39ec94c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A+EjnDWhFpezT4/ysE8ehkZqQSKrAy7UUYNd6MICe1C3bLfKcAsg9BO9yvXlyx8arnxHF9kd3u883S+BenwRGWpIB3pii70fSmo+c3+TPzubFlqPEemPjzrGtE1FDgCCHN9gfhlAb1+IP2vhWM15AoHxXnUBtUgMV+LwoTZsp9fs3JAF/JK9e5s3tQwP67IqHmGwNWBjZfXCXShMqml+zn+4rwv23xWGpuPatogUaqw2+ATkvJtPlNFCZKSYd45TagDWA5/q26Nrng1VzgU3kUsW7eaPT24vFpl9+505bKuB+BKI+yZldVZlgK4yAQE8wNkSOC46/E3W3ZHzuxHRrn8YPdj9JQw5QkFB8s8wBfNOJkJPNewlvSzccx12XXpLZV6LpfCDPGfXoDdCj0fTmen7ZukhpNMTuYMIjOblmg0D5Wz+MSresuEHYixiIW3buSdmjP8vvFGjPC1o0jfwMkIzlmnSSFHQritBR8n18y/GVZmrLXUXHooA9KdvzUqSVM6pMMVUUeRrueLhDdlZQJIo2n57jxFEo2vrVt63BfeQVOLkifNg4yUdRAPqQXzyp8uixjjEl7ysl346Z5AwesdKXDvE5kFLpLipMUqNWIRhlIxqTt3fXgbjpF4x+032hoizRiq3hFfObidQJaq2NocQLt+F8O5LS+++UFk9tUIPn7mm7SBQZpznpfQvQqib
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(316002)(31686004)(38100700002)(66556008)(66476007)(8676002)(66946007)(86362001)(31696002)(478600001)(6916009)(4326008)(83380400001)(2616005)(186003)(41300700001)(36756003)(26005)(2906002)(53546011)(6512007)(6506007)(8936002)(6666004)(5660300002)(6486002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkYvZjQyeTJyM3pYeG5MdERLNFVGYm5CZVBERzcvOUV0U3NvZHFONXd3cnl6?=
 =?utf-8?B?RGRJa3R4NmgyRFJsaEhCdS9UN0ZrbTUrQ0lXL253d21VSEplZXlaSFJ3NnJP?=
 =?utf-8?B?azgzSjdWMGpDV0hMRytlbm5DQVlkL2lMbFpXcVM2eC9ZaVA1QVJzVHNBS0ww?=
 =?utf-8?B?dXN5bGRrS1R5R1FuNG1LeHlTWkNsZWkvUnp2YUJjTE9IejlpMHA1VzhwZUpt?=
 =?utf-8?B?TUptSG5OUlFZQWtwclZ0YUMvVkNQWE16N3pKK1B0citjVGZVdW54MSt1UGJm?=
 =?utf-8?B?elFCTmtSc1NDVnVmaDM3Q0tZQ2VucmpRRHppaFBTV0RJZm9DaEE3N0VXWEtq?=
 =?utf-8?B?VWNDbERTUnJpelMvNGRHMDRjZXZKUHJzRXdBMEQ1Z0hPT3hqSDI1QTZpYXU0?=
 =?utf-8?B?TXlnNTZtYnN6QmhhSHJsVTBvNUs1WUprV25XMVNCdjVQZTN2KzRhNnYrdklo?=
 =?utf-8?B?UnAzNjkwS3JYeHJ6alpjL04vR2M1QzM4WHgxN0s2NlVwbTV5am9BR055b1Fi?=
 =?utf-8?B?MktwamhKckViN0E2MzBrSUZoMC9UTlQwM3ZKOGpUQmh5NDg0SnV6eEt4S0c3?=
 =?utf-8?B?dm8ybVMrd2ZHclF4eTRBNmxJTWtxWWIrS1Mybll0YmFUU2xJdTVjRmZUS3hK?=
 =?utf-8?B?UEF3SXA1Z0JzbFhFeklJWXZnOXgzUm04K0NDdFpKQUFYbVNKL0pyRTArWlNU?=
 =?utf-8?B?OVBOMDNsN0pqUlFyeE43MWUyNlhRaHhkQ05NZnNKK3Z3N2RZUDBmVHlFMFlz?=
 =?utf-8?B?aUorWjZRUm5sSVBBSk9qRUhxbU9QcTk0THNFZzhVOFd4VDBCelc1Y1JPdkha?=
 =?utf-8?B?V3FjWkkxQzlML0o0YlpvM2Roc0oyRFpUUk9GaUNWakVJcUNHM3cyVkJ1dk56?=
 =?utf-8?B?WVZMeVI0bVVrdk5vRzR5S1J0S0Urc1ZVSFZLanRseVFvZ1ROM09CazlBRVc2?=
 =?utf-8?B?c21ZU0pLeU5LWVV3MkVHdFR0N1dXbWV2QXR5QUJlWjYyQVRSajU0Rzc3czRk?=
 =?utf-8?B?RWUyVjc3RVExaGJWRVNnZXhWaSthZHo2QUJGY3JOVEhwbnd2ekd3SFQxT2ta?=
 =?utf-8?B?U3gyT3pncDdjUC9STFpBOUNpT3VER0dCWXpRNzJsZ2llV0xWTkV1SzBPcWF5?=
 =?utf-8?B?bE9EZzJVYnRqZFNwamN2RHE2ZGJUaFByTXVOZzlwNVR4WjVndjZJVzIrdWp5?=
 =?utf-8?B?N0ZPMWFqZ0dWbVdBa3pxSHlzRTdodWxGVGJDbG8vYWtsUUQvdU0wRlM0cmYv?=
 =?utf-8?B?K3BoY3ZtOXNjTzlJZnZTb1BtcVNtNUh5RzNmWHUyV2djcVlCTUwxWVpRT05E?=
 =?utf-8?B?SERFR0xDVVZRMG5zN0RQcGtQK2VEZUJzKy9LeThiUkJja1poMmtJalljWVN6?=
 =?utf-8?B?WUdDS1h4ZStvMERDUld6Y016WS9tT0dhdGpxcHdsQ0xYdHNWbGE0N3ZROWJ5?=
 =?utf-8?B?b0VLSlYwbVF2YUs4N1N4dHhKd0dpeXZBSjFyRGZSbDFwVFUxcjBhaHJ6MUIw?=
 =?utf-8?B?ZUNvNTVVVk9IOW5veHkyeWQyYmFxdXRrRzk5Y1JlSEVmUVlFNmxPa1d2MDhD?=
 =?utf-8?B?dHQyV3FQMitrQWFGOENZcmdtYld0UEJ3VmhsWXVJcGpTOENCL1htci83eFNE?=
 =?utf-8?B?MWJiSW1acWdhbldCR09nODJNMlZWSGxEODV5ZWxvRWJRTzMwejE1c1orUzc5?=
 =?utf-8?B?cytrSlgvZjRvMmF3TkE2a3I1Q0NZemFHcHpwVm0zYVJuMWVHenQyRWY0RVVh?=
 =?utf-8?B?WkVlYy9vTFJRWEF5bCtOQ25NaS8zeDlaRG5id0hMVktVcm5PaUJCVFdINER2?=
 =?utf-8?B?dGIrd0lZK1lrRkFhd09aME5MeWp5T0MyOWdJQkh6QllqeTdwQVhqT0R1RXpT?=
 =?utf-8?B?K3lidmhtSmFvR1ZEcWgySElaU0FJeVZpM1hEZFJ2c0hzZnBHeUljUzh3Q3J3?=
 =?utf-8?B?Y1l6eGpqOVVsM0x1VWI0Y0NIZHdBc3RqNWtqeVBOYTZndnlDSlFMYjN6dVFl?=
 =?utf-8?B?WlRHbW9GdjI5SjN6dWlNZE5QcTV2bUp3dVRFZkM4SmNqRGVmVGVzSm5KN1lz?=
 =?utf-8?B?TWROQnpPUzRTcXRhZzZidzkra1FnSFBGbVp4YXhqVUpBdjgrTTd2THFRTXFS?=
 =?utf-8?Q?Jt/pp6BCxgV/91HEpC3N/r0wX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537e6c53-d604-4c79-3dd3-08db39ec94c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 17:54:07.7175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3jKB6KuBgUSeDa4WPydgSb9hXUTroP98h79ezcHscf7Jaq4YJMWLDI31Sj+rP8Z0ViqiW502rvwEDWEP0VarQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

Hi Jason,

On 4/9/2023 9:36 PM, Jason Wang wrote:
> On Fri, Mar 31, 2023 at 7:00 AM Parav Pandit <parav@nvidia.com> wrote:
>>
>> PCI device configuration space for capabilities is limited to only 192
>> bytes shared by many PCI capabilities of generic PCI device and virtio
>> specific.
>>
>> Hence, introduce virtio extended capability that uses PCI Express
>> extended capability.
>> Subsequent patch uses this virtio extended capability.
>>
>> Co-developed-by: Satananda Burla <sburla@marvell.com>
>> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> Can you explain the differences compared to what I've used to propose?
> 
> https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08078.html
> 
> This can save time for everybody.
> 

What is proposed in this patch similar to [1].

The main difference is, the proposed new capability is always placed in 
the pci extended capability section,
This is because legacy capability section is nearly to its full level as 
described in commit message.

So providing it at either of the two locations is not valuable.

What you proposed in [1] is in general useful regardless;

However, it is not backward compatible, if the device place them in 
extended capability, it will not work.

To make it backward compatible, a device needs to expose existing 
structure in legacy area. And extended structure for same capability in 
extended pci capability region.

In other words, it will have to be a both places.

Otherwise its similar.

We should do this regardless, and it will also make this series shorter 
which is also what Michael prefers.

Would you like join efforts with me of drafting [1] + above description 
as independent patch?
We may need it even sooner than this because the AQ patch is expanding 
the structure located in legacy area.

[1] 
https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08078.html

PASID part of the patch is not relevant here, so will skip to comment.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

