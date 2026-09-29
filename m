Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85537330652
	for <virtio-dev@lists.linux.dev>; Tue, 29 Sep 2026 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790722021; cv=fail; b=uCtErUp438lh7nOVDjII1yolYXkQVswZO5YBIEnwzyN2j/Ar+yt3hn9SSP4DURHK6md9nVOYm/jl9hVa6RyF3e7LFJY4aK2fMffLP8aILQsMnTOwS1wJHN/M0CfH5UFAbFL4qrsP3u4UqDmac0Ti0Uzov3ZamHjTzhjJc+OJ9FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790722021; c=relaxed/simple;
	bh=vfLD2AG6S9bnmZYba/0j90gqdiKCVF95MawvwytiFyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GL297qfLeuwGRr5WyM1yy6bzv56xcWXfmETfwq/YtcxHQ0DNN2x+MNDu9SXzrP7jN4Oo8Aw1K2QAwQS3NWDJ3L2aGX8OLfnWqKxevl9b4SJak82koyTNYEgnPwQOAx7C9T5YWmRy1TVhbr+leuBj0WppWvL0DEEbd3T7BoguxVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nYiRdA1d; arc=fail smtp.client-ip=52.101.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nYiRdA1d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4vLyqjtkUDD0Lav3sMocEioVBwKHfoDYYiOzuh/0GKviTBpMunltnTk2ojXga5AYuwrunCuQ96NRIrFFa+ar1Y/8ZHOth5SwTxqAzkbE7Sf6THDTDNFazOkE03oFIitJxV//T4iwB9K76tFxwk9S//9TAFuCDrTu2zjLKwNvc072O1KnnmW88C5A645V0TUEwju3jiwH3PyT2y16SCMwvZ8vPqXLplL61sQTz8hWIav5grk6Js7RfrBf+byX4SwSNMGXYcu776QnWt+VuNbzmAQTlEI0v7t0JBN8zCNXmER5eyBe5ntOEgF/5csGb9Aip/GrrQtfC1UnYCusW2RbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvkNaITW0HxLp444QVrIn4EQ/NioBxm7WiNOCd6opH4=;
 b=bIyYexsBc10Fx22AUTv4WXTEEynvFFFna/x3ZTT6OJPG39oMK1yRtZNLzpuesUrrRzxr2cQ2Pz8CatYE/a1EdRzPMHl/tz9TkpHl60QIZ+uqvdPOMp0JAVVkBn7+mRAZ8HkHeIJSJrcQYlrXUkbUKHQQ6x5/6/oWjphPDe7GWWXrKJas/jXYFM4KUchQz+KKeN1iC+exMZIdM9MREXRb5pKKNORHeNni+JBrUUMQCHCYUvMHpGcGvyQdBXSGDGAfqk1iMKYQFvtaWVGCr/VINwOMDDiAZzfim3eH8i+s9zyAowA6db8Ai9QHwAtyElcgHzTEO8PLMv1NaZWKqcesBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvkNaITW0HxLp444QVrIn4EQ/NioBxm7WiNOCd6opH4=;
 b=nYiRdA1dcG905wm5YynOAFIS4NpeI+NUVKbOINX1zVlR5kVpPxU/QOjbShNAbOFpYFvZzjJPBc0Nint7nd9DT0cMnnbxezdA5v4oRX9uJxattnCLkXhorQJqMkbZTefJqitdwXg4dIvQdXJbbIIjrOkbnZ547COmQ/bE5pyD3WkXxcCs1XWBfQg4yP+IFAdB9mEeDqep3Q6KFMWi+AYnm5VXmjhoK8qk/2P25Y4KM6Mm+XmCdAH0IMoz3H5WmiSRtbdhw+4ZsZ4z7yFWGaM+BKWKFVMqR2/PLG+1juXxTY+L1TbROeHJU0wbTLaHFHFXbYHmUlOXGmtrgXgCsFoeTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21)
 by PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 22:46:54 +0000
Received: from DS0PR12MB7558.namprd12.prod.outlook.com
 ([fe80::96ea:b67a:4a5b:85e0]) by DS0PR12MB7558.namprd12.prod.outlook.com
 ([fe80::96ea:b67a:4a5b:85e0%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 22:46:54 +0000
Message-ID: <de535820-591b-40f2-b840-d987c3253765@nvidia.com>
Date: Wed, 30 Sep 2026 01:46:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
 neeraj.soni@oss.qualcomm.com
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
 <20260922131442.GB18339@fedora>
 <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <3a933df3-dff7-4ef3-a120-4c6e22c1fcc1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To DS0PR12MB7558.namprd12.prod.outlook.com
 (2603:10b6:8:133::21)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7558:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a26f91c-b344-487b-2f6d-08df1e7b8eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|4143699003|3023799007|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	oP1A+MherBakHvM6BwEj0MB3yYELDMJkBH4gwgwmvRie5wvPaVFewNGOd1VWkIr+v4sheVobIgCkxyQtXonZ3DPhMx92U/RPInUNkV811uxuBeR9cm93sCQcVdt7a+8RVEx81pqJR7Z6QOXLBzU6QKz+5WrM9ramRzbIyS1DzG9azdWKF1NeXdegCTqxJscNj8P+oXwIYhFCGikzAALkc5KbFivTSLvggQwdEwK2OcGGneE6GxRluRpvID7mWj72EjH7COdNuiErfaXd+2wtukWGrMuIuubFbym2tA6apGGZEwWMV9PGda4l22qcdz0vLfH9M5Q4BExUV8kO7WSgkRNuftzsmwloPl9vEkKh7iMTt5QAPNAqN0Uq1HtcOGo8e4pM6m5MfYB7Np85dUtulBSJKwqeC8+nWrCl/QRjm7y54FXW+SD9qTFPZEOUmQWMlGrp3gi0TLWjj3akmgYmA0NfT2/xwIfk5CogxGsmNDLyCkX7uDnM6+4AkTHTqIpjybwKGDQpnZsf08HngGoCLM5E/kGci5gStcCA0XyglQgW1FdvffKkLPGodvYdBBxMKjI5rZBhybkhh39TnCR/2D2TqE1Ps2nZ2HqzS/HYitKu2KS94J0zD32kgI3RTZkqF+hyTU24zOLFHl0avyg+mYt3p9Z359xZA901K1cGdrI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2g3M1FVNkxQaTlmS01HKzU4QjYydzdBYUxmalc3Nm00cGN4VE9NSG8rL1Fm?=
 =?utf-8?B?eGJhYVBVT2NWMEFTT045eDBLcFZ6TENiN2cwczljR1ZjcFUybTdEVDR3Z0xl?=
 =?utf-8?B?dkx2VzVyc1U1RldubEFCbTYwWXNSMjhuYmIyc2VnK3FMQVZ1cU0raEYrckdm?=
 =?utf-8?B?YzV1TlR5dEcybXpZOXlxM0NFQ2xCaGtSWE1GUEgyMGFDdDBzK3ZxNExRTmZ1?=
 =?utf-8?B?U2lzSXl1L2pDZFU1TmtiQzJHOXFFcFMzbVRFdmEyZGxoSktJNXcrR09vZFJp?=
 =?utf-8?B?SXN5SW1DZVRLZGRQSVZKQVg2bWJhQ2oxak15aFdSMlZwU3RESVZubG0rYSsw?=
 =?utf-8?B?MXlPUWprenNSYmM1N0JKcHhuYjd5RHE3UEd1dUdycC9QanFMbkFvcktYV1Zx?=
 =?utf-8?B?aUJPUFB3V2dyQmIvYzUwL1VrbjVrZjc4OG5UTTBFVEhmeXI2SENNOStjSTJl?=
 =?utf-8?B?MkNMbHN0VzYvakpobDJCL2JYanJsSTVQaFJxck5pRE5EQ3ppUGNQdTFIMkph?=
 =?utf-8?B?ckJhQUlDa2svZEJmZjUybnhNMzJBUE0ycUhaNE03ckZEdGMzQ1NMcWRRbzhz?=
 =?utf-8?B?QlVSNXdKaUVHeTdsT3B5MUZiUlhvTW9hNlp1aHBsUmdKQ1JYRVV1Zk1JRzJW?=
 =?utf-8?B?SVVtdXlBRkFTZHY2a0dueEF6cDRuMEJ6N2M3RmtTd080RjhSeVY2blQyb05T?=
 =?utf-8?B?NTJlMGd3YzhwOTNFUko4b290TE91RzExTzBvMU9uYzZmazJTczUzYjZsZE0v?=
 =?utf-8?B?VG45NHFOOUFBb0tZY09TVW92bG1XMUo2bFJWK2NRV084eWZ5VDNvQlRZb0Fv?=
 =?utf-8?B?TElpbWtnaDdtZS9FSXRMeFN5SFphZllEYk90V3RWaEc0ZUhGSlNkM0o4Qmsw?=
 =?utf-8?B?NDVjaXcxMUJZZ2FKYXF4bFFHVE1QL3B6TW9NckJyNVpYdkpoZWNVQWE3NlNK?=
 =?utf-8?B?R0FmcTJrenB6Y29vdWZYN1kybHFEUE9OcTRlbWVXUWgydEFXOXErOVN4YmJv?=
 =?utf-8?B?eWpvZlR0YlFabXdsVlhtaktwUDJReXFZNEpWbEozbWsrKzlCdkJxWUtzWEJ0?=
 =?utf-8?B?UnhqUFg5K2E4c29IdlhqTVhMOXY5cmJsc0E2dURaa0tCcDJFZlNpdGNZWERu?=
 =?utf-8?B?czhsOWRYWXdOQm9sU0JLcHArOGhTeVoyQnZlZU51Tks4ZmlLV01wdzkwZWtt?=
 =?utf-8?B?eW5nbmtrYUZUTjhQbzlUTVVXd0h4cXh6QUR5NGhGWTJmRG1BNHFwTDhhWmNx?=
 =?utf-8?B?M0dNcWtMSDMybEFFS05LaTJpcHhPSncxcm1mUXpNYlRLcVNUQkZZLzZzaERC?=
 =?utf-8?B?REJDVG5kZWkyMXlNbGRibXc0RVk0ZmZuTjJLN0I2YWtIMjlaOXFXK2JYSi9U?=
 =?utf-8?B?bEp6SGxXQVhqV1NZNisrcjBKdlMweVhXZTlaWng0WHRJL2ZiTHEzWHZpdHZu?=
 =?utf-8?B?b2l0cFNlUzd6NnordDBDc2hzZzhUMlZ6MWxIcHhCbzhZVExic0E5RE1NNEsv?=
 =?utf-8?B?WVc1d1kweW13SHhSaXR2Rk1WejZEa2FMQ0ltQm04a0k2Kzkrbm84NHZoZFhn?=
 =?utf-8?B?RXpnNFp4YW9wRDN4MmJkUnE0TE5TNTN4MG5lT2M5NnVVOGFSLy8rejhlR0Iy?=
 =?utf-8?B?eHBuOHp6ZitlaW01bXFQNEFBdTRCVjRRem5Mb2FlSHRPQ0xhMUswQjc5eU16?=
 =?utf-8?B?Y2k2emF6bEhzb25CekNManlHalZ2VlNDZTNJay8ySzdlczBYZmZ1d2dEK29l?=
 =?utf-8?B?a2RrSzBiQS82eHEvRkxiNEg2a0FaNjA4MVd2SkZ0Z3NJcU5UOXNpM3F6T2sz?=
 =?utf-8?B?eVNSRUtQbm9QU1NnQkxrZHFvdjIvUGV5WFllWHBkUjdrNWQrSUlNVlFLNkly?=
 =?utf-8?B?NTJoamdsR3NZaGFnbFRvWHo2MktOZmdMR1VyQmNnZ3dYZG9mSUZNYTBRZ3NP?=
 =?utf-8?B?NythMTJ3ZXZYQm9pTzUxamhPQTlHdDFCUE4yYkdMMHo2WlJXSXJvWVo1UThq?=
 =?utf-8?B?T0FMSXRibFhjQmdlcFpjN2d5WTVkOG5qV1JXemZkamd2dlM4UGhpdEQ3OEI5?=
 =?utf-8?B?cGVURmxrKzdTT0h2TXU2NkVXZVNtL3l6MHQyMU5ZakVCR1J0NkNrVk53S2da?=
 =?utf-8?B?ZTNra1ZKVVI5b3JxMTQ4RzZDcGlBYlVIbnd1NzVseWZyVjdnRXlhQ001RlRh?=
 =?utf-8?B?VGdraXdEVGhNTW9pc002VllDaitkem54eWVwbHZnS2xGc0hpSUxJNnpQdHFZ?=
 =?utf-8?B?c1BrTXp6cFFSZ3o0VzNoRExyL0c4ZCtjcURSUVdMSlVjWU81YkhCQ20wcmMx?=
 =?utf-8?B?T1JHMzdwUGNIUjhuNG9zQUoxWTB2S0U4RTMvZUtBTjlrbE12WlJSZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a26f91c-b344-487b-2f6d-08df1e7b8eff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 22:46:54.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdUqBwj/n957y38THwz0j8lZZNX1JHBgZmXrDw5KAcBonzvXmuDQ38M74acwP2JQ7XQHuyzpjGTEgeg/Mm1pTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605


On 24/09/2026 12:35, Linlin Zhang wrote:
>
> On 9/22/2026 9:14 PM, Stefan Hajnoczi wrote:
>> On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>>>
>>> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
>>>> On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
>>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>>
>>>>> This series adds virtio-blk inline encryption support for devices backed
>>>>> by storage hardware with an inline crypto engine.
>>>>>
>>>>> The protocol exposes device capabilities such as keyslot count, maximum
>>>>> DUN size, and supported key types. Encrypted requests identify a
>>>>> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
>>>>> capability discovery use the block device control virtqueue.
>>>>>
>>>>> The control virtqueue is defined as a generic framework so that its
>>>>> buffer layout and queue placement are independent of any particular
>>>>> control command. Inline encryption then builds on this framework with
>>>>> explicit crypto command formats, capability validation, and keyslot
>>>>> state semantics.
>>>>>
>>>>> All key related operatios are handled in the control virtqueue, and
>>>>> the crypto I/O request is handled in the request queue.
>>>>>
>>>>> For background on inline encryption in UFS and eMMC storage, see:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst
>>>>>
>>>>> changes in v3:
>>>>>   - Add a control virtqueue
>>>>>   - Move key program/evict/derive_sw_secret/generate/prepare/import to
>>>>>     the control virtqueue
>>>> Thank you. This was a big change, especially if you already have an
>>>> implementation. I appreciate it!
>>>>
>>>> My main feedback is that the new control virtqueue commands are not yet
>>>> documented in enough detail so that implementors could implement them.
>>>> Once you've decided on the precise semantics, error codes, etc and added
>>>> them to the spec, then this will round off the inline encryption
>>>> feature. I look forward to reviewing that in the future.
>>>>
>>> Thanks a lot for your comment!
>>>
>>> Would you please help clarify what the precise semantics are about? detail
>>> introduction of the filed in the inline encryption control command struct?
>>> like struct virtio_blk_crypto_key_desc?
>> By precise semantics, I mean specifying not just the constants and
>> structs, but documenting what each command does and how it can fail.
>> Each of the key slot programming commands needs this. There should be at
>> least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
>> VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
>> VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
>> VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.
>>
>> For example:
>>
>> The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
>> key information is removed and the key slot cannot be used until it is
>> programmed again. The key slot index is specified by struct
>> virtio_blk_crypto_key_desc \field{slot} and all other fields in the
>> struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
>> slot index is valid, including if the slot is already empty. If the key
>> slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.
>>
>> Stefan
> Thanks for the clear example.
>
> I'll follow the same approach and add explicit normative semantics for
> all inline encryption control requests.
Can you please explain why we need to introduce yet another VQ type for 
control?

We've added the Admin VQ as a generic VQ for control operations — I'm 
not sure why it isn't sufficient.

Adding control VQ to each device type seems strange to me after adding a 
generic Admin VQ.


