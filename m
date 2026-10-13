Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE352E064
	for <virtio-dev@lists.linux.dev>; Tue, 13 Oct 2026 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914864; cv=fail; b=kgURv/Tqiaqta/08vt4tPPAH7630qyl9yMzI4sbrY4lteJWeWWiUP5SneaaBLwWXs3gzt2OSGXZFQzP1cWV5K5HIheALD2o04yY71s8M7y8PGco7rStywsPxAKWcsa5+OV+2RRI4Cmctf6Wyycq/UTIanoNr0jfuZtaJpGlD2sE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914864; c=relaxed/simple;
	bh=xSLFsnEPqOtLeTsrn6e30qKlnaY431yTx9d/yNoIZtU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ur8kX7LIIPHPr6qYnEprTds9A7rXlIbDsnGU8ZwmxqwaRRyjXkzm7bPl5ZVsEbks+0zBdkEzlsjRatCr7lZMyvlDLWCDpW+tHlne1A96xLQOv/8lIScv96yyULEdfwJBew+IzNsNPWXdgvBaJx7D0ZvEQzDfQMXrRmRf0ZzrDVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gr97IsvN; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gr97IsvN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5xBk36H/4kh+LTaUmvdROMDv+O+7bS0BSCijIX8ZLUMee24mX5VXtP4NMNCZHZ/HAgqNJAl6Dw5XK7rVFwllAoqoRJqI2fDhTb7TNwlXUCoY71szLlO2z5cZnqBSfmbYNqS6WMTecWUkr7IdmUL5uLk21jQs2UnGtzxyi2WCEdeXVqwrvOMeMYs66R+nfF8Q89JOXInyt3j0xvWtg1oNJu/UPgZOgeG33jQNxkSBlQZIW6WBBPKRMkzsqctfvwpeSFX/mqvn9eB43JrvYBFfUW/agVckdv8drCv2rQ9iohR53QjoFoKcGM/BHqg4Bb/ts9gaMxuLG1TmnaZfImlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpYX3aw/3muX2UisA0Fz59mnXFlGxKzgspvr6o64b98=;
 b=uReCsEMP+7i5H8VMtYOljWc7EibK0tHsQV/LdL2scCu+nztKhxi9CjFFO3vfVtJyMdYmFqzdx/PzNAAPcb+kBaiLOlUymYIpkFezVNJaSxcv0IxMTeui8/P6vvOhkM3BNegjei+p04IcSXS2WCXbjnytRFfdu/P0TVOluolFuVd8tF+SYsp9Uqn/1ldxUPSAxNxXJh1+xrkQIp4tPjj6/l9bMtSCV2OkyjxI0RRam9ywHZdoF5xKQugA/VNnW0670LbeCa5Z0B+ApezjEe7+F61VTRxY2fzSrAqCNT6q/GBpTHywUGZLsteZYqiGROc+0cNvFdOo2fn3284tyD/r6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpYX3aw/3muX2UisA0Fz59mnXFlGxKzgspvr6o64b98=;
 b=gr97IsvN4LVzYfFrdHkbujpiXkX1xpMgYfA5ro0drJu6g4huJZxCjfNO8gLDXXR13XCpB4/j0RiLkCktjHBLyJ/OQSmXM5fvh2vwf8DOOle6ACR/yC0uhggg7JJvwYzVT69zog72COIc5ERajcxdtMEBV5NiEVXaSDiExiidPQByr+EJXNFRD239u8HP+SUg7Kv1X8WiZ9w/3e/pyK0gyhn8xSMB3bJ1ls67xt1pYh9i6O3OVJm1W01ICDjVqpzKmwfpRz2hSF3EvK/mWVqBRzk7+t4QkzMvu+TQ1MkR+K7dUUhFdEZzKU69qKaSMn6cPCZ44uLYoQZug3arcUoS0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 18:07:38 +0000
Received: from DS0PR12MB7558.namprd12.prod.outlook.com
 ([fe80::96ea:b67a:4a5b:85e0]) by DS0PR12MB7558.namprd12.prod.outlook.com
 ([fe80::96ea:b67a:4a5b:85e0%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 18:07:38 +0000
Message-ID: <4ed90e46-0dc9-40ba-b8a9-800d40b34ef9@nvidia.com>
Date: Tue, 13 Oct 2026 21:07:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.linux.dev,
 ebiggers@kernel.org, neeraj.soni@oss.qualcomm.com, parav@nvidia.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
 <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
 <9515779b-a6da-407f-99f2-011e51683d15@oss.qualcomm.com>
 <20261008060644-mutt-send-email-mst@kernel.org>
 <d503aee0-9920-4c0b-b9a0-c08e505cc3ea@nvidia.com>
 <426abc9a-c7b4-4631-a5fe-3b2bba1d0414@oss.qualcomm.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <426abc9a-c7b4-4631-a5fe-3b2bba1d0414@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To DS0PR12MB7558.namprd12.prod.outlook.com
 (2603:10b6:8:133::21)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7558:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: dce8243a-4ba9-4a10-63f6-08df2954dd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|5023799004|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	w+Il0foQ1I+GMwXdzS8rRhJDO7dh2nn+zPJBfqitUjL3XjluY0TnmNADYHF5a/vLfHmtBAZu7+Gc1BekJehWbYoE2ip6xRz0ncijBQa42xG5yfqAaJjPwJhg7IZl32FFVulYN0iAFxgq/z6HybhFcW1B193FB+BsGOtObdjJHE4ZNa3ZFhs9u3yg8AH4Th3tbwGNoh3wxVODoO11U7rdYynKiPVmg0KXrdz8quuvBoJJvspITsQQgAzEOmJakoyZDcg9s8LoC460aIPNukwv8eKlzzBGz7/3MQDCpt7MOSeNyGq2Vz+Tr384LSo7X/r7ekI6SS9TecicArOIIeijqOAbFs80O/Kmf3nSqtGWZUlfv0kbKkNIZVEnB8Z17cUECc7/U+yB8/EaeD7fslWHgFie0qqgIcS+ZYza6E1IRvrT9+DjkHJdVPIbVSQSa0OfWJPRP08EZzVfn2FGKwSmdOJKJvedMboJpldKlUMEEuZaSUzKFKp3xXmPA/hZb5mAPjVuzbEuacOy1aD0RvpHraYwcNBnIGovm5TCKK/YqUGA6ce72+YM9eTZldUgOJIYwZinkooNDrmEAvq8x/kBld3iEvFHV8m/F8KEo4roNr4gMhbHO+5Yhhv/npBRaYgcWnklnMgXfWIaHVgPSUkWmoXwL1Yurm6+WbqovhVZxTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(5023799004)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3NWdDNVN05sTnJGbVp1YWdva2REUThWelFSUUk4bDV3TlNLMk5RVjNzWnNh?=
 =?utf-8?B?VzJWQUpvUHI1TnR5M2hVc0praUUwLzhuN1p4SUQzR0dkVWhhL3kxZm83SUxy?=
 =?utf-8?B?dWpINy9NRjA0MTRhN3QzU2dwOFZnRGNDZGh0ZzkrM3hLZjNiR051NVZKYm5K?=
 =?utf-8?B?OHhPdGFBald2bW5MSnpoWUxPbjY1ZlhSR3FpTkxTNEd2Y2FHUEFwRENYbTRs?=
 =?utf-8?B?S3JnSzJrL0taZERxbnkrbWlxR3pNUG9mUU4zdFFOWGMreExBTnJ5d0VKR2RQ?=
 =?utf-8?B?ZGczTFNrOGgvZDM3eTUrMWtYejUxUmd4cFhtTkdkNFIwRFA5TTVOWm83bTFR?=
 =?utf-8?B?U2pwRlpTU2x3a0FjTDQyMU5tRi92MmtHMExBQnBxaThvNEtMN0Rzak9nZDdB?=
 =?utf-8?B?QWJzdmNjcnpxOFZ0SERTM1dEU1ZkamJlZ0dKMG9OV0JmTys0RjA3ZWExbUdY?=
 =?utf-8?B?WStjTFZiTXFJaDdvL2U3Qlc0WFkrV1lQM3NwWFU2QmYzcFpLNXlCdFRFbjc5?=
 =?utf-8?B?T3krQ0FiQUtxMUtNbmdRU3g5ZnV3UVErTXRyUnpkalNPcXphZFg0MGhabjR4?=
 =?utf-8?B?STRQK2crc1RxajRuQUJSNkFHMUM2QmZTNnlPcXNFRWQvQUtMUTk0cU8zVmx3?=
 =?utf-8?B?M3d6djRNbHdQaFF4Qzd0VjN2L3VNQUtCTXdtQ0g1RUpCMGkyWGd6QWZJT2hs?=
 =?utf-8?B?L2ZURk15S3A2eDlmMU5aNEgvbXlaaWMzcXZRZC8xY0Z0SkJxeUx3KzB5MThG?=
 =?utf-8?B?WENreUYrd09vWnJINXVRbEJiYURkYUlYa0lVY2ZsbmJoN2N2dVNjcWFYYWZS?=
 =?utf-8?B?M1FEUmFjNSs0dG5nYnZUMEpqVkhTS3Vib2E0RDh4bURzNXcrMy9uOUtkRGR3?=
 =?utf-8?B?K0swai83WTZGakRqVWFKRUtKZmZNMEU4c1diaFdYWDFUblVZRU92Nkg4eTdo?=
 =?utf-8?B?ek05cGpBdytrWGNSQlVkRmFnZFQ5a2UxUTlESEkzdTcyNjcxcERLMWhVcFZ1?=
 =?utf-8?B?am15V3BFVmJPQUJoVEtZNGZoeGxtZlZqZnAxWEw2eEdyaDBmOXdydnE5Nkhj?=
 =?utf-8?B?ZDhMRnJ1VkhTS05ZMlF6RlNTUVlZUWN0QnpORzVKcW9DcllPL1luTjNsbGNP?=
 =?utf-8?B?NnExWHdTVS8xT0ZsOTYrNlpHUnhmS1p1UCtJZlFlWWlrbmF2OEF4SjBXUFFX?=
 =?utf-8?B?N1MvcVpVT2g4TVl0SzlVR0VDaFh2UHJxYmd6bXFvM1g1WG5FOTJvNlQ0OS9t?=
 =?utf-8?B?dkNHTjlYUHdVQjZjSTlPUU9qUU5vYWxuM1BRajAycGJ0MjVmaDk0Wi9VQ3F4?=
 =?utf-8?B?ems2b1JCZUhrWHBmU0N2a3pISDNHUUJ1bzVVNGpUOStoTG1lWXQrQmNYUHFD?=
 =?utf-8?B?cTRkUFdhZCtQdHFSUTZJQWczK2VIeW85MTlaMWVjY0hQd1g2Z3hBbnB3V1pH?=
 =?utf-8?B?UDcxWU01RWxJMGFsVkhrQ2ZPV09GdGlFdnBjaGkwMExMd2NWUk8vK3d5NUY5?=
 =?utf-8?B?RVZDd3NYNStudGMrV2xqbkNzdTNTRkR0UXRJOG9XK3JaR1dpZUw4OUdMNldZ?=
 =?utf-8?B?Mk5EZDM3Q21wdk0yWHZxUC9OSnhkenlYU29JK0orM0tUQ29CZ21MOVNSblhh?=
 =?utf-8?B?M0FFQUlVNzJERjhiRlZSVXRseWkzVlBiWmpDNGQ4WWlqWWN4czg2a1d5TkpZ?=
 =?utf-8?B?STBDTkVMdU1JOW90VTE2MytkT3d1MitlOTVIaWRNYXUxdHFaYVoxd1Rzbk5L?=
 =?utf-8?B?dlhZbFRDRVl3UHdKUUhSVHcyZVhjYSsreFpuc29XcURzQkdEajI2d1Z0bkNI?=
 =?utf-8?B?UkE3dGdoMm1WS3lOZ2RXZWlFVHhLL0VJOC9ZdlVaSi9HcGY1Tk1WQWpUU3ht?=
 =?utf-8?B?Umx1My9mOEErM2R3Y1NzL3pJK2xsaUlwWEhFZHlYY2JqcXp0cE1Ja3lqLytV?=
 =?utf-8?B?WEtBWlBXZEN5bWx0MjBpYlA1WVVVWW0xeG9qQ25XTGwzTk42RVNiekdnZDJE?=
 =?utf-8?B?T3VwbGVoVVdWL1JNV0JJWW5yODh2MXppQXY2OXR3cjcyc2h4UVkyY1ZpMXBS?=
 =?utf-8?B?eDhkOXZNMjlwYmkvbFVzaTBDVHI1S3hnTDk0cHMzcmRrMitmZWE2ZDhnTDZn?=
 =?utf-8?B?NzJtZFUwdGhqbXROK0I4ZHF6ckFwMml2bUFzZVpUWk93L2ZoTVhmbFJOZnNJ?=
 =?utf-8?B?a2NVTi9WUjhLbEJLV1RmY3l3QWxhSVBFdTZHMlRUY2hLQVQrc3RlUlN5RGJC?=
 =?utf-8?B?amNtRURwV3VVMjhNbVdoTjBHbXF5YTNQYkRPTlB6Y25aUXVpZHRvOVBWRmhW?=
 =?utf-8?B?VjFJcTJ0eEJBcUE2dkkzSnp3NTFzTit5UHNxTWFDSkVxMGZmSkEyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce8243a-4ba9-4a10-63f6-08df2954dd5f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:07:37.9294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt2Grf7o4eDWu+jUFWsjLOXiYyDTfTlwluWhEXWMxvnpAWHoZFKi9uciJN7LfIuhNI5E6X12nnVYyn5BDuDskw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469


On 13/10/2026 19:23, Linlin Zhang wrote:
>
> On 10/13/2026 7:12 AM, Max Gurtovoy wrote:
>> On 08/10/2026 13:15, Michael S. Tsirkin wrote:
>>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>>>
>>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>>>
>>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>>>
>>>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>>>> state semantics.
>>>>>>>>>>
>>>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>>>
>>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>>
>>>>>>>>>> changes in v3:
>>>>>>>>>>     - Add a control virtqueue
>>>>>>>>>>     - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>>       the control virtqueue
>>>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>>>> implementation. I appreciate it!
>>>>>>>>>
>>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>>>
>>>>>>>> Thanks a lot for your comment!
>>>>>>>>
>>>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>>>> By precise semantics, I mean specifying not just the constants and
>>>>>>> structs, but documenting what each command does and how it can fail.
>>>>>>> Each of the key slot programming commands needs this. There should be at
>>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>>>
>>>>>>> For example:
>>>>>>>
>>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>>>> key information is removed and the key slot cannot be used until it is
>>>>>>> programmed again. The key slot index is specified by struct
>>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>>>
>>>>>>> Stefan
>>>>>> Thanks for the clear example.
>>>>>>
>>>>>> I'll follow the same approach and add explicit normative semantics for
>>>>>> all inline encryption control requests.
>>>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>>>
>>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>>>
>>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>>>> adding another device-specific control virtqueue.
>>>>
>>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>>>> In particular, different virtio block devices may have different storage hardware sources
>>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>>>> encryption requests submitted on that device's request virtqueues. These commands are
>>>> not about the management operation of device group.
>>>>
>>>> There is also a transport compatibility concern. The current virtio SPEC states that
>>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>>>> for that transport unless the proposal also extended the MMIO transport.
>>>>
>>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>>>> fit: it keeps the complete key lifecycle associated with the block device and remains
>>>> usable across the transports required by the feature.
>>>>
>>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>>>> posted for review before October ASAP.
>>>>
>>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>>
>>> Admin vq would make sense if there is complex resource management going
>>> on - like what is happening with all the flow control things in the
>>> network device, since they have extensive functionality for managing
>>> device resources.
>>>
>>> Random device specific commands - I am not sure we want that.
>>> It remains to be proven.
>> Admin vq was added for mgmt/control/admin/non-DATA_IO operations.
>>
>> Fundamentally, it does not make sense to force random device to create new control VQ since we already defined admin VQs for this purpose.
>>
>> We could have introduced control VQ on each device type, but we didn't.
> Thanks for your comment!
>
> My concern is that these inline encryption commands are tightly coupled
> to a specific virtio-blk device rather than providing generic administrative
> functionality.

We've all the needed plumbing in place in the AQ for device specific 
admin commands - see virtio-net specific admin commands.

>
> GET_CRYPTO_MODES exposes capabilities of a particular block device, while
> PROGRAM_KEY and EVICT_KEY operate on that device's keyslot manager. The
> resulting virtual keyslots are then referenced directly by encryption requests
> submitted on the same device's request VQs. The entire key lifecycle therefore
> remains local to a single virtio-blk instance and its I/O path.
>
> My understanding is that Admin VQ was introduced primarily for device agnostic
> commands. The GET_CRYPTO_MODES/PROGRAM_KEY/EVICT_KEY control commands appear to
> be inherently virtio-blk-specific rather than a cross-device interface.
>
> There is also a transport consideration: VIRTIO_F_ADMIN_VQ is currently
> unavailable for virtio-mmio, while the proposed control VQ approach remains
> transport-independent.

This limitation was introduced because we didn't want to add more noise 
when AQ was added (it was already a big change).

Nothing really prevents adding AQ to mmio transport.

>
> For these reasons, I currently believe a virtio-blk control VQ is the better
> fit.
>
> I'm appreciated if you can give any feedback about it.

I think that the correct path is AQ.

Introducing another VQ type for the same purpose (mgmt cmds) seems weird 
and make device implementation harder.

It is much harder to implement a new VQ type than a new opcode in the 
existing AQ.


>
>>> But generally why does this go on a special VQ? Is there a reason?
>> Also in other related protocols the key mgmt goes throw a NON-IO Queue..
>>
>>
>>> You define distinct request types seemingly and we are not short on types?
>>>
