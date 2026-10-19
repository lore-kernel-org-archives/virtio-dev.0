Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBF4F405B
	for <virtio-dev@lists.linux.dev>; Mon, 19 Oct 2026 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413389; cv=fail; b=HTDy6vtGD3dG5k3UtzGULPJqGxHL/ffMZlIoLc6IV8t7d207Kr4UkVp4x6fuUZW0BkqSnlL+J7n8VhJQSicQb1XebK+wP5v9H99xYnlcoMEJcIxOOCEaNAfB5gztX2K7SeliO74N0wi6ZCmNuMhzu94oUSe/HK9kCdxgIiRw0Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413389; c=relaxed/simple;
	bh=IYoQLkj+bvhLtbkorWTbrZdT9SQzyCQ7fWaacq4m/5Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G3x41fkS+S5ULdKoc7sK0p2zxrSRU//jo3DoOmfkWKpyOYfSgpuVugE64RKBRKNyIyfAaeuOBDKgOachLdLXgA9Y4txWHrVPPgcHcZsZYKAWzYSrljIuFN0omPp65H7hUcCeuLFznyqZCvzTy3OLyypJv9cmHDQECWn5GVrMrYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lakHgo6B; arc=fail smtp.client-ip=40.107.208.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lakHgo6B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZX/dvQXk5NeygHnrDSsBDNOS65eKUa23oYtiqkPJAsh2X/Pmc3G3Kk8TN/ENCON9zg1Ft4GB/6POwgusoJIpyD/tMluDEP0czaS1R4w1XAJbjGZoW+9UQcD6SR5ShuitkQN0yxZMAiPH9OpxpU9QILp6fMD4Rtq00WYZMQntcGWYZgjKqQ7mM4koDPE5/LZSOCQkLUZFqxCBfFW+xYKEmRVBFn2VruVDU7DolE1bGgpKP/2Bwbcpcfs7XLHCSVzrjxh9TDlbeOY6nF20hbj/URcJErS6Y0XKz1SN0GwRDXvTbjS5LM5BxnPJVtRIbZ/iBh5QNHo6mB1v0CTC/FtDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWJ0GO0DvoyuicsHJGr+I/iLhstQx6lF07vdiySZCIU=;
 b=tQTVr8EIzQrBT6AXWyXe570fanxktscxVlGeBLvUSNaPtcwjhzQ9zcTO6r3pufvFOj71r4LJYnmI3EwLIHqSMgbw8QF2Ts0CGrs6tkwllIftaO8Gn0cP+1+Myhjqc51dUywcLrjknnAPaxWxecbVuAlSbR0rK28Yn9X90g2zMQkfnb/J0adwgvQt4vdoo5lPvjMRGqAO579542hnEaHhhQWXx+4EYXSOm/YPWLCQtC41aNwu99mzO0o+xlVsWqqm1SOaDuU+ulVg0YQ1iD3NF1eYFWBTrLSgxFo9Ca8xbhwHug0pqrOIvKOr0S5DH859FYl7EPNttIHAZTBf1SlKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWJ0GO0DvoyuicsHJGr+I/iLhstQx6lF07vdiySZCIU=;
 b=lakHgo6BhVp24POhzk1ELaP1F0jZRdQUnwVPpH8IkQb5LeKaE4Vb+CRL4/uRZBCpo0kxnA21XtntropUwbKyQfMjolfC98M1Mxmr6kkslNiloVbFPXGKxz8AdyHaWisKhnZ4wV+S8BQd7318y5wU6JbCEDXLF1qNniGhjsDDGyUDJTsVzOGi6TzV8/mvsxNEfpO+5xLYuXAWnaktz/0k2XRbxmuDMdNsUGH8/3+KxHSS6j+RIee4ZgUELJpC6jYEcXBG7y8mp++rS1XwIi5cHpcwLKBfd2bPI/t+HcZQZ7m0UxgaEH+3YC9K38jMMmYKWYFAOrj3RXC3CPksr5pOJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:36:11 +0000
Received: from DS0PR12MB7558.namprd12.prod.outlook.com
 ([fe80::96ea:b67a:4a5b:85e0]) by DS0PR12MB7558.namprd12.prod.outlook.com
 ([fe80::96ea:b67a:4a5b:85e0%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:36:11 +0000
Message-ID: <81464321-5371-433b-9373-10818b7dc014@nvidia.com>
Date: Mon, 19 Oct 2026 15:36:06 +0300
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
 <4ed90e46-0dc9-40ba-b8a9-800d40b34ef9@nvidia.com>
 <01f3caa9-a1c3-4511-a104-7179ce1791f8@oss.qualcomm.com>
 <0b6fa40c-5a79-4047-9c20-d5c83dc7ee6c@nvidia.com>
 <a78eab07-9192-4725-905e-6f38d7fbac85@oss.qualcomm.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <a78eab07-9192-4725-905e-6f38d7fbac85@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0155.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::12) To DS0PR12MB7558.namprd12.prod.outlook.com
 (2603:10b6:8:133::21)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7558:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f48c0c-8145-42cd-7605-08df2ddd8e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|5023799004|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QgpJc2+cDc6w4tUSTov965JCEWuZ/hfu52t7QQ9fElCgzIHj+fw+7s9ht9BeNa1WTN7drh99fLxBZk4GCLYihScdCZifqntgPC5Qpfhigq1KWcmWkNtip45bMBRxTbpKS2wN5U0aLMkt3aXkpxX29lFw4wU0MXXWASo2qRnuMTzrvfOdhwqQr90a9v5CVHrkbLtYyARZL/J4gZPH0d94pPZOqX2ujDSlV4ZVjB4E5XtFJP+02OWUHqqj1voYBJ5RDyid6NO/iX6TL80zkIkKJ7MDuuTT6+Kvohh2XroKPqkK0ldGqcGPPgo7H8w0xB6GmXgrqoUn6JR/+8vRNMChC284ayYBWKyOlJ9p3dKOPHI3yUhlmD9SIi3OGU6t8Ea5n2T+3f//kZHB2bh8iDcAsf0w8i1qTOCpPS8VIc9CWbfzm8KnAonMhY0fQxd109Wv5bigdezl98O2N9Qgj0EALgGXoJAPrEovFFflF93b6YdNxpnDKTZr8gQMORaybYFaSZEf/RryX89FFQweNI3W2QqMJTBRDQGN9qMlue3p3696K5Rc8t0h0Pe0x+hH/zXS4BKpqRay4pvtn+qqiq7aBuxSi7ZSAYTyaCYmsev2GPhO2F4OwN+dyNDcGDjNc8wJJkaFGW3rYmVLnUfAWvZBiLlxXVgCgmWGJ2SWOxsGjes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(5023799004)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzZ1KzE3cmJEKyswUktESk5Gb1JROGhxYUpzbFA5K2JxQmRSWnp4RnV3d2pz?=
 =?utf-8?B?RnVTd3h5aVgwOFFXMElST1hSOWR5L3BHRnZESE1odWFpcDVTaTdveXR5RFdB?=
 =?utf-8?B?TWx3MmgxdDk5Vk9aVldwZkREcWRXaEtZUEFBN0w4T3VtVUo5elhlRXdRTXRw?=
 =?utf-8?B?dkFVbCtqWFB0SWtiVGpRN1FYKzFITnkrbksxamJsVE9IMWN5aW1lajRoQU9G?=
 =?utf-8?B?RGVRLzRhRWtZcTRpQ09JUUhhTjdFSVJHL21MUis3djE0ZmdZRVFUbkczOGFJ?=
 =?utf-8?B?WDZIWDNEMWVBdnFqT3NocHZsbXExUWMzZ1kzOUQ1ZnhYSXJhSWQ5ODhCeWdQ?=
 =?utf-8?B?VnQyeTFOb1l2WU1xN0tneml4MXVLMzZ1NjNiQ0NXbFlUcDAyVnJ5eUlYQlNE?=
 =?utf-8?B?ZG5HYkozclFpbzdTMVByYVFZeitrQWJHeVVrMm5YY2dxTkZOcU8vVENMVy8r?=
 =?utf-8?B?OUthSUhOVWtlMmVMYlFRcW5zbGZnUGZQQ2U3UTVDMmJNejRMckU2Ymdrdzgx?=
 =?utf-8?B?clpIa2p3UmpEZy9hQkVtY1EvM1RBZWFMZXpaZmVMbUNDZEw2MTlFMGxEeUk5?=
 =?utf-8?B?Tk1FUUp4Mk1LQmFXaG80R1lLSzNWRE5FTDVFbnlaVHAzZTA0U1lPeUU0bytB?=
 =?utf-8?B?d1BkUjZoclE2UTUrdStmb0syTkY2bGdqbE9ndFVkdFdoeWlKcWZRZG5yK1Rh?=
 =?utf-8?B?SEdMMHd0N1A0VFMyVlgrOVVHazRvUi9aalg0cTVHNHhDeis5a2ZGSFJFY2Qx?=
 =?utf-8?B?K3VDa3NPWlcxMEF2WDBWNzh2clJCRGNOUUM0RmNpelFaMmVyazNkdHVYb2V1?=
 =?utf-8?B?a2svQ1BaMHpGd0R4VjlkR2dOZyswcE0zVVFRNnZScXpPbUVYcHlZbTFrUCti?=
 =?utf-8?B?UnZJcmU4OGVpV0RWTGJFYWsySFExcmRac3Y1S3E0RklVQ2FXTGxQcWNkaXZn?=
 =?utf-8?B?Mk80ZG82aEY2UUZYU1VSN1N2bThIMjFpdDZZTVVvakZJRUZjbGJ6eXJpdkQw?=
 =?utf-8?B?TFphVU90UnE2ekVQQkN0dXQzS2p6anVDRXc1T2pLQUJxWVlldklhdXhnTUhR?=
 =?utf-8?B?eGdGYUNQbnByNFlUc3hVUkVVdkY1bStNcXJMbDJ6MmlHSC9aTjdUTS94WjlR?=
 =?utf-8?B?MHZSWStTWUFaYURFK1RGcGhsWXNxSmdsZUtaVmlLOFhGdGtyNENDZVFMekRh?=
 =?utf-8?B?eFdhb1VZdVBQZmt1bkI3N3BiTzNtcy9WL3ZaL1pEdzNZVndFTEhveDVNc3hS?=
 =?utf-8?B?bGNQeUpvL3JPTVZwaHpMcThWbjF4RmxHTEcrMDJTUWE0d2Y5bWE4dlV5ekRR?=
 =?utf-8?B?bEZ1aEc1RUtERWJxd1hSSDV1SkxOb1gwc1RGZTFnV3htRUJ2UHVHV293UGpa?=
 =?utf-8?B?TEpjaUtDZ1ZvSEhRMHJzUzcyMUhiTU9ueC9uMjVHblJOdXRVaEVDaHpVYTd0?=
 =?utf-8?B?L1I4dlRva3M5ZUhJUHRWVHNITlZWMUhadkJxZlhYd2hjcHc2dDg3UTFmMW55?=
 =?utf-8?B?Nnd5S2dibTYyZks1ZGZpUzd5T1NJZG4wVXdGN3B3aUxsK2VpU1FPclhTaHNY?=
 =?utf-8?B?OVUzdkRGRFlVUHlVSlFKRGhuVWdtWTZpRjJVRldUZ3JzSS9tTjRLTzBTM1VS?=
 =?utf-8?B?NXROOGhWZHNYUmJTS09aNFNFMXdOV0tuMG9ncHRKSmRZdHl5RVplNEJzR0cw?=
 =?utf-8?B?UHpXRTlNV2VNeXBOYW9xNGJDMTVJRE9Pbk9tMktsNnM1UHQwNW1qVUx3Wk04?=
 =?utf-8?B?bFRYNWlhOGFFUzQyTFhUdkJSalFnKytLMzRZY0NPelpENUV0bXhLQkZ4SWdX?=
 =?utf-8?B?Z0l0TEQwYlVQRjFCSzdkZGt6RW54WnZsZHpyVDFtTmJyNjl3WE9mWWZFUFN2?=
 =?utf-8?B?TXIyRjZtYXB5VnNMOUVvek9OQkc5V05GUVFIRm9ZbjFPMysvYTlxd1RtRkdh?=
 =?utf-8?B?WEwva1RlMFkrdXpKS1RQM0FiakFIdWg3UFYxc00zYjVoM0x5UGVtcFV6SWlu?=
 =?utf-8?B?eWR6ai9CSHl4SHBFVnBxN3d3c2ltcXJDOGZPU0c4azR0cWNJYTM1bWRMK05o?=
 =?utf-8?B?cGdlQWgvTDVjYjI3QmIwWVVsOHBEQ1FQc3FhblJKUGh2MnJJU2VOWkx3VHJx?=
 =?utf-8?B?bGVnMFYxV1dKWHBla2cyU0J6MHhzc1pHaHRZeHB3Z0htNm5kY2tCMk5tdEFZ?=
 =?utf-8?B?Z0ZFcW9Pem5QUmI5N0I3Ulp4d3lNRy9uVHVuZlozVSs0Lys4WlQ1SU5JU2tn?=
 =?utf-8?B?eURVRjFPOERDK2g4RS8rZHRZUXdZYTZPdXpSblJDa0NrTWtRUHQ1N0xsZjR5?=
 =?utf-8?B?KzA1U0pwRmZDRktqMjlYYlRCRzk5YXdXdW5MSEhjSCtEU2JvcThTZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f48c0c-8145-42cd-7605-08df2ddd8e5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:36:11.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCPn1xQ/US9XEuc92QOcK8/f8k3+cxMcx9o4eAj5Op2/ZF/Y0bPN/bkGe/qSkSaZHsnxsiEseyOJrXKy9e1v6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202


On 19/10/2026 12:24, Linlin Zhang wrote:
>
> On 10/15/2026 8:01 PM, Max Gurtovoy wrote:
>> On 15/10/2026 14:19, Linlin Zhang wrote:
>>> On 10/14/2026 2:07 AM, Max Gurtovoy wrote:
>>>> On 13/10/2026 19:23, Linlin Zhang wrote:
>>>>> On 10/13/2026 7:12 AM, Max Gurtovoy wrote:
>>>>>> On 08/10/2026 13:15, Michael S. Tsirkin wrote:
>>>>>>> On Thu, Oct 08, 2026 at 05:17:30PM +0800, Linlin Zhang wrote:
>>>>>>>> On 9/30/2026 6:46 AM, Max Gurtovoy wrote:
>>>>>>>>> On 24/09/2026 12:35, Linlin Zhang wrote:
>>>>>>>>>> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>>>>>>>>>>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>>>>>>>>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>>>>>>>>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>>>>>>>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>>>>>>>>>>> by storage hardware with an inline crypto engine.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>>>>>>>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>>>>>>>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>>>>>>>>>>> capability discovery use the block device control virtqueue.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The control virtqueue is defined as a generic framework so that its
>>>>>>>>>>>>>> buffer layout and queue placement are independent of any particular
>>>>>>>>>>>>>> control command. Inline encryption then builds on this framework with
>>>>>>>>>>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>>>>>>>>>>> state semantics.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> All key related operatios are handled in the control virtqueue, and
>>>>>>>>>>>>>> the crypto I/O request is handled in the request queue.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> changes in v3:
>>>>>>>>>>>>>>      - Add a control virtqueue
>>>>>>>>>>>>>>      - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>>>>>>>>>>        the control virtqueue
>>>>>>>>>>>>> Thank you. This was a big change, especially if you already have an
>>>>>>>>>>>>> implementation. I appreciate it!
>>>>>>>>>>>>>
>>>>>>>>>>>>> My main feedback is that the new control virtqueue commands are not yet
>>>>>>>>>>>>> documented in enough detail so that implementors could implement them.
>>>>>>>>>>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>>>>>>>>>>> them to the spec, then this will round off the inline encryption
>>>>>>>>>>>>> feature. I look forward to reviewing that in the future.
>>>>>>>>>>>>>
>>>>>>>>>>>> Thanks a lot for your comment!
>>>>>>>>>>>>
>>>>>>>>>>>> Would you please help clarify what the precise semantics are about? detail
>>>>>>>>>>>> introduction of the filed in the inline encryption control command struct?
>>>>>>>>>>>> like struct virtio_blk_crypto_key_desc?
>>>>>>>>>>> By precise semantics, I mean specifying not just the constants and
>>>>>>>>>>> structs, but documenting what each command does and how it can fail.
>>>>>>>>>>> Each of the key slot programming commands needs this. There should be at
>>>>>>>>>>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>>>>>>>>>>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>>>>>>>>>>
>>>>>>>>>>> For example:
>>>>>>>>>>>
>>>>>>>>>>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>>>>>>>>>>> key information is removed and the key slot cannot be used until it is
>>>>>>>>>>> programmed again. The key slot index is specified by struct
>>>>>>>>>>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>>>>>>>>>>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>>>>>>>>>>> slot index is valid, including if the slot is already empty. If the key
>>>>>>>>>>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>>>>>>>>>>
>>>>>>>>>>> Stefan
>>>>>>>>>> Thanks for the clear example.
>>>>>>>>>>
>>>>>>>>>> I'll follow the same approach and add explicit normative semantics for
>>>>>>>>>> all inline encryption control requests.
>>>>>>>>> Can you please explain why we need to introduce yet another VQ type for control?
>>>>>>>>>
>>>>>>>>> We've added the Admin VQ as a generic VQ for control operations — I'm not sure why it isn't sufficient.
>>>>>>>>>
>>>>>>>>> Adding control VQ to each device type seems strange to me after adding a generic Admin VQ.
>>>>>>>> Thanks for your comment! And I agree that the Admin VQ should be considered before
>>>>>>>> adding another device-specific control virtqueue.
>>>>>>>>
>>>>>>>> My understanding is that some of the inline encryption commands(get_crypto_modes/program key
>>>>>>>> /derive_sw_secret/evict key) are runtime operations of a specific virtio-blk deivce.
>>>>>>>> In particular, different virtio block devices may have different storage hardware sources
>>>>>>>> of crypto modes, and keyslot programming and eviction are invoked through the block device's
>>>>>>>> keyslot manager, and the programmed virtual keyslots are subsequently referenced by the
>>>>>>>> encryption requests submitted on that device's request virtqueues. These commands are
>>>>>>>> not about the management operation of device group.
>>>>>>>>
>>>>>>>> There is also a transport compatibility concern. The current virtio SPEC states that
>>>>>>>> 'Devices and drivers utilizing Virtio Over MMIO do not support VIRTIO_F_ADMIN_VQ'.
>>>>>>>> virtio MMIO is extensively used, so using the Admin VQ would make the feature unavailable
>>>>>>>> for that transport unless the proposal also extended the MMIO transport.
>>>>>>>>
>>>>>>>> For these reasons, currently I believe that a virtio-blk control virtqueue is the better
>>>>>>>> fit: it keeps the complete key lifecycle associated with the block device and remains
>>>>>>>> usable across the transports required by the feature.
>>>>>>>>
>>>>>>>> I would appreciate any feedback or insights from you and Stefan on the V5 patch series
>>>>>>>> posted for review before October ASAP.
>>>>>>>>
>>>>>>> Fundamentally, it does not make sense to force all vqs to be admin VQs.
>>>>>>>
>>>>>>> Admin vq would make sense if there is complex resource management going
>>>>>>> on - like what is happening with all the flow control things in the
>>>>>>> network device, since they have extensive functionality for managing
>>>>>>> device resources.
>>>>>>>
>>>>>>> Random device specific commands - I am not sure we want that.
>>>>>>> It remains to be proven.
>>>>>> Admin vq was added for mgmt/control/admin/non-DATA_IO operations.
>>>>>>
>>>>>> Fundamentally, it does not make sense to force random device to create new control VQ since we already defined admin VQs for this purpose.
>>>>>>
>>>>>> We could have introduced control VQ on each device type, but we didn't.
>>>>> Thanks for your comment!
>>>>>
>>>>> My concern is that these inline encryption commands are tightly coupled
>>>>> to a specific virtio-blk device rather than providing generic administrative
>>>>> functionality.
>>>> We've all the needed plumbing in place in the AQ for device specific admin commands - see virtio-net specific admin commands.
>>>>
>>>>> GET_CRYPTO_MODES exposes capabilities of a particular block device, while
>>>>> PROGRAM_KEY and EVICT_KEY operate on that device's keyslot manager. The
>>>>> resulting virtual keyslots are then referenced directly by encryption requests
>>>>> submitted on the same device's request VQs. The entire key lifecycle therefore
>>>>> remains local to a single virtio-blk instance and its I/O path.
>>>>>
>>>>> My understanding is that Admin VQ was introduced primarily for device agnostic
>>>>> commands. The GET_CRYPTO_MODES/PROGRAM_KEY/EVICT_KEY control commands appear to
>>>>> be inherently virtio-blk-specific rather than a cross-device interface.
>>>>>
>>>>> There is also a transport consideration: VIRTIO_F_ADMIN_VQ is currently
>>>>> unavailable for virtio-mmio, while the proposed control VQ approach remains
>>>>> transport-independent.
>>>> This limitation was introduced because we didn't want to add more noise when AQ was added (it was already a big change).
>>>>
>>>> Nothing really prevents adding AQ to mmio transport.
>>>>
>>>>> For these reasons, I currently believe a virtio-blk control VQ is the better
>>>>> fit.
>>>>>
>>>>> I'm appreciated if you can give any feedback about it.
>>>> I think that the correct path is AQ.
>>>>
>>>> Introducing another VQ type for the same purpose (mgmt cmds) seems weird and make device implementation harder.
>>>>
>>>> It is much harder to implement a new VQ type than a new opcode in the existing AQ.
>>>>
>>> Thanks for your comments!
>>>
>>> I agree that reusing the existing AQ avoids introducing another VQ type in virtio-blk.
>> I'm glad that we're aligned on this one.
>>
>>> My concern is that AQ is currently not supported with virtio-mmio, and adding such
>>> support appears to be significantly more involved than introducing a
>>> virtio-blk-specific control VQ.
>> I don't think that this is a good enough reason for introducing a new VQ type in Vblk.
>>
>> We need the best spec definition, one that will serve us for years to come, rather than worrying about 1-2 weeks of additional effort (to a task which is completely orthogonal for adding enc to vblk, IMO).
> Thanks for the clarification.
>
> I still have one concern about using the Admin VQ here. Since the inline encryption
> commands are specific to a particular virtio-blk device, how does the host
> determine which virtio-blk device an Admin VQ command applies to?

Not sure what do you mean.

An admin virtqueue belongs to one virtio device (the owner), and every 
admin command carries
a group_type and a group_member_id. The spec defines a Self group 
(group_type 0x0, member id 0x0)
that contains the owner device itself and no other device.


>
> I couldn't find a host-side Admin VQ implementation, even for virtio-pci. Could you
> please point me to an existing implementation or example for reference?

there are examples in Linux for AQ usage for LM and vNET special configs.

>
>> The high level spec enhancements I envision are:
>>
>>    * Allow ADMIN_VQ on MMIO - Remove VIRTIO_F_ADMIN_VQ from the “reserved” MMIO list. Update the feature-bit text to align.
>>    * Add two read-only registers to the MMIO register table, mirroring PCI’s admin_queue_index and admin_queue_num. They are valid only when ADMIN_VQ is negotiated. My suggested offsets are 0x0c4 and 0x0c8, which appear unassigned in my version.
>>    * Reuse the existing queue flow. PCI’s rule refers to num_queues, which MMIO lacks. So either reword it as “admin index is above every regular queue index and index plus count stays within 0x10000”, or add a NumQueues register.
>>    * State the Self-group scope - An MMIO owner device supports only group type 0x0. Other group types fail with INVALID_GROUP, following the existing validation rule.
>>
>>
>>> Given this constraint, Admin VQ support in virtio MMIO will impact the inline
>>> encryption support on virtio block, so, I prefer to the virtio-blk-specific
>>> control VQ as this requirement is a more widely and general request, especially
>>> in the virtualization platform with a Android guest virtual machine.
>> This is not a constraint worth considering a non-optimal architecture.
>>
>> Creation of VQs takes device resources. We prefer not introducing new VQs if not needed. Adding a new opcode is more reasonable for your requirement.
>>
>> Imagine a block device with N resources for VQs: N-1 for request VQ and 1 for Admin VQ. If we need to introduce a new CVQ then it will be instead of one request VQ resource.
> I agree that the new CVQ would take the place of one request VQ. For a virtio-blk
> device with N VQs, this would leave N-2 request VQs, with one CVQ and one Admin VQ.
>
> I agree this is not ideal. However, if there is no way to handle these
> block-device-specific commands through the Admin VQ, a dedicated CVQ seems necessary.

Anything you can do with the CVQ, you can also do with the AQ.

>
>> I prefer having a correct architecture.
>>
>>
>>>>>>> But generally why does this go on a special VQ? Is there a reason?
>>>>>> Also in other related protocols the key mgmt goes throw a NON-IO Queue..
>>>>>>
>>>>>>
>>>>>>> You define distinct request types seemingly and we are not short on types?
>>>>>>>
